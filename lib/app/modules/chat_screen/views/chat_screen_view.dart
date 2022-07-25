import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/modules/all_users/controllers/all_users_controller.dart';
import 'package:chatapp_firebase/app/modules/chat_screen/controllers/chat_screen_controller.dart';
import 'package:chatapp_firebase/app/modules/chat_screen/views/chat_frirend_profile.dart';
import 'package:chatapp_firebase/app/modules/chat_screen/views/messeges_list.dart';
import 'package:chatapp_firebase/app/modules/home/controllers/home_controller.dart';
import 'package:emoji_selector/emoji_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreenView extends GetView<ChatScreenController> {
  ChatScreenView({
    Key? key,
  }) : super(key: key);

  final currentUser = FirebaseAuth.instance.currentUser;
  final _chatScreenController = Get.put(ChatScreenController());
  final _allUsersController = Get.put(AllUsersController());
  final _homeController = Get.put(HomeController());
  final chatRooomID = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final data = _homeController.chatterDetails[0];
    return Scaffold(
      appBar: AppBar(
          title: Text(data["name"]),
          backgroundColor: transparent,
          elevation: 0.9,
          leading: IconButton(
              onPressed: () {
                _allUsersController.getAllUsers();
                _allUsersController.searchController.clear();
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 35,
                color: buttonColor,
              )),
          actions: [
            ChatingFriendProfile(
                imageURL: data["imageURL"],
                userName: data["name"],
                email: data["email"]),
          ]),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 8.0),
        child: Stack(
          children: [
            StreamBuilder<ChatScreenController>(
              stream: _chatScreenController.getMessages(chatRooomID),
              builder: (context, snapshot) {
                return GetBuilder<ChatScreenController>(builder: (context) {
                  return MessagesList();
                });
              },
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: black45, borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext subcontext) {
                            return SizedBox(
                              height: 280,
                              child: EmojiSelector(
                                onSelected: (emoji) {
                                  _chatScreenController.chatFieldController
                                      .text = _chatScreenController
                                          .chatFieldController.text +
                                      emoji.char.toString();
                                  Get.back();
                                },
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.emoji_emotions_outlined,
                        color: white,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _chatScreenController.chatFieldController,
                        decoration: const InputDecoration(
                            hintText: "Message...",
                            hintStyle: TextStyle(color: bluegrey),
                            errorBorder: InputBorder.none,
                            border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.attach_file,
                        color: white,
                        size: 30,
                      ),
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: buttonColor,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: white,
                        child: IconButton(
                          onPressed: () {
                            _chatScreenController.sendMessages(
                                chatRoomID: chatRooomID,
                                currentUserName: currentUser!.displayName!);
                          },
                          icon: const Icon(
                            Icons.send,
                            color: buttonColor,
                            size: 25,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}






// Sharis3:28 PM
// @override
//   void didUpdateWidget(_) {
//     _scrollController.animateTo(
//       0.0,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeOut,
//     );
//     super.didUpdateWidget(_);
//   }
// Niyas Ali3:37 PM
// google_sign_in: ^5.4.0
// Salman muhammad3:41 PM
// _googleSignIn.disconnect();]
// Sharis3:46 PM
// https://medium.com/flutter-community/flutter-implementing-google-sign-in-71888bca24ed
// Sharis4:26 PM
// https://stackoverflow.com/questions/53869078/how-to-move-bottomsheet-along-with-keyboard-which-has-textfieldautofocused-is-t