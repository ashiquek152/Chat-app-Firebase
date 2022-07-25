import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/data/db_functions/db_functions.dart';
import 'package:chatapp_firebase/app/modules/all_users/controllers/all_users_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchList extends StatelessWidget {
  SearchList({Key? key}) : super(key: key);

  final _allUsersController = Get.put(AllUsersController());
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final _firebaseDB = Get.put(FirebaseDB());
  @override
  Widget build(BuildContext context) {
    final searchList = _allUsersController.searchResult;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 50),
      itemCount: searchList.length,
      itemBuilder: (context, index) {
        final data = searchList[index];
        final name = data["name"];
        final email = data["email"];
        final imageURL = searchList[index]["imageURL"];
        if (name == currentUser!.displayName!) {
          return Container();
        } else if (name != _allUsersController.searchController.text.trim()) {
          return TextCustomized(
              text: "No matches found", textSize: 16, textColor: white);
        }
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                _firebaseDB.createChatConversations(
                  userName: name,
                  currentUserName: currentUser!.displayName!,
                );
                _allUsersController.searchController.text = "";
                _allUsersController.searchResult.clear();
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: black45,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageURL),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustomized(
                        text: name.toString().toUpperCase().capitalizeFirst!,
                        textSize: 18,
                        textColor: white,
                        fontWeight: FontWeight.bold),
                    sizedBox10,
                    TextCustomized(
                        text: email.toString().toUpperCase().capitalizeFirst!,
                        textSize: 14,
                        textColor: white,
                        fontWeight: FontWeight.bold),
                    sizedBox10,
                  ],
                ),
              ),
            ),
            sizedBox10,
          ],
        );
      },
    );
  }
}
