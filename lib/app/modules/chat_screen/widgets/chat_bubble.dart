
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/modules/chat_screen/controllers/chat_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatBubble extends StatelessWidget {
   ChatBubble({
    Key? key,required this.message,
  }) : super(key: key);

  // final TextEditingController chatFieldController;
  final String message;
  final chatScreenController =Get.put(ChatScreenController());

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      seen: true,
      sent: true,
      delivered: true,
      tail: true,
      text: message,
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
