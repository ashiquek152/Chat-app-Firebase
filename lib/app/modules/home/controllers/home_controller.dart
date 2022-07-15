import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

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
  final currentUser =FirebaseAuth.instance.currentUser;
   RxString photoUrl = FirebaseAuth.instance.currentUser!.photoURL .toString().obs;
   RxString dispalyName = FirebaseAuth.instance.currentUser!.displayName.toString().obs;
   
  
}
