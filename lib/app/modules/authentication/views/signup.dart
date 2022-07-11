import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_field_customized.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passConfirmController = TextEditingController();
  final authController = Get.put(AuthenticationController());
  final _formKey = GlobalKey<FormState>();

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
                      fieldController: usernameController,
                      hintTex: "Username",
                      maxLength: 10),
                  sizedBox10,
                  TextFormFieldCustom(
                      fieldController: emailController,
                      hintTex: "Email",
                      maxLength: 25),
                  sizedBox10,
                  TextFormFieldCustom(
                    fieldController: passwordController,
                    hintTex: "Password",
                    maxLength: 15,
                  ),
                  sizedBox10,
                  TextFormFieldCustom(
                    fieldController: passConfirmController,
                    hintTex: "Confirm password",
                    maxLength: 15,
                  ),
                  sizedBox10,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(primary: buttonColor),
                        onPressed: () {
                          authController.signUpwithEmailandPassword(
                            name: usernameController.text.trim(),
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
