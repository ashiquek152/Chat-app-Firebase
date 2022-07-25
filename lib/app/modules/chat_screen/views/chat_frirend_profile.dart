import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/constants.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatingFriendProfile extends StatelessWidget {
  const ChatingFriendProfile(
      {Key? key,
      required this.imageURL,
      required this.userName,
      required this.email})
      : super(key: key);

  final String imageURL;
  final String userName;
  final String email;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Get.dialog(
            Center(
              child: Container(
                height: 200,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color:black45.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 65,
                      backgroundColor: white.withOpacity(0.3),
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: ClipOval(
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(imageURL),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultTextStyle(
                          style: const TextStyle(),
                          child: TextCustomized(
                            text: userName.capitalizeFirst!,
                            textSize: 18,
                            textColor: white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        sizedBox10,
                        DefaultTextStyle(
                          style: const TextStyle(),
                          child: TextCustomized(
                            text: email.capitalizeFirst!,
                            textSize: 16,
                            textColor: white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        sizedBox10,
                      ],
                    )
                  ],
                )),
              ),
            ),
          );
        },
        child: CircleAvatar(
          radius: 30,
          backgroundColor: buttonColor,
          child: CircleAvatar(
            radius: 16,
            backgroundColor: white,
            backgroundImage: NetworkImage(imageURL),
          ),
        ),
      ),
    );
  }
}
