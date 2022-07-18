import 'package:chatapp_firebase/app/data/common_widgets/snackbars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  User? currentUser = FirebaseAuth.instance.currentUser;
  // final _firebaseDB = Get.put(FirebaseDB());

  final searchController = TextEditingController();
  final CollectionReference firestoreCollecton =
      FirebaseFirestore.instance.collection("users");
  QuerySnapshot? searchResults;
  bool visibilty = false;
  int selectedIndex = 0;

  getSearchResults() async {
    try {
      await firestoreCollecton
          .where("name", isEqualTo: searchController.text)
          .get()
          .then((value) {
        searchResults = value;
      });
      update();
      if (searchResults != null) {
        visibilty = true;
        searchResults;
      }
      // else{
      //   return;
      // }
    } on FirebaseException catch (e) {
      errorSnackBar(e.message.toString());
    } catch (e) {
      errorSnackBar("Something went wrong");
    }
  }
}
