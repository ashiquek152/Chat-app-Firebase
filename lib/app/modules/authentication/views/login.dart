import 'dart:developer';

import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_field_customized.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:chatapp_firebase/app/modules/authentication/views/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                    textColor: Colors.white,
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
                          textColor: Colors.white),
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
                  // Controls visual overflow
                  overflow: TextOverflow.clip,

                  // Controls how the text should be aligned horizontally
                  textAlign: TextAlign.end,

                  // Control the text direction
                  textDirection: TextDirection.rtl,

                  // Whether the text should break at soft line breaks
                  softWrap: true,

                  // Maximum number of lines for the text to span
                  maxLines: 1,

                  // The number of font pixels for each logical pixel
                  textScaleFactor: 1.2,
                  text: TextSpan(
                    text: "Not registered yet ? ",
                    style: const TextStyle(color: Colors.white),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // log("Hello");
                            Get.to(() => SignUpScreen());
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
