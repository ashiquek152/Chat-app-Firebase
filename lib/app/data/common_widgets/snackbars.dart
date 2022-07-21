import 'package:chatapp_firebase/app/data/common_widgets/colors.dart';
import 'package:chatapp_firebase/app/data/common_widgets/text_widget_customized.dart';
import 'package:get/get.dart';

welcomeSnackBar(user) {
  Get.snackbar("", "",
      backgroundColor: buttonColor.withOpacity(0.8),
      snackStyle: SnackStyle.FLOATING,
      titleText: TextCustomized(
        text: "Welcome $user",
        textSize: 16,
        textColor: white,
      ));
}

errorSnackBar(erroMessage) {
  Get.snackbar("", "",
      backgroundColor: red.withOpacity(0.8),
      snackStyle: SnackStyle.FLOATING,
      titleText: TextCustomized(
        text: erroMessage.toString(),
        textSize: 16,
        textColor: white,
      ));
}
