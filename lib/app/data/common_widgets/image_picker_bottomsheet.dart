import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _authcontroller = Get.put(AuthenticationController());

bottomSheet() {
  Get.bottomSheet(
    BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            height: 150,
            color: white,
            child: Center(
              child: Column(
                children: [
                  sizedBox20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                _authcontroller.pickCameraImage();
                              },
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                size: 35,
                                color: red,
                              )),
                          const Text("Camera")
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                _authcontroller.pickGalleryImage();
                              },
                              icon: const Icon(
                                Icons.image_search_sharp,
                                size: 35,
                                color: red,
                              )),
                          const Text("Gallery")
                        ],
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.close,
                      color: buttonColor,
                      size: 35,
                    ),
                  )
                ],
              ),
            ),
          );
        }),
  );
}
