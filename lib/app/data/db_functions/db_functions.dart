import 'dart:developer';

import 'package:chatapp_firebase/app/data/model/user_model_class.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:chatapp_firebase/app/modules/chat_screen/views/chat_screen_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseDB {
  final fireStoreInstance = FirebaseFirestore.instance;

  final CollectionReference firestoreCollectonUsers =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference firestoreCollectonChatRoom =
      FirebaseFirestore.instance.collection("ChatRoom");

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
    firestoreCollectonChatRoom
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

  createChatConversations(String userName) async {
    String currentUserName =
        FirebaseAuth.instance.currentUser!.displayName.toString();
    String chatRoomId = createChatRoomId(userName, currentUserName);
    List<String> users = [userName, currentUserName];
    Map<String, dynamic> chatRoomMap = {"users": users, "roomId": chatRoomId};
    FirebaseDB().createChatRoom(chatRoomId, chatRoomMap);
    Get.to(() => ChatScreenView(
          chatRoomId: chatRoomId,
          userName: userName,
        ));
  }

  createChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "${b}_$a";
    } else {
      return "${a}_$b";
    }
  }

  addMessages(chatRoomid, messagesMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomid)
        .collection("chats").doc(DateTime.now().toString())
        .set(messagesMap)
        .catchError((e) {
      log("Add Messages Error  ${e.toString()}");
    });
  }

  
}
