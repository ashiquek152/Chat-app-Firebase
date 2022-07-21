import 'dart:convert';

import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/image_picker_bottomsheet.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_field_customized.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final authController = Get.put(AuthenticationController());
  // final _imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            "assets/new_bg.jpg",
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.black45,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: authController.signUpformKey,
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () => bottomSheet(),
                    child: GetBuilder<AuthenticationController>(
                      builder: (ctx) {
                        if (ctx.stringIMG != '') {
                          return Center(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              width: 150,
                              height: 150,
                              decoration: const BoxDecoration(
                                color: white,
                              ),
                              child: Image(
                                alignment: Alignment.center,
                                fit: BoxFit.fill,
                                image: MemoryImage(const Base64Decoder()
                                    .convert(ctx.stringIMG)),
                              ),
                            ),
                          );
                        } else {
                          return Center(
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Center(
                                child: TextCustomized(
                                  text: "Tap to upload",
                                  textSize: 12,
                                  textColor: bluegrey,
                                  fontWeight: FontWeight.bold,
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
                      fieldController: authController.signUpUsernameController,
                      hintText: "Username",
                      maxLength: 30,
                      screenName: 'Signup'),
                  sizedBox10,
                  TextFormFieldCustom(
                      fieldController: authController.signUpEmailController,
                      hintText: "Email",
                      maxLength: 50,
                      screenName: 'Signup'),
                  sizedBox10,
                  TextFormFieldCustom(
                    fieldController: authController.signUppasswordController,
                    hintText: "Password",
                    maxLength: 12,
                    screenName: 'Signup',
                  ),
                  sizedBox10,
                  TextFormFieldCustom(
                      fieldController: authController.passConfirmController,
                      hintText: "Confirm password",
                      maxLength: 12,
                      screenName: 'Signup'),
                  sizedBox10,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(primary: buttonColor),
                        onPressed: () {
                          authController.signUpwithEmailandPassword();
                        },
                        icon: const Icon(Icons.login),
                        label: const Text("Register")),
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
                                authController.toggleScreens();
                              },
                            text: 'Click Here',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: buttonColor),
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
      ),
    );
  }
}
