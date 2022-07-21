import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/data/db_functions/db_functions.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:chatapp_firebase/app/modules/home/views/profile_dialogue.dart';
import 'package:chatapp_firebase/app/modules/home/views/recent_chat_list.dart';
import 'package:chatapp_firebase/app/modules/home/views/search_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final homeController = Get.put(HomeController());
  final _firebaseDB = Get.put(FirebaseDB());
  final _authController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    _firebaseDB.getChatRooms(
        currentUserName:
            _authController.currentUser.value?.displayName??'');
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/new_bg.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: transparent,
            elevation: 0,
            title: TextCustomized(
              text: "Messages",
              textSize: 25,
              textColor: white,
              fontWeight: FontWeight.bold,
            ),
            actions: [
              ProfileDialogue(),
            ],
          ),
          backgroundColor: transparent,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoSearchTextField(
                    controller: homeController.searchController,
                    backgroundColor: white,
                    onChanged: (value) {
                      homeController.getSearchResults();
                    },
                  ),
                  sizedBox10,
                  SearchList(),
                  sizedBox10,
                  GetBuilder<FirebaseDB>(
                    builder: (controller2) {
                      return RecentChatList();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
