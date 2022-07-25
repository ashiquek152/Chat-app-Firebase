import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/modules/all_users/views/all_users_list.dart';
import 'package:chatapp_firebase/app/modules/all_users/views/search_list.dart';
import 'package:chatapp_firebase/app/modules/home/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/all_users_controller.dart';

class AllUsersView extends GetView<AllUsersController> {
  AllUsersView({Key? key}) : super(key: key);

  final _allUsersControler = Get.put(AllUsersController());
  final _homeController = Get.put(HomeController());
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: transparent,
        title: TextCustomized(text: "Contacts", textSize: 25, textColor: white),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: buttonColor),
          onPressed: () {
            Get.back();
            _homeController.getChatRooms(
                currentUserName: currentUser!.displayName ?? "");
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16.0, 0),
        child: Stack(
          children: [
            sizedBox10,
            SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder<AllUsersController>(builder: (context) {
                    return Visibility(
                        visible: _allUsersControler.allUsersVisibility,
                        child: AllUsersList());
                  }),
                  GetBuilder<AllUsersController>(builder: (context) {
                    return Visibility(
                        visible: _allUsersControler.searchListVisibility,
                        child: SearchList());
                  }),
                ],
              ),
            ),
            CupertinoSearchTextField(
              controller: _allUsersControler.searchController,
              backgroundColor: white,
              onChanged: (value) {
                _allUsersControler.getSearchResults();
                _allUsersControler.visibilitySwitch();
              },
            ),
          ],
        ),
      ),
    );
  }
}
