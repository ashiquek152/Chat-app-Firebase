import 'package:get/get.dart';

import '../modules/all_users/bindings/all_users_binding.dart';
import '../modules/all_users/views/all_users_view.dart';
import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/authentication_view.dart';
import '../modules/chat_screen/bindings/chat_screen_binding.dart';
import '../modules/chat_screen/views/chat_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/new_login_options/bindings/new_login_options_binding.dart';
import '../modules/new_login_options/views/new_login_options_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/wrapper/bindings/wrapper_binding.dart';
import '../modules/wrapper/views/wrapper_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
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
      page: () => ChatScreenView(),
      binding: ChatScreenBinding(),
    ),
    GetPage(
      name: _Paths.NEW_LOGIN_OPTIONS,
      page: () => NewLoginOptionsView(),
      binding: NewLoginOptionsBinding(),
    ),
    GetPage(
      name: _Paths.ALL_USERS,
      page: () => AllUsersView(),
      binding: AllUsersBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () =>  SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
  ];
}
