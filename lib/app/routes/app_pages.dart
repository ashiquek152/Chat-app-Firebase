import 'package:get/get.dart';

import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/authentication_view.dart';
import '../modules/chat_screen/bindings/chat_screen_binding.dart';
import '../modules/chat_screen/views/chat_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/wrapper/bindings/wrapper_binding.dart';
import '../modules/wrapper/views/wrapper_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WRAPPER;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () =>  HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.WRAPPER,
      page: () => WrapperView(),
      binding: WrapperBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_SCREEN,
      page: () =>   ChatScreenView(),
      binding: ChatScreenBinding(),
    ),
  ];
}
