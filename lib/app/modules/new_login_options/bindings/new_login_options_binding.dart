import 'package:get/get.dart';

import '../controllers/new_login_options_controller.dart';

class NewLoginOptionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewLoginOptionsController>(
      () => NewLoginOptionsController(),
    );
  }
}
