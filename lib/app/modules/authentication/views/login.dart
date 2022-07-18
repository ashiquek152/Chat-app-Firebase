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

  final _authController = Get.put(AuthenticationController());

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
              key: _authController.signInFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormFieldCustom(
                    fieldController: _authController.signInEmailController,
                    hintText: "Email",
                    maxLength: 25,
                    keyboardType: TextInputType.emailAddress,
                    screenName: 'Login',
                  ),
                  sizedBox10,
                  TextFormFieldCustom(
                    fieldController: _authController.signInPasswordController,
                    hintText: "Password",
                    maxLength: 15,
                    screenName: 'Login',
                  ),
                  sizedBox10,
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: buttonColor),
                      onPressed: () {
                        _authController.signInwithEmail();
                      },
                      icon: const Icon(Icons.security),
                      label: const Text("Login")),
                  sizedBox10,
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustomized(
                          text: "OR",
                          textSize: 20,
                          textColor: white,
                          fontWeight: FontWeight.bold,
                        ),
                        sizedBox20,

                        GestureDetector(
                          onTap: () {
                            _authController.signInWithGoogle();
                          },
                          child: const CircleAvatar(
                            backgroundColor: transparent,
                            child: Image(
                              image: AssetImage("assets/Google 2.png"),
                            ),
                          ),
                        ),
                        sizedBox20,
                        RichText(
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.end,
                          textDirection: TextDirection.rtl,
                          softWrap: true,
                          maxLines: 1,
                          textScaleFactor: 1.2,
                          text: TextSpan(
                            text: "Not registered yet ? ",
                            style: const TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _authController.toggleScreens();
                                  },
                                text: 'Click Here',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: buttonColor),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
