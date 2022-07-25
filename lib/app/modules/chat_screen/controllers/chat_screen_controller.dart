import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  final chatFieldController = TextEditingController();
  final CollectionReference firestoreCollectonUsers =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference firestoreCollectonChatRoom =
      FirebaseFirestore.instance.collection("ChatRoom");

  sendMessages(
      {required String currentUserName, required String chatRoomID}) async {
    if (chatFieldController.text.isNotEmpty) {
      Map<String, String> messagesMap = {
        "messege": chatFieldController.text,
        "sendBy": currentUserName.toString(),
      };
      addMessages(chatRoomID, messagesMap);
      chatFieldController.clear();
    }
  }

  addMessages(chatRoomID, messagesMap) async {
    final time = DateTime.now();
    await firestoreCollectonChatRoom
        .doc(chatRoomID)
        .collection("chats")
        .doc(time.toString())
        .set(messagesMap)
        .catchError((e) {
      log("Add Messages Error  ${e.toString()}");
    });
  }

  final List messages = [];
  getMessages(chatRoomID) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomID)
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
}
