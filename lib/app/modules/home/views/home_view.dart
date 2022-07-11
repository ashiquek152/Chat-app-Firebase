import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:chatapp_firebase/app/modules/search_screen/views/search_screen_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            // opacity: 180,
            image: AssetImage(
              "assets/HomeBg.jpg",
            ),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: transparent,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(
                      SearchScreenView(),
                    );
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          drawer: Drawer(
            elevation: 0.0,
            backgroundColor: black45,
            child: Column(
              children: [
                sizedBox10,
                sizedBox10,
                sizedBox10,
                Container(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage("assets/black_blue_BG.jpg"),
                      ),
                      sizedBox10,
                      TextCustomized(
                        text: "Profile Name",
                        textSize: 18,
                        textColor: white,
                      )
                    ],
                  ),
                ),
                sizedBox10,
                ElevatedButton(
                    style: TextButton.styleFrom(
                      primary: white,
                      backgroundColor: buttonColor,
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      AuthenticationController().isSignin =
                          !AuthenticationController().isSignin;
                    },
                    child: const Text("SignOut")),
              ],
            ),
          ),
          backgroundColor: transparent,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView.separated(
                    separatorBuilder: (context, index) {
                      return sizedBox10;
                    },
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const ListTile(
                        tileColor:black45,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
