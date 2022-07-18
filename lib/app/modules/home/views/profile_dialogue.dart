import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileDialogue extends StatelessWidget {
  ProfileDialogue({Key? key}) : super(key: key);

  final _authController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.dialog(
          Center(
            child: Container(
              height: 200,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                      style: const TextStyle(),
                      child: TextCustomized(
                        text:
                            _authController.currentUser!.displayName.toString(),
                        textSize: 18,
                        textColor: black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    sizedBox10,
                    DefaultTextStyle(
                      style: const TextStyle(),
                      child: TextCustomized(
                        text: _authController.currentUser!.email.toString(),
                        textSize: 16,
                        textColor: black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    sizedBox10,
                    ElevatedButton(
                        style: TextButton.styleFrom(
                          primary: white,
                          backgroundColor: buttonColor,
                        ),
                        onPressed: () async {
                          Get.back();
                          _authController.isSignin = true;
                          await FirebaseAuth.instance.signOut();
                        },
                        child: const Text("SignOut")),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: _authController.currentUser!.photoURL == null
            ? const CircleAvatar(
                backgroundColor: white,
                radius: 25.0,
                backgroundImage: AssetImage("assets/BB.jpg"),
              )
            : CircleAvatar(
                backgroundColor: white,
                radius: 25.0,
                backgroundImage: NetworkImage(
                    _authController.currentUser!.photoURL.toString()),
              ),
      ),
    );
  }
}
