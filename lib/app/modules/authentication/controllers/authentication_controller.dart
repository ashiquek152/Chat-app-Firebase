import 'dart:developer';

import 'package:chatapp_firebase/app/data/db_functions/db_functions.dart';
import 'package:chatapp_firebase/app/data/get_storage/storage_functions.dart';
import 'package:chatapp_firebase/app/data/model/user_model_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationController extends GetxController {
  // final count = 0.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // void increment() => count.value++;

  bool isSignin = true;

  toggleScreens() {
    isSignin = !isSignin;
    update();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final firebaseDB = FirebaseDB();
 RxString nameInStorage="".obs;


  Future updateDisplayProfile(name)async{
  try {
      await _auth.currentUser!.updateDisplayName(name);
    log("Display name updated");

  } catch (e) {
    log(e.toString());
    
  }
    // await _auth.currentUser!.updatePhotoURL(name);

  }

  Future signUpwithEmailandPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      UserCredential results = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = results.user;
      await FirebaseDB().createUsers(UserModelData(
        email: email,
        name: name,
        uid: user!.uid.toString(),
      ));
      await updateDisplayProfile(name);
      await GetStorageFunctions().setSignedUser("name", name);
    } on FirebaseException catch (e) {
      log("${e.message}On Signup with EMAIL & PASSWORD");
    }
  }

  Future signInwithEmail(
      {required String email, required String password}) async {
    try {
      final UserCredential signedUser = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      

      log("Logged in with EMAIL & PASSWORD");
      await firebaseDB.getEmailMatchingData(email);
      log("Matchin name {$nameInStorage}");
      await GetStorageFunctions().setSignedUser("name", nameInStorage);
    } on FirebaseException catch (e) {
      log(e.message.toString());
    } catch (e) {
      log("Some other Excptions in sign in with EMAIL & PASSWORD $e");
    }
  }

  Future signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential results = await _auth.signInWithCredential(credential);
      await FirebaseDB().createUsers(UserModelData(
        email: googleUser.email,
        name: googleUser.displayName.toString(),
        uid: results.user!.uid,
      ));
      
      // await firebaseDB.getEmailMatchingData(
      //   googleUser.email,
      // );
      // log("Matchin name {$nameInStorage}");
      // await GetStorageFunctions().setSignedUser("name", nameInStorage);
      log("Successfully Logged in with GOOGLE");
    } catch (e) {
      log("$e Sign with google errooooooooor");
    }
  }
}
