import 'dart:developer';

import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

class TextFormFieldCustom extends StatelessWidget {
  TextFormFieldCustom({
    Key? key,
    required this.fieldController,
    required this.hintText,
    this.maxLength = 100,
    this.keyboardType = TextInputType.name,
    required this.screenName,
  }) : super(key: key);

  final _authController = Get.put(AuthenticationController());
  final TextEditingController fieldController;
  final String hintText;
  final int maxLength;
  final TextInputType keyboardType;
  final String screenName;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      maxLength: maxLength,
      keyboardType: keyboardType,
      obscureText:
          hintText == "Password" || hintText == "Confirm password" ? true : false,
      validator: (value) {
        if (screenName == "Signup") {
          return validatorSignup(value);
        } else {
          return validatorSignIn(value);
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        errorStyle: const TextStyle(color: Color.fromARGB(255, 235, 231, 3),fontWeight: FontWeight.bold),
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            color: Colors.blue.withOpacity(0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          )),
    );
  }

  validatorSignup(value) {
    final signUpEmail = _authController.signUpEmailController.text.trim();
    final signUpPassword = _authController.signUppasswordController.text.trim();
    final confirmPassword = _authController.passConfirmController.text.trim();
   

    if (hintText == "Password" || hintText == "Confirm password") {
      if (value.length < 6) {
        return "Password contain min 6 characters";
      } else if (confirmPassword != signUpPassword) {
        return "Password doesn't match";
      }
    }
    if (hintText == "Username" && value.length < 4) {
      return "Enter min 4 characters";
    } 
     bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(signUpEmail);
    if (hintText=="Email" && !emailValid) {
      return "Enter a valid email";
    }
  }

  validatorSignIn(value) {
    final signInPassword = _authController.signInPasswordController.text;
    final signInEmail = _authController.signInEmailController.text;
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(signInEmail);
    if (hintText == "Password") {
      log("THis is working");
      if (signInPassword.isEmpty || value.length < 6) {
        return "Password contain min 6 characters";
      }
    } else if (!emailValid) {
      return "Enter a valid email";
    }
  }
}
