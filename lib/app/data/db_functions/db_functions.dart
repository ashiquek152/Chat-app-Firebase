import 'dart:developer';

import 'package:chatapp_firebase/app/data/model/user_model_class.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:chatapp_firebase/app/modules/chat_screen/views/chat_screen_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseDB extends GetxController {
  final fireStoreInstance = FirebaseFirestore.instance;
  final chatFieldController = TextEditingController();

  final CollectionReference firestoreCollectonUsers =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference firestoreCollectonChatRoom =
      FirebaseFirestore.instance.collection("ChatRoom");
  String? existingChatRoom;

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

  QuerySnapshot? data;
  getEmailMatchingData(email) async {
    try {
      await firestoreCollectonUsers
          .where("email", isEqualTo: email)
          .get()
          .then((value) {
        final List usersData = [];
        value.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          usersData.add(a);
        }).toList();
        AuthenticationController().nameInStorage.value = usersData[0]["name"];
      });
    } on FirebaseException catch (e) {
      Get.snackbar(e.message.toString(), "");
    } catch (e) {
      log("$e  Error Occcuredddddddddddd$e");
    }
    // return nameInStorage;
  }

  createChatConversations(
      {required String userName, required String currentUserName}) async {
    String chatRoomId = "";

    await checkExistingChatroomId(
        currentUserName: currentUserName, userName: userName);
    if (existingChatRoom!.isEmpty) {
      chatRoomId = createChatRoomId(userName, currentUserName);
      List<String> users = [userName, currentUserName];
      Map<String, dynamic> chatRoomMap = {"users": users, "roomId": chatRoomId};
      await createChatRoom(chatRoomId, chatRoomMap);
    }
    await getMessages(
        existingChatRoom!.isNotEmpty ? existingChatRoom : chatRoomId);

    Get.to(
      () => ChatScreenView(),
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
    // GetStorageFunctions().setSignedUser(chatRoomid, time.toString());
  }

  checkExistingChatroomId(
      {required String currentUserName, required String userName}) async {
    existingChatRoom = "";
    final roomId1 = createChatRoomId(currentUserName, userName);
    final roomId2 = createChatRoomId2(userName, currentUserName);
    log(roomId1.toString());
    log(roomId2.toString());

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
  getMessages(chatRoomid) async {
    return await firestoreCollectonChatRoom
        .doc(chatRoomid)
        .collection("chats")
        .where("messege")
        .get()
        .then((value) {
      value.docs.map((DocumentSnapshot document) {
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
      await addMessages(
          existingChatRoom!.isNotEmpty ? existingChatRoom : chatRoomID,
          messagesMap);
      chatFieldController.clear();
    }
  }
}
