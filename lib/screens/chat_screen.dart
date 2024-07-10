import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../blocs/auth_bloc.dart';
import '../widgets/chat/chat_messages.dart';
import '../widgets/chat/message_input.dart';

/// The `ChatScreen` class represents a chat application screen with WebSocket communication, message
/// storage, and user interaction functionalities.
class ChatScreen extends StatefulWidget {
  final bool routeFromSignup;

  ChatScreen({Key? key, this.routeFromSignup = false}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final WebSocketChannel channel;
  List<String> messages = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    channel = WebSocketChannel.connect(Uri.parse('wss://echo.websocket.org'));
    _loadMessages();
    channel.stream.listen((event) {
      _addMessage('Server: $event');
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      messages = prefs.getStringList('messages') ?? [];
    });
  }

  void _saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('messages', messages);
  }

  void _clearMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('messages');
    setState(() {
      messages.clear();
    });
  }

  void _addMessage(String message) {
    setState(() {
      messages.add(message);
      _saveMessages();
      _scrollToBottom();
    });
  }

  void _sendMessage(String message) {
    String formattedMessage = 'You: $message';
    _addMessage(formattedMessage);
    channel.sink.add(message);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 200,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Chat Application',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.black,
                Colors.indigo,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10.0,
                offset: Offset(0, 5),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            tooltip: 'Clear Messages',
            onPressed: _clearMessages,
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            tooltip: 'Logout',
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LoggedOut());
              if (widget.routeFromSignup) {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, Colors.indigo],
          ),
        ),
        child: Column(
          children: <Widget>[
            ChatMessages(
              messages: messages,
              scrollController: _scrollController,
            ),
            MessageInput(onSendMessage: _sendMessage),
          ],
        ),
      ),
    );
  }
}
