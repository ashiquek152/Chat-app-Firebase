import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

welcomeSnackBar(user) {
  Get.snackbar("", "",
      backgroundColor: buttonColor.withOpacity(0.8),
      snackStyle: SnackStyle.FLOATING,
      titleText: Text(
        "Welcome ${user.displayName}",
        style: const TextStyle(color: white),
      ));
}

errorSnackBar(erroMessage) {
  Get.snackbar("", "",
      backgroundColor: buttonColor.withOpacity(0.8),
      snackStyle: SnackStyle.FLOATING,
      titleText: Text(
        erroMessage.toString(),
        style: const TextStyle(color: white),
      ));
}
