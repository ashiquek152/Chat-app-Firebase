import 'dart:developer';

import 'package:chatapp_firebase/app/data/common_widgets/loading_widget.dart';
import 'package:chatapp_firebase/app/data/common_widgets/snackbars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllUsersController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference firestoreCollecton =
      FirebaseFirestore.instance.collection("users");
  final searchController = TextEditingController();

  bool allUsersVisibility = true;
  bool searchListVisibility = false;

  List allUsers = [];
  List searchResult = [];

  visibilitySwitch() {
    allUsersVisibility = searchController.text == "" ? true : false;
    searchListVisibility = searchController.text == "" ? false : true;
    update();
  }

  getAllUsers() async {
    Get.dialog(const LoadingWidget());
    try {
      await _firestore.collection("users").get().then((value) {
        allUsers.clear();
        value.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          allUsers.add(a);
        }).toList();
        update();
      });
      log(allUsers.toString());
    } catch (e) {
      log(e.toString());
    }
    Get.back();
  }

  getSearchResults() async {
    try {
      await firestoreCollecton
          .where("name", isEqualTo: searchController.text.trim())
          .snapshots()
          .forEach((element) {
        searchResult.clear();
        element.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          searchResult.add(a);
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
