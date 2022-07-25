import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:chatapp_firebase/app/data/db_functions/db_functions.dart';
import 'package:chatapp_firebase/app/modules/all_users/controllers/all_users_controller.dart';
import 'package:chatapp_firebase/app/modules/home/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllUsersList extends StatelessWidget {
  AllUsersList({Key? key}) : super(key: key);

  final _allUsersControler = Get.put(AllUsersController());
  final _homeController = Get.put(HomeController());

  final _firebaseDB = Get.put(FirebaseDB());
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 50),
      itemCount: _allUsersControler.allUsers.length,
      itemBuilder: (context, index) {
        final data = _allUsersControler.allUsers[index];
        final name = data["name"];
        return SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () async{
                  // _homeController.getChatterDetails(name);
                  _firebaseDB.createChatConversations(
                    userName: name,
                    currentUserName: currentUser!.displayName!,
                  );
                },
                child: name != currentUser!.displayName!
                    ? Container(
                        decoration: BoxDecoration(
                          color: black45,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: white,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(data["imageURL"]),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            TextCustomized(
                              text: "${name.toString().capitalizeFirst}",
                              textSize: 20,
                              textColor: white,
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
              sizedBox10
            ],
          ),
        );
      },
    );
  }
}
