import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/loading_widget.dart';
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
    return GetBuilder<HomeController>(
      builder: (context) {
        return
        _homeController.searchResult.isNotEmpty?GridView.builder(
          shrinkWrap: true,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: _homeController.searchResult.length,
          itemBuilder: (context, index) {
            final name = _homeController.searchResult[index]["name"];
            final email = _homeController.searchResult[index]["email"]
              ..toString().toUpperCase().capitalizeFirst!;
              final imageURL =_homeController.searchResult[index]["imageURL"];
            return name != currentUserName
                ? GestureDetector(
                    onTap: () {
                      firebaseDB.createChatConversations(imageURL: imageURL,
                          userName: name, currentUserName: currentUserName,email: email);
                      _homeController.searchController.text = "";
                      _homeController.searchResult.clear();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: black45,
                        image:  DecorationImage(
                          fit: BoxFit.cover,
                          image:NetworkImage(imageURL),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextCustomized(
                              text: name,
                              textSize: 18,
                              textColor: white,
                              fontWeight: FontWeight.bold),
                          sizedBox10,
                          TextCustomized(
                              text: email,
                              textSize: 14,
                              textColor: white,
                              fontWeight: FontWeight.bold),
                          sizedBox10,
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                      children: [
                        const LoadingWidget(),
                        sizedBox10,
                        TextCustomized(
                          text: "No matches Found",
                          textSize: 18,
                          textColor: white,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  );
          },
        ):Container();
      }
    );
  }
}
