import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
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
            opacity: 180,
            image: AssetImage(
              "assets/HomeBg.jpg",
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
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
                    return  const ListTile(
                          tileColor: Colors.amber,
                        );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
