import 'dart:convert';

import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/image_picker_dialogue.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_field_customized.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final _authController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Form(
            key: _authController.signUpformKey,
            child: ListView(
              children: [
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () => picDialogueBox(),
                  child: GetBuilder<AuthenticationController>(
                    builder: (ctx) {
                      if (ctx.stringIMG != '') {
                        return Center(
                          child: CircleAvatar(
                            radius: 75,
                            backgroundColor: buttonColor,
                            child: CircleAvatar(
                              backgroundImage: MemoryImage(
                                  const Base64Decoder().convert(ctx.stringIMG)),
                              radius: 70,
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: CircleAvatar(
                            radius: 75,
                            backgroundColor: buttonColor,
                            child: CircleAvatar(
                              radius: 70,
                              child: Center(
                                child: TextCustomized(
                                  text: "Tap to upload",
                                  textSize: 12,
                                  textColor: bluegrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                sizedBox20,
                TextFormFieldCustom(
                    suffixIcon: Icons.person,
                    fieldController: _authController.signUpUsernameController,
                    hintText: "Username",
                    maxLength: 30,
                    screenName: 'Signup'),
                sizedBox10,
                TextFormFieldCustom(
                    suffixIcon: Icons.mail,
                    fieldController: _authController.signUpEmailController,
                    hintText: "Email",
                    maxLength: 50,
                    screenName: 'Signup'),
                sizedBox10,
                TextFormFieldCustom(
                  suffixIcon: Icons.key,
                  fieldController: _authController.signUppasswordController,
                  hintText: "Password",
                  maxLength: 12,
                  screenName: 'Signup',
                ),
                sizedBox10,
                TextFormFieldCustom(
                    suffixIcon: Icons.keyboard_control_outlined,
                    fieldController: _authController.passConfirmController,
                    hintText: "Confirm password",
                    maxLength: 12,
                    screenName: 'Signup'),
                sizedBox10,
                GestureDetector(
                  onTap: () => _authController.signUpwithEmailandPassword(),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 17, 30, 17),
                          child: TextCustomized(
                            text: "Signup",
                            textSize: 20,
                            textColor: white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ),
                sizedBox20,
                Center(
                  child: RichText(
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.end,
                    textDirection: TextDirection.rtl,
                    softWrap: true,
                    maxLines: 1,
                    textScaleFactor: 1.2,
                    text: TextSpan(
                      text: "Have an account ? ",
                      style: const TextStyle(color: white),
                      children: <TextSpan>[
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _authController.toggleScreens();
                            },
                          text: 'Click Here',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: buttonColor),
                        ),
                      ],
                    ),
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
