import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/modules/all_users/controllers/all_users_controller.dart';
import 'package:chatapp_firebase/app/modules/all_users/views/all_users_view.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:chatapp_firebase/app/modules/home/views/profile_dialogue.dart';
import 'package:chatapp_firebase/app/modules/home/views/recent_chat_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final User? currentUser = FirebaseAuth.instance.currentUser;
  final _allUsersController = Get.put(AllUsersController());
  final _homeController = Get.put(HomeController());
  final _authController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    currentUser!.displayName != null
        ? _homeController.getChatRooms(
            currentUserName: currentUser!.displayName!)
        : null;
    // print(_homeController.recentChatNames);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: transparent,
          leading: const Icon(
            Icons.child_care_outlined,
            size: 50,
            color: buttonColor,
          ),
          title: TextCustomized(
            text: "CHAT BoX",
            textSize: 25,
            textColor: white,
            fontFamily: "MochiyPopOne",
          ),
          actions: [
            currentUser!.displayName == null
                ? TextButton(
                    onPressed: () async {
                      _authController.isSignin = true;
                      await GoogleSignIn().signOut();
                      await FirebaseAuth.instance.signOut();
                    },
                    child: TextCustomized(
                      text: "Logout",
                      textSize: 16,
                      textColor: white,
                      fontWeight: FontWeight.bold,
                    ))
                : ProfileDialogue(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 16.0),
          child: GetBuilder<HomeController>(builder: (context) {
            return _homeController.recentChatNames.isEmpty
                ? SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        sizedBox10,
                        Padding(
                          padding: const EdgeInsets.only(top: 85.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/Logo New.png"),
                              sizedBox20,
                              currentUser != null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextCustomized(
                                          text:
                                              "Welcome ${currentUser!.displayName.toString().capitalizeFirst}",
                                          textSize: 35,
                                          textColor: white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        TextCustomized(
                                          text: "Don't wait !",
                                          textSize: 16,
                                          textColor: white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        sizedBox20,
                                        GestureDetector(
                                          onTap: () async {
                                            await _allUsersController
                                                .getAllUsers();
                                            Get.to(() => AllUsersView());
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: buttonColor,
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        30, 17, 30, 17),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextCustomized(
                                                      text: "Start a chat",
                                                      textSize: 20,
                                                      textColor: white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    const Icon(
                                                        Icons.arrow_forward)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : TextCustomized(
                                      text:
                                          "We couldn't recognize you Please login again",
                                      textSize: 35,
                                      textColor: white,
                                      fontWeight: FontWeight.bold,
                                    ),
                            ],
                          ),
                        ),
                        sizedBox10,
                      ],
                    ),
                  )
                : RecentChatList();
          }),
        ));
  }
}
