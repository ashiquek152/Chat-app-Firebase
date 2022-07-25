import 'dart:developer';

import 'package:chatapp_firebase/app/data/model/user_model_class.dart';
import 'package:chatapp_firebase/app/modules/all_users/controllers/all_users_controller.dart';
import 'package:chatapp_firebase/app/modules/chat_screen/controllers/chat_screen_controller.dart';
import 'package:chatapp_firebase/app/modules/chat_screen/views/chat_screen_view.dart';
import 'package:chatapp_firebase/app/modules/home/controllers/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseDB extends GetxController {
  final fireStoreInstance = FirebaseFirestore.instance;
  final _homeController = Get.put(HomeController());
  final _allUsersControler = Get.put(AllUsersController());
  final _chatScreenController = Get.put(ChatScreenController());

  final CollectionReference firestoreCollectonUsers =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference firestoreCollectonChatRoom =
      FirebaseFirestore.instance.collection("ChatRoom");
  String? existingChatRoom;
  String chatRoomID = "";

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

  createChatRoom({required String chatRoomID, required chatRoomMap}) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomID)
        .set(chatRoomMap)
        .catchError((e) => log("Creating Chatroom Error ${e.toString()}"));
  }

  createChatConversations(
      {required String userName,
      required String currentUserName,
      }) async {
    try {
      log("working create conversations");
      await checkExistingChatroomID(
          currentUserName: currentUserName, userName: userName);
      if (existingChatRoom=="") {

        chatRoomID = createChatRoomID(userName, currentUserName);
        log(chatRoomID);

        List<String> users = [userName, currentUserName];
        Map<String, dynamic> chatRoomMap = {
          "users": users,
          "roomId": chatRoomID
        };
       await createChatRoom(chatRoomID: chatRoomID, chatRoomMap: chatRoomMap);
      }
      _chatScreenController.getMessages(
          existingChatRoom == "" ? chatRoomID : existingChatRoom!);
      Get.to(
          curve: Curves.ease,
          duration: const Duration(seconds: 1),
          () => ChatScreenView(),
          arguments:
              existingChatRoom!.isNotEmpty ? existingChatRoom : chatRoomID);
    } catch (e) {
      print(e.toString());
    }
  }

  createChatRoomID(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "${b}_$a";
    } else {
      return "${a}_$b";
    }
  }

  createChatRoomID2(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "${a}_$b";
    } else {
      return "${b}_$a";
    }
  }

  getChatConversations(
      {required String userName,
      required String currentUserName,
      required String chatRoomID}) async {
    await checkExistingChatroomID(
        currentUserName: currentUserName, userName: userName);
    await _chatScreenController.getMessages(chatRoomID);
    _allUsersControler.searchController.clear();
    _allUsersControler.searchResult.clear();
    _homeController.getChatRooms(currentUserName: currentUserName);
    Get.to(
      // curve: Curves.ease,
      // duration: const Duration(seconds: 1),
      () => ChatScreenView(),
      arguments: existingChatRoom!.isNotEmpty ? existingChatRoom : chatRoomID,
    );
  }

  checkExistingChatroomID(
      {required String currentUserName, required String userName}) async {
    existingChatRoom = "";
    final roomId1 = createChatRoomID(currentUserName, userName);
    final roomId2 = createChatRoomID2(userName, currentUserName);

    final search = await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(roomId1)
        .get();
    print(search.data());

    if (search.data() != null) {
      existingChatRoom = roomId1;
      return;
    } else {
      final search2 = await FirebaseFirestore.instance
          .collection("ChatRoom")
          .doc(roomId2)
          .get();
      print(search2.data());
      if (search2.data() != null) {
        existingChatRoom = roomId2;
        print(existingChatRoom);
        return;
      }
    }
  }
}
