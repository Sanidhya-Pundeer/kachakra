import 'dart:async';
import 'package:get/get.dart';

import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/splash_screen/models/splash_model.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../log_in_screen/controller/log_in_controller.dart';

/// A controller class for the SplashScreen.
///
/// This class manages the state of the SplashScreen, including the
/// current splashModelObj
class SplashController extends GetxController {
  Rx<SplashModel> splashModelObj = SplashModel().obs;
  LogInController controller = Get.put(LogInController());
  SharedPreferences? _prefs;

  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      _getIsFirst();
    });
  }

  _getIsFirst() async {
    bool isSignIn = await PrefUtils.getIsSignIn();
    bool isIntro = await PrefUtils.getIsIntro();
    Map<String, dynamic>? userSession = await PrefUtils.getUserSession();

    Timer(const Duration(seconds: 3), () {
      print("is intro ====== ${isIntro}");
      print("isSignIn ====== ${isSignIn}");
      print("Username ${userSession!['username']}");
      print("userSession ===== ${userSession}");
      // isSignIn = true;
      if (isIntro) {
        Get.toNamed(AppRoutes.onboardingOneScreen);
      } else if (isSignIn) {
        Get.toNamed(AppRoutes.logInScreen);
      } else if (!isSignIn) {
        controller.phoneNumberController
            .setText(userSession!["username"].toString());
        controller.passwordController
            .setText(userSession!["password"].toString());
        print(controller.phoneNumberController.text.toString());
        controller.loginUser(
          onSuccess: () {
            Get.toNamed(AppRoutes.homeContainer1Screen);
          },
        );
      } else {
        Get.toNamed(AppRoutes.homeContainer1Screen);
      }
    });
  }
}
