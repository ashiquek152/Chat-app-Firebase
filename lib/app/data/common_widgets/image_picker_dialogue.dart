import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

picDialogueBox() {
  final authController = Get.put(AuthenticationController());
  Get.dialog(Center(
    child: Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: black45,
        borderRadius: BorderRadius.circular(25),
      ),
      height: 150,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: Column(
                children: [
                  const Icon(Icons.camera, size: 35, color: buttonColor),
                  sizedBox10,
                  DefaultTextStyle(
                    style: const TextStyle(),
                    child: TextCustomized(
                        text: "Camera",
                        textSize: 15,
                        textColor: white.withOpacity(0.8)),
                  ),
                ],
              ),
              onTap: () {
                authController.pickCameraImage();
                Get.back();
              },
            ),
            GestureDetector(
              onTap: () {
                authController.pickGalleryImage();
                Get.back();
              },
              child: Column(
                children: [
                  const Icon(
                    Icons.image,
                    size: 35,
                    color: buttonColor,
                  ),
                  sizedBox10,
                  DefaultTextStyle(
                      style: const TextStyle(),
                      child: TextCustomized(
                          text: "Gallery",
                          textSize: 15,
                          textColor: white.withOpacity(0.8))),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ));
}
