import 'dart:developer';

import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_field_customized.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passConfirmController = TextEditingController();
  final authController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            "assets/black_blue_BG.jpg",
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.black45,
        // appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormFieldCustom(
                    fieldController: emailController, hintTex: "Email"),
                sizedBox10,
                TextFormFieldCustom(
                    fieldController: passwordController, hintTex: "Password"),
                sizedBox10,
                TextFormFieldCustom(
                    fieldController: passConfirmController,
                    hintTex: "Confirm password"),
                sizedBox10,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: buttonColor),
                      onPressed: () {
                        authController.signUpwithEmailandPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim());
                      },
                      icon: const Icon(Icons.login),
                      label: const Text("Register")),
                ),
                sizedBox10,
                RichText(
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.end,
                  textDirection: TextDirection.rtl,
                  softWrap: true,
                  maxLines: 1,
                  textScaleFactor: 1.2,
                  text: TextSpan(
                    text: "Have an account ? ",
                    style: const TextStyle(color: Colors.white),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            log("Hello");
                          },
                        text: 'Click Here',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: buttonColor),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
