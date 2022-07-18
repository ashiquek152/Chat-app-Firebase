import 'dart:developer';

import 'package:chatapp_firebase/app/data/common_widgets/loading_widget.dart';
import 'package:chatapp_firebase/app/data/common_widgets/snackbars.dart';
import 'package:chatapp_firebase/app/data/db_functions/db_functions.dart';
import 'package:chatapp_firebase/app/data/model/user_model_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationController extends GetxController {
  bool isSignin = true;

  final signUpUsernameController = TextEditingController();
  final signUpEmailController = TextEditingController();
  final signUppasswordController = TextEditingController();
  final passConfirmController = TextEditingController();
  final signUpformKey = GlobalKey<FormState>();

  final signInEmailController = TextEditingController();
  final signInPasswordController = TextEditingController();
  final signInFormKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDB _firebaseDB = FirebaseDB();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  // RxString nameInStorage = "".obs;

  toggleScreens() {
    isSignin = !isSignin;
    clearSignInFields();
    clearSignUpFields();
    update();
  }

  Future updateDisplayProfile(name) async {
    try {
      await _auth.currentUser!.updateDisplayName(name);
      log("Display name updated");
    } catch (e) {
      errorSnackBar("Updating usneme failed");
      Get.back();
    }
  }

  Future signUpwithEmailandPassword() async {
    final isValid = signUpformKey.currentState!.validate();
    if (isValid == true) {
      Get.dialog(const LoadingWidget());
      try {
        UserCredential results = await _auth.createUserWithEmailAndPassword(
          email: signUpEmailController.text.trim(),
          password: signUppasswordController.text.trim(),
        );
        User? user = results.user;
        await _firebaseDB.createUsers(UserModelData(
          email: signUpEmailController.text.trim(),
          name: signUpUsernameController.text.trim(),
          uid: user!.uid.toString(),
        ));
        await updateDisplayProfile(signUpUsernameController.text.trim());
        Get.back();
        welcomeSnackBar(signUpUsernameController.text.trim());
        clearSignUpFields();
      } on FirebaseException catch (e) {
        Get.back();
        final erroMessage = e.message;
        errorSnackBar(erroMessage);
      } catch (e) {
        Get.back();
        Get.snackbar("Somthing went wrong", "");
      }
    }
  }

  Future signInwithEmail() async {
    final isValid = signInFormKey.currentState!.validate();
    if (isValid) {
      Get.dialog(const LoadingWidget());
      try {
        UserCredential results = await _auth.signInWithEmailAndPassword(
          email: signInEmailController.text.trim(),
          password: signInPasswordController.text.trim(),
        );
        User? user = results.user;
        clearSignInFields();
        Get.back();
        welcomeSnackBar(user);
      } on FirebaseAuthException catch (e) {
        final erroMessage = e.message;
        Get.back();
        errorSnackBar(erroMessage);
      } catch (e) {
        Get.back();
        Get.snackbar("Somthing went wrong", "");
      }
    }
  }

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
      ));
      Get.back();
      welcomeSnackBar(results.user);
    } on FirebaseAuthException catch (e) {
      Get.back();
      final erroMessage = e.message;
      errorSnackBar(erroMessage);
    } catch (e) {
      final message = "Somthing went wrong $e" "";
      errorSnackBar(message);
    }
    Get.back();
  }

  clearSignUpFields() {
    signUpEmailController.clear();
    signUppasswordController.clear();
    passConfirmController.clear();
    signUpUsernameController.clear();
  }

  clearSignInFields() {
    signInEmailController.clear();
    signInPasswordController.clear();
  }
}
