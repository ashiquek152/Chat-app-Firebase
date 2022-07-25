import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/modules/chat_screen/controllers/chat_screen_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesList extends StatelessWidget {
  MessagesList({Key? key}) : super(key: key);
  final _chatScreenController = Get.put(ChatScreenController());
  final User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      reverse: true,
      padding: const EdgeInsets.only(bottom: 85),
      itemCount: _chatScreenController.messages.length,
      separatorBuilder: (context, int index) => const SizedBox(height: 10),
      itemBuilder: (BuildContext context, int index) {
        final data = _chatScreenController.messages.reversed;
        final dataAtIndex = data.elementAt(index);
        return BubbleNormal(
          text: dataAtIndex["messege"].toString(),
          textStyle: const TextStyle(color: white, fontSize: 16),
          bubbleRadius: 15,
          isSender:
              dataAtIndex["sendBy"] == currentUser!.displayName ? true : false,
          color: black45,
          // delivered: true,
          sent: true,
        );
      },
    );
  }
}
