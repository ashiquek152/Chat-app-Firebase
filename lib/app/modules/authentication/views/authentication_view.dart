import 'package:chatapp_firebase/app/modules/authentication/views/login.dart';
import 'package:chatapp_firebase/app/modules/authentication/views/signup.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  AuthenticationView({Key? key}) : super(key: key);

  final authController = Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<AuthenticationController>(
      builder: (controller) {
        if (authController.isSignin) {
          return LoginScreen();
        }
        return SignUpScreen();
      },
    ));
  }
}
