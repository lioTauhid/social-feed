import 'dart:async';
import 'package:get/get.dart';
import '../../res/routes/routes_name.dart';
import '../../service/local/user_prefrence.dart';

class SplashController {
  // UserPreference userPreference = UserPreference();

  void isLogin() {
    /// Check login status and view page

    Timer(const Duration(seconds: 3), () => Get.toNamed(RouteName.loginView));

    // userPreference.getUser().then((value) {
    //   print(value.token);
    //   print(value.isLogin);
    //
    //   if (value.isLogin == false || value.isLogin.toString() == 'null') {
    //     Timer(
    //         const Duration(seconds: 3), () => Get.toNamed(RouteName.loginView));
    //   } else {
    //     Timer(
    //         const Duration(seconds: 3), () => Get.toNamed(RouteName.homeView));
    //   }
    // });
  }
}
