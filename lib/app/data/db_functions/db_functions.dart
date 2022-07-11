import 'dart:developer';

import 'package:chatapp_firebase/app/data/model/user_model_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseDB {
  final CollectionReference firestoreCollecton = FirebaseFirestore.instance.collection("users");

  createUsers(UserModelData userModelData) async {
    try {
       await firestoreCollecton.doc(userModelData.uid).set({
      "name": userModelData.name,
      "email": userModelData.email,
      "uid":userModelData.uid
    });
    log("Data created");
    }on FirebaseException catch (e) {
      Get.snackbar(e.message.toString(), ""); 
    }catch(e){
      print("$e  Error Occcuredddddddddddd");
    }
  }

  // getUserName(userName) async{
    
  // }
}
