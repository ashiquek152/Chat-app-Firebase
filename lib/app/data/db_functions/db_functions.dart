import 'dart:developer';

import 'package:chatapp_firebase/app/data/model/user_model_class.dart';
import 'package:chatapp_firebase/app/modules/chat_screen/views/chat_screen_view.dart';
import 'package:chatapp_firebase/app/modules/home/controllers/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseDB extends GetxController {
  final fireStoreInstance = FirebaseFirestore.instance;
  final chatFieldController = TextEditingController();
  final _homeController = Get.put(HomeController());

  final CollectionReference firestoreCollectonUsers =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference firestoreCollectonChatRoom =
      FirebaseFirestore.instance.collection("ChatRoom");
  String? existingChatRoom;
  String chatRoomId = "";

  createUsers(UserModelData userModelData) async {
    try {
      await firestoreCollectonUsers
          .doc(userModelData.uid)
          .set(userModelData.toJson());
      log("Data created");
    } on FirebaseException catch (e) {
      Get.snackbar(e.message.toString(), "");
    } catch (e) {
      log("Creating user Error ${e.toString()}");
    }
  }

  createChatRoom(String chatRoomID, chatRoomMap) async {
    return await firestoreCollectonChatRoom
        .doc(chatRoomID)
        .set(chatRoomMap)
        .catchError((e) => log("Creating Chatroom Error ${e.toString()}"));
  }

  createChatConversations(
      {required String userName, required String currentUserName}) async {
    await checkExistingChatroomId(
        currentUserName: currentUserName, userName: userName);
    if (existingChatRoom!.isEmpty) {
      chatRoomId = createChatRoomId(userName, currentUserName);
      List<String> users = [userName, currentUserName];
      Map<String, dynamic> chatRoomMap = {"users": users, "roomId": chatRoomId};
      await createChatRoom(chatRoomId, chatRoomMap);
    }
    await getMessages();
    _homeController.searchController.text = "";

    Get.to(
      curve: Curves.ease,
      duration: const Duration(seconds: 1),
      () => ChatScreenView(userName: userName),
      arguments: existingChatRoom!.isNotEmpty ? existingChatRoom : chatRoomId,
    );
  }

  createChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "${b}_$a";
    } else {
      return "${a}_$b";
    }
  }

  createChatRoomId2(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "${a}_$b";
    } else {
      return "${b}_$a";
    }
  }

  addMessages(chatRoomid, messagesMap) async {
    final time = DateTime.now();
    await firestoreCollectonChatRoom
        .doc(chatRoomid)
        .collection("chats")
        .doc(time.toString())
        .set(messagesMap)
        .catchError((e) {
      log("Add Messages Error  ${e.toString()}");
    });
  }

  checkExistingChatroomId(
      {required String currentUserName, required String userName}) async {
    existingChatRoom = "";
    final roomId1 = createChatRoomId(currentUserName, userName);
    final roomId2 = createChatRoomId2(userName, currentUserName);

    final search = await firestoreCollectonChatRoom.doc(roomId1).get();

    if (search.data() != null) {
      existingChatRoom = roomId1;
      return;
    } else {
      final search2 = await firestoreCollectonChatRoom.doc(roomId2).get();
      if (search2.data() != null) {
        existingChatRoom = roomId2;
        return;
      }
    }
  }

  final List messages = [];
  getMessages() {
    firestoreCollectonChatRoom
        .doc(existingChatRoom!.isNotEmpty ? existingChatRoom : chatRoomId)
        .collection("chats")
        .where("messege")
        .snapshots()
        .forEach((element) {
      messages.clear();
      element.docs.map((DocumentSnapshot document) {
        Map a = document.data() as Map<String, dynamic>;
        messages.add(a);
      }).toList();
      update();
    });
  }

  sendMessages(
      {required String currentUserName, required String chatRoomID}) async {
    if (chatFieldController.text.isNotEmpty) {
      Map<String, String> messagesMap = {
        "messege": chatFieldController.text,
        "sendBy": currentUserName.toString(),
      };
      addMessages(existingChatRoom!.isNotEmpty ? existingChatRoom : chatRoomID,
          messagesMap);
      chatFieldController.clear();
    }
  }

  List users = [];
  getChatRooms({required String currentUserName}) async {
    users.clear();
    await firestoreCollectonChatRoom
        .where("users", arrayContains: currentUserName)
        .get()
        .then((value) {
      value.docs.map((DocumentSnapshot document) {
        Map a = document.data() as Map<String, dynamic>;
        users.add(a);
      }).toList();
      update();
    });
  }
}
