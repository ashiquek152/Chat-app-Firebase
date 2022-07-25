import 'dart:developer';

import 'package:chatapp_firebase/app/data/common_widgets/snackbars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference firestoreCollecton =
      FirebaseFirestore.instance.collection("users");

  List recentChatNames = [];
  List chatterDetails = [];

  getChatRooms({required String currentUserName}) async {
    recentChatNames.clear();
    try {
      FirebaseFirestore.instance
          .collection("ChatRoom")
          .where("users", arrayContains: currentUserName)
          .get()
          .then((value) {
        recentChatNames.clear();
        value.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          recentChatNames.add(a);
        }).toList();
        update();
      });
    } catch (e) {
      print(e);
    }
  }

  getChatterDetails(name) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .where("name", isEqualTo: name)
          .snapshots()
          .forEach((element) {
        chatterDetails.clear();
        element.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          chatterDetails.add(a);
        }).toList();
        update();
      });
    } on FirebaseException catch (e) {
      errorSnackBar(e.message.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
