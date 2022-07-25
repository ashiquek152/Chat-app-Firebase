import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/data/db_functions/db_functions.dart';
import 'package:chatapp_firebase/app/modules/all_users/controllers/all_users_controller.dart';
import 'package:chatapp_firebase/app/modules/all_users/views/all_users_view.dart';
import 'package:chatapp_firebase/app/modules/home/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentChatList extends StatelessWidget {
  RecentChatList({Key? key}) : super(key: key);

  final _homeController = Get.put(HomeController());
  final _firebaseDB = Get.put(FirebaseDB());
  final _allUsersController = Get.put(AllUsersController());
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextCustomized(
              text: "Recent Chats",
              textSize: 20,
              textColor: white,
              fontWeight: FontWeight.bold,
            ),
            GestureDetector(
              onTap: () async {
                await _allUsersController.getAllUsers();
                Get.to(() => AllUsersView());
              },
              child: Container(
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextCustomized(
                      text: "Contacts",
                      textSize: 16,
                      textColor: white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        sizedBox20,
        ListView.separated(
          shrinkWrap: true,
          itemCount: _homeController.recentChatNames.length,
          itemBuilder: (context, index) {
            final data = _homeController.recentChatNames[index]["users"];
            final name = data[1].toString() != currentUser!.displayName
                ? data[1].toString()
                : data[0].toString();
            // final chatRoomID =
            //     _homeController.recentChatNames[index]["roomId"].toString();
            return GestureDetector(
              onTap: ()async {
                await _homeController.getChatterDetails(name);
                _firebaseDB.createChatConversations(
                    userName: name, currentUserName: currentUser!.displayName!);
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: black45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustomized(
                        text: name.capitalizeFirst!,
                        textSize: 18,
                        textColor: white,
                        fontWeight: FontWeight.bold),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return sizedBox10;
          },
        ),
      ],
    );
  }
}
