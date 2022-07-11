
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.chatFieldController,
  }) : super(key: key);

  final TextEditingController chatFieldController;

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      seen: true,
      sent: true,
      delivered: true,
      tail: true,
      text: chatFieldController.text,
      isSender: true,
      color: black.withOpacity(0.5),
      textStyle:  TextStyle(
        fontSize: 17,
        color:white.withOpacity(0.7),
        fontStyle: FontStyle.italic,
        // fontWeight: FontWeight.,
      ),
    );
  }
}
