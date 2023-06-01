import 'package:get/get.dart';
import 'package:youapp_test/routes/routes_name.dart';
import 'package:youapp_test/views/home/initial_page.dart';
import 'package:youapp_test/views/login/login_page.dart';
import 'package:youapp_test/views/register/register_page.dart';

class AppPageRoute {
  static final pages = [
    GetPage(
      name: RouteName.goInitialPage,
      page: () => InitialPage(),
    ),
    GetPage(
      name: RouteName.goLoginPage,
      page: () => LoginPage(),
    ),
    GetPage(
      name: RouteName.goRegisterPage,
      page: () => RegisterPage(),
    ),
  ];
}
