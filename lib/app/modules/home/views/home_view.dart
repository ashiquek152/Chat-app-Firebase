import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/data/db_functions/db_functions.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:chatapp_firebase/app/modules/home/views/search_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final homeController = Get.put(HomeController());
  final _firebaseDB = Get.put(FirebaseDB());

  @override
  Widget build(BuildContext context) {
    _firebaseDB.getChatRooms(
        currentUserName: homeController.currentUser!.displayName.toString());
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            "assets/new_bg.jpg",
          ),
        ),
      ),
      child: Scaffold(
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
            GestureDetector(
              onTap: () {
                Get.dialog(Center(
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultTextStyle(
                            style: const TextStyle(),
                            child: TextCustomized(
                              text: homeController.currentUser!.displayName
                                  .toString(),
                              textSize: 18,
                              textColor: black45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          sizedBox10,
                          DefaultTextStyle(
                            style: const TextStyle(),
                            child: TextCustomized(
                              text:
                                  homeController.currentUser!.email.toString(),
                              textSize: 16,
                              textColor: black45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          sizedBox10,
                          ElevatedButton(
                              style: TextButton.styleFrom(
                                primary: white,
                                backgroundColor: buttonColor,
                              ),
                              onPressed: () async {
                                Get.back();
                                // homeController.currentUser!.delete();
                                AuthenticationController().isSignin =
                                    !AuthenticationController().isSignin;
                                await FirebaseAuth.instance.signOut();
                              },
                              child: const Text("SignOut")),
                        ],
                      ),
                    ),
                  ),
                ));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: homeController.currentUser == null
                    ? const CircleAvatar(
                        radius: 25.0,
                        backgroundImage: AssetImage("assets/BB.jpg"),
                      )
                    : CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                            homeController.currentUser!.photoURL != null
                                ? homeController.currentUser!.photoURL
                                    .toString()
                                : ""),
                      ),
              ),
            ),
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
                  onChanged: (value) async {
                    await homeController.getSearchResults();
                  },
                ),
                sizedBox10,
                GetBuilder<HomeController>(
                  builder: (controller) {
                    return Visibility(
                        visible: homeController.visibilty, child: SearchList());
                  },
                ),
                // TextButton(
                //     onPressed: () {
                //       _firebaseDB.getChatRooms(
                //           currentUserName: homeController
                //               .currentUser!.displayName
                //               .toString());
                //     },
                //     child: const Text("Users list")),
                // //  NavigationRail(
                //     destinations: const <NavigationRailDestination>[
                //       NavigationRailDestination(
                //           label: Text("Home"), icon: Icon(Icons.house)),
                //       NavigationRailDestination(
                //           label: Text("Chats"), icon: Icon(Icons.message)),
                //       NavigationRailDestination(
                //           label: Text("Profile"), icon: Icon(Icons.person)),
                //     ],
                //     selectedIndex: homeController.selectedIndex,
                //     onDestinationSelected:
                //         homeController.changeDestination(2),
                //   ),

                GetBuilder<FirebaseDB>(builder: (controller) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: _firebaseDB.users.length,
                    itemBuilder: (context, index) {
                      final data = _firebaseDB.users[index]["users"];
                      final name = data[1].toString() !=
                              homeController.currentUser!.displayName
                          ? data[1].toString()
                          : data[0].toString();
                      return GestureDetector(
                        onTap: () {
                          _firebaseDB.createChatConversations(
                              userName: name,
                              currentUserName:
                                  homeController.currentUser!.displayName!);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          height: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: black45),
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

                      // ListTile(
                      //   tileColor: black45,
                      //   title: TextCustomized(
                      //       text: data[0].toString().capitalizeFirst!,
                      //       textSize: 18,
                      //       textColor: white,fontWeight: FontWeight.bold),
                      // );
                    },
                    separatorBuilder: (context, index) {
                      return sizedBox10;
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
