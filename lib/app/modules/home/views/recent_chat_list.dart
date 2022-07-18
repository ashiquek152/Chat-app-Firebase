import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/data/db_functions/db_functions.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentChatList extends StatelessWidget {
  RecentChatList({Key? key}) : super(key: key);

  final _authController = Get.put(AuthenticationController());
  final _firebaseDB = Get.put(FirebaseDB());
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: _firebaseDB.users.length,
      itemBuilder: (context, index) {
        final data = _firebaseDB.users[index]["users"];
        final name =
            data[1].toString() != _authController.currentUser!.displayName
                ? data[1].toString()
                : data[0].toString();
        return GestureDetector(
          onTap: () {
            _firebaseDB.createChatConversations(
                userName: name,
                currentUserName: _authController.currentUser!.displayName!);
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: black45),
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
    );
  }
}
