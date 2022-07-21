import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/db_functions/db_functions.dart';
import 'package:chatapp_firebase/app/modules/chat_screen/controllers/chat_screen_controller.dart';
import 'package:chatapp_firebase/app/modules/home/controllers/home_controller.dart';
import 'package:emoji_selector/emoji_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreenView extends GetView<ChatScreenController> {
  ChatScreenView({Key? key, this.userName = "", })
      : super(key: key);

  final currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseDB _firebaseDB = Get.put(FirebaseDB());
  final _homeController =Get.put(HomeController());
  final chatRooomID = Get.arguments;
  final String userName;
  // final String imageURL;
  // final String email;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          opacity: 40,
          image: AssetImage(
            "assets/new_bg.jpg",
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
            title: Text(userName.capitalizeFirst!),
            centerTitle: true,
            backgroundColor: transparent,
            elevation: 0.0,
            // leading: Padding(
            //   padding: const EdgeInsets.all(5.0),
            //   child: GestureDetector(
            //     onTap: () {
            //       Get.dialog(
            //         Center(
            //           child: Container(
            //             height: 200,
            //             margin: const EdgeInsets.all(20),
            //             decoration: BoxDecoration(
            //                 color: white.withOpacity(0.8),
            //                 borderRadius: BorderRadius.circular(25)),
            //             child: Center(
            //                 child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //               children: [
            //                 // CircleAvatar(
            //                 //   radius: 65,
            //                 //   backgroundColor: white.withOpacity(0.3),
            //                 //   child: SizedBox(
            //                 //     height: 120,
            //                 //     width: 120,
            //                 //     child: ClipOval(
            //                 //       child: Image(
            //                 //         fit: BoxFit.cover,
            //                 //         image: NetworkImage(imageURL),
            //                 //       ),
            //                 //     ),
            //                 //   ),
            //                 // ),
            //                 const SizedBox(width: 10),
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     DefaultTextStyle(
            //                       style: const TextStyle(),
            //                       child: TextCustomized(
            //                         text: userName,
            //                         textSize: 18,
            //                         textColor: black45,
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                     ),
            //                     sizedBox10,
            //                     // DefaultTextStyle(
            //                     //   style: const TextStyle(),
            //                     //   child: TextCustomized(
            //                     //     text: email,
            //                     //     textSize: 16,
            //                     //     textColor: black45,
            //                     //     fontWeight: FontWeight.bold,
            //                     //   ),
            //                     // ),
            //                     sizedBox10,
            //                   ],
            //                 )
            //               ],
            //             )),
            //           ),
            //         ),
            //       );
            //     },
            //     child: CircleAvatar(
            //       // radius: 50,
            //       backgroundColor: white.withOpacity(0.3),
            //       child: SizedBox(
            //         // padding:const EdgeInsets.all(),
            //         height: 120,
            //         width: 120,
            //         child: ClipOval(
            //           child: Image(
            //             fit: BoxFit.cover,
            //             image: NetworkImage(imageURL),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.back();
                    _homeController.searchResult.clear();
                    _firebaseDB.messages.clear();
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 35,
                  )),
            ]),
        backgroundColor: transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  children: [
                    StreamBuilder<FirebaseDB>(
                      stream: _firebaseDB.getMessages(),
                      builder: (context, snapshot) {
                        return GetBuilder<FirebaseDB>(builder: (context) {
                          return ListView.separated(
                            reverse: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _firebaseDB.messages.length,
                            separatorBuilder: (context, int index) =>
                                const SizedBox(height: 10),
                            itemBuilder: (BuildContext context, int index) {
                              final data = _firebaseDB.messages.reversed;
                              final dataAtIndex = data.elementAt(index);
                              return BubbleNormal(
                                text: dataAtIndex["messege"].toString(),
                                isSender: dataAtIndex["sendBy"] ==
                                        currentUser!.displayName
                                    ? true
                                    : false,
                              );
                            },
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                    color: const Color(0x54FFFFFF),
                    borderRadius: BorderRadius.circular(20)),
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
                                    _firebaseDB.chatFieldController.text =
                                        _firebaseDB.chatFieldController.text +
                                            emoji.char.toString();
                                    Get.back();
                                  },
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.emoji_emotions_outlined,
                            size: 30, color: white)),
                    Expanded(
                        child: TextField(
                      controller: _firebaseDB.chatFieldController,
                      decoration: const InputDecoration(
                          hintText: "Message ...",
                          hintStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 16,
                          ),
                          border: InputBorder.none),
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.attach_file_outlined,
                            size: 30, color: buttonColor)),
                    GestureDetector(
                      onTap: () async {
                        await _firebaseDB.sendMessages(
                            chatRoomID: chatRooomID,
                            currentUserName: currentUser!.displayName!);
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0x36FFFFFF),
                                    Color(0x0FFFFFFF)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight),
                              borderRadius: BorderRadius.circular(40)),
                          padding: const EdgeInsets.all(10),
                          child: const Icon(Icons.send)),
                    ),
                  ],
                ),
              ),
            ),
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