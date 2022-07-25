import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileDialogue extends StatelessWidget {
  ProfileDialogue({Key? key}) : super(key: key);

  final _authController = Get.put(AuthenticationController());
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: currentUser == null
            ? const CircleAvatar(
                radius: 24,
                backgroundColor: buttonColor,
                child: CircleAvatar(
                  backgroundColor: white,
                  radius: 20.0,
                  backgroundImage: AssetImage("assets/BB.jpg"),
                ),
              )
            : CircleAvatar(
                radius: 24,
                backgroundColor: buttonColor,
                child: CircleAvatar(
                  backgroundColor: white,
                  radius: 20.0,
                  backgroundImage:
                      NetworkImage(currentUser!.photoURL.toString()),
                ),
              ),
      ),
      onTap: () {
        Get.dialog(
          Center(
            child: Container(
              height: 200,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: black45, borderRadius: BorderRadius.circular(25)),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 65,
                    backgroundColor: white.withOpacity(0.3),
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(currentUser!.photoURL.toString()),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultTextStyle(
                        style: const TextStyle(),
                        child: TextCustomized(
                          text: currentUser!.displayName
                              .toString()
                              .capitalizeFirst!,
                          textSize: 18,
                          textColor: white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      sizedBox10,
                      DefaultTextStyle(
                        style: const TextStyle(),
                        child: TextCustomized(
                          text: currentUser!.email.toString().capitalizeFirst!,
                          textSize: 16,
                          textColor: white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      sizedBox10,
                      GestureDetector(
                        onTap: () async {
                          Get.back();
                          _authController.isSignin = true;
                          await GoogleSignIn().signOut();
                          await FirebaseAuth.instance.signOut();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 12, 20, 12),
                                child: DefaultTextStyle(
                                  style: const TextStyle(),
                                  child: TextCustomized(
                                    text: "Sign out",
                                    textSize: 16,
                                    textColor: white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              )),
            ),
          ),
        );
      },
    );
  }
}
