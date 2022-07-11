import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/modules/search_screen/views/search_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_screen_controller.dart';

class SearchScreenView extends GetView<SearchScreenController> {
  SearchScreenView({Key? key}) : super(key: key);

  final searchController = Get.put(SearchScreenController());
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
        child: SafeArea(
          child: Scaffold(
            backgroundColor: transparent,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                            searchController.searchTextController.text="";
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 35,
                            color: white,
                          ),
                        )
                      ],
                    ),
                    CupertinoSearchTextField(
                      controller: searchController.searchTextController,
                      backgroundColor: white,
                      onChanged: (value) async {
                        await searchController.getSearchResults();
                      },
                    ),
                    sizedBox10,
                    GetBuilder<SearchScreenController>(
                      builder: (controller) {
                        return Visibility(
                            visible: searchController.visibilty,
                            child: SearchList());
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
