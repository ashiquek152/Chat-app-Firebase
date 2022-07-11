import 'package:chatapp_firebase/app/modules/authentication/views/login.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
   const AuthenticationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return   LoginScreen();
  }
}
