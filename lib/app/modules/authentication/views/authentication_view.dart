import 'package:chatapp_firebase/app/modules/authentication/views/login.dart';
import 'package:chatapp_firebase/app/modules/authentication/views/signup.dart';
import 'package:chatapp_firebase/app/modules/new_login_options/controllers/new_login_options_controller.dart';
import 'package:chatapp_firebase/app/modules/new_login_options/views/new_login_options_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  AuthenticationView({Key? key}) : super(key: key);

  final authController = Get.put(AuthenticationController());
  final newLoginOptionsController = Get.put(NewLoginOptionsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<NewLoginOptionsController>(
        builder: (context) {
          return GetBuilder<AuthenticationController>(
            builder: (controller) {
              if (authController.isSignin) {
                if (newLoginOptionsController.isLogin == true) {
                  return LoginScreen();
                }
                return NewLoginOptionsView();
              } else {
                return SignUpScreen();
              }
            },
          );
        }
      ),
    );
  }
}
