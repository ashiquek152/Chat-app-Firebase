import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chat_screen_controller.dart';

class ChatScreenView extends GetView<ChatScreenController> {
  ChatScreenView({Key? key}) : super(key: key);
  final chatFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          opacity: 40,
          image: AssetImage(
            "assets/HomeBg.jpg",
          ),
        ),
      ),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: transparent,
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      return BubbleSpecialThree(
                        seen: true,
                        sent: true,
                        delivered: true,
                        tail: true,
                        text: "Message $index",
                        isSender: true,
                        color:bluegrey.withOpacity(0.8),
                        textStyle: TextStyle(
                          fontSize: 17,
                          color: white.withOpacity(0.9),
                          fontStyle: FontStyle.italic,
                          // fontWeight: FontWeight.,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                  child: TextFormField(
                    // maxLines: 1,
                    controller: chatFieldController,
                    style: const TextStyle(
                      color: white,
                    ),
                    decoration: InputDecoration(
                      hintText: "type here...",
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 10, 20, 1),
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.send_outlined,
                              color: white,
                            )),
                        fillColor: white.withOpacity(0.5),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25))),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
