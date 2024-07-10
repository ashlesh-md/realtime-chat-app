import 'package:flutter/material.dart';
import 'package:real_time_chat_app/widgets/chat/message_widget.dart';

/// The `ChatMessages` class in Dart represents a widget that displays a list of messages with a scroll
/// controller.
class ChatMessages extends StatelessWidget {
  final List<String> messages;
  final ScrollController scrollController;

  const ChatMessages({
    Key? key,
    required this.messages,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: MessageWidget(message: messages[index]),
          );
        },
      ),
    );
  }
}
