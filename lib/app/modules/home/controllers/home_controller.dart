import 'dart:developer';

import 'package:chatapp_firebase/app/data/common_widgets/snackbars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // final _firebaseDB = Get.put(FirebaseDB());

  final searchController = TextEditingController();
  final CollectionReference firestoreCollecton =
      FirebaseFirestore.instance.collection("users");
  bool visibilty = false;

  List searchResult = [];

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
        visibilty = true;
        update();
      });
    } on FirebaseException catch (e) {
      errorSnackBar(e.message.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
