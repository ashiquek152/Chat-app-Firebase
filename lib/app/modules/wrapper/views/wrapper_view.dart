import 'package:chatapp_firebase/app/data/db_functions/db_functions.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:chatapp_firebase/app/modules/authentication/views/authentication_view.dart';
import 'package:chatapp_firebase/app/modules/home/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/wrapper_controller.dart';

class WrapperView extends GetView<WrapperController> {
  WrapperView({Key? key}) : super(key: key);
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final authController = Get.put(AuthenticationController());
  final _firebaseDB = Get.put(FirebaseDB());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: _firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          } else if (snapshot.hasData) {
            return getCurrentuserDetails();
          } else {
            return AuthenticationView();
          }
        },
      ),
    );
  }

  getCurrentuserDetails() {
    authController.currentUser = _firebaseAuth.currentUser;
    _firebaseDB.getChatRooms(
        currentUserName: _firebaseAuth.currentUser!.displayName.toString());
    return HomeView();
  }
}
