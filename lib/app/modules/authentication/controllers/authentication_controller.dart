import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatapp_firebase/app/data/common_widgets/loading_widget.dart';
import 'package:chatapp_firebase/app/data/common_widgets/snackbars.dart';
import 'package:chatapp_firebase/app/data/db_functions/db_functions.dart';
import 'package:chatapp_firebase/app/data/model/user_model_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

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
  Rx<User?> currentUser = FirebaseAuth.instance.currentUser.obs;

  File? fileImage;
  String imagePath = "";
  UploadTask? task;
  String imageURL = "";
  String stringIMG = "";

  toggleScreens() {
    isSignin = !isSignin;
    clearSignInFields();
    clearSignUpFields();
    stringIMG = "";
    update();
  }

  ///*** UPDATE DISPLAYPROFILE Name & Image****/

  Future updateDisplayProfile(name) async {
    try {
      _auth.currentUser!.updateDisplayName(name);
      _auth.currentUser!.updatePhotoURL(imageURL);
      log("Display name updated");
    } catch (e) {
      errorSnackBar("Something went wrong");
    }
  }

  ///*******SIGNUP WITH EMAIL AND PASSWORD*********//

  Future signUpwithEmailandPassword() async {
    log(imageURL.toString());
    final isValid = signUpformKey.currentState!.validate() && imageURL != "";
    if (imageURL == "") {
      errorSnackBar("Please pick an image");
      return;
    }
    if (isValid == true) {
      Get.dialog(const LoadingWidget(duration: 12));
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
          imageURL: imageURL,
        ));
      await updateDisplayProfile(signUpUsernameController.text.trim());
        // currentUser.value = user;

        Get.back();
        welcomeSnackBar(signUpUsernameController.text.trim());
        clearSignUpFields();
      } on FirebaseException catch (e) {
        Get.back();
        final erroMessage = e.message;
        errorSnackBar(erroMessage);
      } catch (e) {
        Get.back();
        log(e.toString());
        errorSnackBar(e.toString());
      }
    }
  }

  ///******LOGIN REGISTERD USER****/////

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
        currentUser.value = user;
        clearSignInFields();
        Get.back();
        welcomeSnackBar(user!.displayName);
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

  ///****SIGN IN WITH GOOOGLE *****///

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
      if (currentUser.value == null) {
        await currentUser.value!.reload();
      }
      await _firebaseDB.createUsers(UserModelData(
        email: googleUser.email,
        name: googleUser.displayName.toString(),
        uid: results.user!.uid,
        imageURL: results.user!.photoURL!,
      ));
      // currentUser.value = results.user;
      Get.back();
      welcomeSnackBar(results.user!.displayName);
    } on FirebaseAuthException catch (e) {
      Get.back();
      final erroMessage = e.message;
      errorSnackBar(erroMessage);
    } catch (e) {
      final message = "Somthing went wrong $e";
      errorSnackBar(message);
    }
    Get.back();
  }

  ///**********PICK IMAGE FROM GALLERY************////

  pickGalleryImage() async {
    final galleryImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (galleryImage == null) {
      return;
    } else {
      fileImage = File(galleryImage.path);
      imagePath = galleryImage.path.toString();
      final bytes = File(galleryImage.path).readAsBytesSync();
      stringIMG = base64Encode(bytes);
      update();
    }
  }

  ///**********PICK IMAGE FROM CAMERA************////

  pickCameraImage() async {
    final galleryImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (galleryImage == null) {
      return;
    } else {
      fileImage = File(galleryImage.path);
      final bytes = File(galleryImage.path).readAsBytesSync();
      stringIMG = base64Encode(bytes);
      update();
      uploadImage();
    }
  }

  ///******* UPLOAD TO FIREBASE STORAGE*///

  uploadImage() async {
    if (fileImage == null) return;
    final fileName = basename(fileImage!.path);
    final destination = "ProfilePics/Pic_$fileName";
    task = uploadImageToFirestorage(destination, fileImage!);
    if (task == null) {
      return;
    }
    final snapshot = await task!.whenComplete(() {});
    imageURL = await snapshot.ref.getDownloadURL();
  }

  UploadTask? uploadImageToFirestorage(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException {
      log("Upload to firestore ERROOOOOR");
      return null;
    }
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
