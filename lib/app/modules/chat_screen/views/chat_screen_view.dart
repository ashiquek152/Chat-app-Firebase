import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/db_functions/db_functions.dart';
import 'package:chatapp_firebase/app/modules/chat_screen/controllers/chat_screen_controller.dart';
import 'package:chatapp_firebase/app/modules/home/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreenView extends StatefulWidget {
  const ChatScreenView({Key? key, this.chatRoomId, this.userName})
      : super(key: key);

  final String? chatRoomId;
  final String? userName;

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  final chatFieldController = TextEditingController();
  ChatScreenController chatScreenController = Get.put(ChatScreenController());

  @override
  void initState() {
    callMessages();
    super.initState();
  }

  callMessages() async {
    await chatScreenController.getMessages(widget.chatRoomId);
  }

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
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.userName.toString()),
          centerTitle: true,
          backgroundColor: transparent,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Get.to(() => HomeView());
                chatScreenController.messages.clear();
              },
              icon: const Icon(
                Icons.close,
                size: 35,
              )),
        ),
        backgroundColor: transparent,
        body: Container(
          child: Stack(
            children: [
              GetBuilder<ChatScreenController>(builder: (_) {
                return ListView.separated(
                  itemCount: chatScreenController.messages.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final data = chatScreenController.messages;
                    return BubbleNormal(
                      text: data[index]["messege"].toString(),
                      isSender: chatScreenController.messages[index]
                                  ["sendBy"] ==
                              chatScreenController.currentUser!.displayName
                          ? true
                          : false,
                      // text: chatScreenController.messages[index]['message']
                    );
                  },
                );
              }),
              Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  color: const Color(0x54FFFFFF),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: chatFieldController,
                        decoration: const InputDecoration(
                            hintText: "Message ...",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            border: InputBorder.none),
                      )),
                      const SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await sendMessages();
                          chatScreenController.messages.clear();
                          chatScreenController.getMessages(widget.chatRoomId);
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
      ),
    );
  }

  sendMessages() async {
    final currentUserName = FirebaseAuth.instance.currentUser!.displayName;
    if (chatFieldController.text.isNotEmpty) {
      Map<String, String> messagesMap = {
        "messege": chatFieldController.text,
        "sendBy": currentUserName.toString(),
      };
      await FirebaseDB().addMessages(widget.chatRoomId, messagesMap);
      chatFieldController.clear();
    }
  }
}
