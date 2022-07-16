import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/data/db_functions/db_functions.dart';
import 'package:chatapp_firebase/app/modules/home/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchList extends StatelessWidget {
  SearchList({Key? key}) : super(key: key);
  final _homeController = Get.put(HomeController());

  final String currentUserName =
      FirebaseAuth.instance.currentUser!.displayName.toString();
  final firebaseDB = Get.put(FirebaseDB());

  @override
  Widget build(BuildContext context) {
    if (_homeController.searchResults != null) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _homeController.searchResults!.docs.length,
        itemBuilder: (context, index) {
          final name = _homeController.searchResults!.docs[index].get("name");
          final email = _homeController.searchResults!.docs[index]
              .get("email")
              .toString()
              .toUpperCase()
              .capitalizeFirst!;
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                decoration: BoxDecoration(
                    color: white.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: ListTile(
                  tileColor: transparent,
                  title: TextCustomized(
                      text: name, textSize: 18, textColor: white),
                  subtitle: TextCustomized(
                      text: email, textSize: 14, textColor: black45),
                  trailing: TextCustomized(
                      text: "Tap to meassage",
                      textSize: 14,
                      textColor: buttonColor),
                  onTap: () async {
                    await firebaseDB.createChatConversations(
                        userName: name, currentUserName: currentUserName);
                    _homeController.searchController.text = "";
                    _homeController.searchResults!.docs.clear();
                    _homeController.visibilty = false;
                  },
                ),
              ),
              sizedBox10
            ],
          );
        },
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
