import 'package:get/get.dart';

import '../controllers/all_users_controller.dart';

class AllUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllUsersController>(
      () => AllUsersController(),
    );
  }
}
