import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_login_options_controller.dart';

class NewLoginOptionsView extends GetView<NewLoginOptionsController> {
  NewLoginOptionsView({Key? key}) : super(key: key);

  final _newLoginOptionsController = Get.put(NewLoginOptionsController());
  final _authController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 250,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Logo New.png"),
                      fit: BoxFit.contain)),
            ),
            TextCustomized(
              text: "CHAT BoX",
              textSize: 40,
              textColor: const Color.fromARGB(255, 0, 195, 255),
              fontWeight: FontWeight.bold,
              fontFamily: "MochiyPopOne",
            ),
            GestureDetector(
              onTap: () {
                _newLoginOptionsController.signInWithGoogle();
              },
              child: Container(
                height: 70,
                decoration: containerDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Image(image: AssetImage("assets/Google 2.png")),
                    ),
                    TextCustomized(
                      text: "Continue with Google",
                      textSize: 15,
                      textColor: white,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _newLoginOptionsController.signInWithFacebook();
              },
              child: Container(
                height: 70,
                decoration: containerDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Image(image: AssetImage("assets/facebook-48.png")),
                    ),
                    TextCustomized(
                      text: "Continue with Facebook",
                      textSize: 15,
                      textColor: white,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _newLoginOptionsController.signInWithGitHub(context);
              },
              child: Container(
                height: 70,
                decoration: containerDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Image(image: AssetImage("assets/github-48.png")),
                    ),
                    TextCustomized(
                      text: "Continue with GitHub",
                      textSize: 15,
                      textColor: white,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              ),
            ),
            TextCustomized(
              text: "or",
              textSize: 20,
              textColor: white,
              fontWeight: FontWeight.bold,
            ),
            GestureDetector(
              onTap: () {
                _newLoginOptionsController.toggleScreens();
              },
              child: Container(
                  decoration: containerDecoration(
                    color: buttonColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 17, 30, 17),
                    child: TextCustomized(
                      text: "Sign in with password",
                      textSize: 15,
                      textColor: white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
            RichText(
              overflow: TextOverflow.clip,
              textAlign: TextAlign.end,
              textDirection: TextDirection.rtl,
              softWrap: true,
              maxLines: 1,
              textScaleFactor: 1.2,
              text: TextSpan(
                text: "Dont have an account ? ",
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
                    text: 'Signup',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: buttonColor),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  BoxDecoration containerDecoration({color = black45}) {
    return BoxDecoration(color: color, borderRadius: BorderRadius.circular(25));
  }
}
