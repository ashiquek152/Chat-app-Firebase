import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  // final count = 0.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // void increment() => count.value++;
  final currentUser =FirebaseAuth.instance.currentUser;
   RxString photoUrl = FirebaseAuth.instance.currentUser!.photoURL .toString().obs;
   RxString dispalyName = FirebaseAuth.instance.currentUser!.displayName.toString().obs;
   final searchController = TextEditingController();
    final CollectionReference firestoreCollecton =
      FirebaseFirestore.instance.collection("users");
  QuerySnapshot? searchResults;
  bool visibilty=false;
  
   getSearchResults() async {
    try {
      if (searchResults!=null) {
        visibilty = true;
        update();
      }
      await firestoreCollecton
          .where("name", isEqualTo: searchController.text)
          .get()
          .then((value) => searchResults = value);
      update();
      if (searchResults!=null) {
        return searchResults;
      }
      else{
        return null;
      }
    } on FirebaseException catch (e) {
      Get.snackbar(e.message.toString(), "");
    } catch (e) {
      log("$e  Error Occcuredddddddddddd");
    }
  }
}
