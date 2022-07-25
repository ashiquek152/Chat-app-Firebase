import 'dart:developer';

import 'package:chatapp_firebase/app/data/common_widgets/loading_widget.dart';
import 'package:chatapp_firebase/app/data/common_widgets/snackbars.dart';
import 'package:chatapp_firebase/app/data/db_functions/db_functions.dart';
import 'package:chatapp_firebase/app/data/model/user_model_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NewLoginOptionsController extends GetxController {
  bool isDarkMode = true;
  bool isLogin =false;
  String? fbUserEmail;
  final FirebaseDB _firebaseDB = FirebaseDB();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    if (isDarkMode) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }
    update();
  }
  toggleScreens() {
    isLogin = !isLogin;
    update();
  }

  Future<UserCredential> signInWithFacebook() async {
    Get.dialog(const LoadingWidget());
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ["email", "public_profile", "user_birthday"]);
    final OAuthCredential fbAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    final userData = await FacebookAuth.instance.getUserData();
    fbUserEmail = userData["email"];
    update();
    return FirebaseAuth.instance.signInWithCredential(fbAuthCredential);

  }

  /// *************************************************************** */
  Future signInWithGitHub(context) async {
    Get.dialog(const LoadingWidget());
    try {
      final GitHubSignIn gitHubSignIn =  GitHubSignIn(
          clientId: "0b100fd9a426109e647d",
          clientSecret: "3f367dd73b2294a7c9836997fdf584615d5a4a60",
          redirectUrl:
              "https://fir-chat-app-517ff.firebaseapp.com/__/auth/handler");

      final GitHubSignInResult result = await gitHubSignIn.signIn(context);
      final gitCredential = GithubAuthProvider.credential(result.token!);
      log(gitCredential.toString());
      update();
      return FirebaseAuth.instance.signInWithCredential(gitCredential);
    } catch (e) {
      print(e);
    }
    Get.back();
  }
  /// ******************************** */

  Future signInWithGoogle() async {
    Get.dialog(const LoadingWidget());
    try {
      final googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential results = await _auth.signInWithCredential(credential);
      await _firebaseDB.createUsers(UserModelData(
        email: googleUser.email,
        name: googleUser.displayName.toString(),
        uid: results.user!.uid,
        imageURL: results.user!.photoURL!,
      ));
      welcomeSnackBar(results.user!.displayName);
    } on FirebaseAuthException catch (e) {
      final erroMessage = e.message;
      errorSnackBar(erroMessage);
    } catch (e) {
      final message = "Somthing went wrong $e";
      errorSnackBar(message);
    }
    Get.back();
  }

}
