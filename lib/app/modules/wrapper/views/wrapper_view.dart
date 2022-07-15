import 'package:chatapp_firebase/app/modules/authentication/views/authentication_view.dart';
import 'package:chatapp_firebase/app/modules/home/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/wrapper_controller.dart';

class WrapperView extends GetView<WrapperController> {
   WrapperView({Key? key}) : super(key: key);
   final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder<User?>(
          stream: _firebaseAuth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            } else if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong"));
            } else if (snapshot.hasData) {
              return    HomeView();
            } else {
              return AuthenticationView();
            }
          },
        ),
    );
  }
}
