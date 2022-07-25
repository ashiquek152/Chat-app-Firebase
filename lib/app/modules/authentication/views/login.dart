import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_field_customized.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:chatapp_firebase/app/modules/new_login_options/controllers/new_login_options_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _authController = Get.put(AuthenticationController());
  final _newLoginOptions = Get.put(NewLoginOptionsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparent,
        elevation: 0.0,
        leading: IconButton(icon: const Icon(Icons.arrow_back,size: 35,),onPressed: (){
                    _newLoginOptions.toggleScreens();

        },),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Form(
            key: _authController.signInFormKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                  children: [
                    TextCustomized(
                      text: "Login to your account",
                      textSize: 40,
                      textColor: white,
                      fontWeight: FontWeight.bold,
                    ),
                    sizedBox20,
                    TextFormFieldCustom(
                      suffixIcon: Icons.mail,
                      fieldController: _authController.signInEmailController,
                      hintText: "Email",
                      maxLength: 40,
                      keyboardType: TextInputType.emailAddress,
                      screenName: 'Login',
                    ),
                    sizedBox10,
                    TextFormFieldCustom(
                      suffixIcon: Icons.key,
                      fieldController: _authController.signInPasswordController,
                      hintText: "Password",
                      maxLength: 15,
                      screenName: 'Login',
                    ),
                    sizedBox10,
                    GestureDetector(
                      onTap: () => _authController.signInwithEmail(),
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 17, 30, 17),
                              child: TextCustomized(
                                text: "Login",
                                textSize: 20,
                                textColor: white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ),
                    sizedBox20,
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextCustomized(
                            text: "or continue with",
                            textSize: 20,
                            textColor: white,
                          ),
                          sizedBox20,
                          sizedBox10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _newLoginOptions.signInWithGoogle();
                                },
                                child: const CircleAvatar(
                                  backgroundColor: transparent,
                                  child: SizedBox(
                                    height: 32,
                                    child: Image(
                                      image: AssetImage("assets/Google new.png"),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _newLoginOptions.signInWithFacebook();
                                },
                                child: const CircleAvatar(
                                  backgroundColor: transparent,
                                  child: Image(
                                    image: AssetImage("assets/facebook-48.png"),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _newLoginOptions.signInWithGitHub(context);
                                },
                                child: const CircleAvatar(
                                  backgroundColor: transparent,
                                  child: Image(
                                    image: AssetImage("assets/github-48.png"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
