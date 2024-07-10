import 'package:flutter/material.dart';

/// The `MessageWidget` class in Dart is a widget that displays messages with different styles based on
/// the sender (either "You" or "Server").
class MessageWidget extends StatelessWidget {
  final String message;

  const MessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMe = message.startsWith('You:');
    String sender = isMe ? 'You' : 'Server';

    return Align(
      alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(left: isMe ? 10 : 0, right: isMe ? 0 : 10),
            child: Text(
              sender,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isMe ? Colors.blue[200] : Colors.green[200],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: isMe ? Colors.blue[100] : Colors.green[100],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
                bottomLeft: isMe ? Radius.circular(15.0) : Radius.circular(4.0),
                bottomRight:
                    isMe ? Radius.circular(4.0) : Radius.circular(15.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: isMe
                      ? Colors.blue[100]!.withOpacity(0.1)
                      : Colors.green[100]!.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              isMe ? message.substring(5) : message.substring(8),
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
