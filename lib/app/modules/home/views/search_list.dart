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
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: _homeController.searchResult.length,
      itemBuilder: (context, index) {
        final name = _homeController.searchResult[index]["name"];
        final email = _homeController.searchResult[index]["email"]
          ..toString().toUpperCase().capitalizeFirst!;
        return name != currentUserName
            ? GestureDetector(
                onTap: () {
                  firebaseDB.createChatConversations(
                      userName: name, currentUserName: currentUserName);
                  _homeController.searchController.text = "";
                  _homeController.searchResult.clear();
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: black45,
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/BB.jpg"),
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
    );

    // ListView.separated(
    //   shrinkWrap: true,
    //   physics: const NeverScrollableScrollPhysics(),
    //   itemCount: _homeController.searchResult.length,
    //   itemBuilder: (context, index) {
    //     final name = _homeController.searchResult[index]["name"];
    //     final email = _homeController.searchResult[index]["email"]
    //       ..toString().toUpperCase().capitalizeFirst!;
    //     return name != currentUserName
    //         ? GestureDetector(
    //             onTap: () {
    //               firebaseDB.createChatConversations(
    //                   userName: name, currentUserName: currentUserName);
    //               _homeController.searchController.text = "";
    //               _homeController.searchResult.clear();
    //             },
    //             child: Container(
    //               padding: const EdgeInsets.all(15),
    //               height: 70,
    //               decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(25), color: black45),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   TextCustomized(
    //                       text: name,
    //                       textSize: 18,
    //                       textColor: white,
    //                       fontWeight: FontWeight.bold),
    //                   TextCustomized(
    //                       text: email,
    //                       textSize: 18,
    //                       textColor: white,
    //                       fontWeight: FontWeight.bold),
    //                 ],
    //               ),
    //             ),
    //           )
    //         : Center(
    //             child: Column(
    //               children: [
    //                 const LoadingWidget(),
    //                 sizedBox10,
    //                 TextCustomized(
    //                   text: "No matches Found",
    //                   textSize: 18,
    //                   textColor: white,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ],
    //             ),
    //           );
    //   },
    //   separatorBuilder: (context, index) {
    //     return sizedBox10;
    //   },
    // );
  }
}
