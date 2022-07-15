import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/data/db_functions/db_functions.dart';
import 'package:chatapp_firebase/app/modules/search_screen/controllers/search_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchList extends StatelessWidget {
  SearchList({Key? key}) : super(key: key);
  final searchController = Get.put(SearchScreenController());

  @override
  Widget build(BuildContext context) {
    if (searchController.searchResults != null) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: searchController.searchResults!.docs.length,
        itemBuilder: (context, index) {
          // log(searchData[index]);
          final name = searchController.searchResults!.docs[index]
              .get("name")
              .toString()
              .toUpperCase()
              .capitalizeFirst!;
          final email = searchController.searchResults!.docs[index]
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
                  onTap: ()async {
                    await FirebaseDB().createChatConversations(name);
                    searchController.searchTextController.text="";
                    searchController.searchResults!.docs.clear();
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
