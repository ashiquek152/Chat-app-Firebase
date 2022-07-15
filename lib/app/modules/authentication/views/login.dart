import 'dart:developer';

import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_field_customized.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormFieldCustom(
                    fieldController: emailController,
                    hintTex: "Email",
                    maxLength: 25,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  sizedBox10,
                  TextFormFieldCustom(
                    fieldController: passwordController,
                    hintTex: "Password",
                    maxLength: 15,
                  ),
                  sizedBox10,
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: buttonColor),
                      onPressed: () {
                        authController.signInwithEmail(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim());
                      },
                      icon: const Icon(Icons.security),
                      label: const Text("Login")),
                  sizedBox10,
                  GestureDetector(
                    onTap: () {
                      log("Hello");
                    },
                    child: TextCustomized(
                      text: "Forgot Password ?",
                      textSize: 18,
                      textColor: white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  sizedBox10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextCustomized(
                            text: "Signin with",
                            textSize: 16,
                            textColor: white),
                      ),
                      GestureDetector(
                        onTap: () {
                          authController.signInWithGoogle();
                          // log("Hello");
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/google.png"))),
                          // color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  RichText(
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.end,
                    textDirection: TextDirection.rtl,
                    softWrap: true,
                    maxLines: 1,
                    textScaleFactor: 1.2,
                    text: TextSpan(
                      text: "Not registered yet ? ",
                      style: const TextStyle(color: white),
                      children: <TextSpan>[
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              authController.toggleScreens();
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
      ),
    );
  }
}
