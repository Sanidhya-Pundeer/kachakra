import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import 'controller/splash_controller.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController = Get.put(SplashController());
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: ColorConstant.whiteA700,
          statusBarIconBrightness: Brightness.dark),
    );
    super.initState();
    _checkLocationPermission();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.black900,
            body: SizedBox(
                width: double.maxFinite,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomImageView(
                          imagePath: ImageConstant.imglogowhite,
                          height: getVerticalSize(120),
                          width: getHorizontalSize(110)),
                      Padding(
                          padding: getPadding(top: 350, bottom: 5),
                          child: Text("Copyright@2023 | Hindgreco\n Hindustan Green Company".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: AppStyle.txtSFProTextBoldWhite20))
                    ]))));
  }

  Future<void> _checkLocationPermission() async {
    if (await Permission.location.request().isGranted) {
      // Permission is granted. You can initialize the map.
      // Initialize the map here
    } else {
      // Permission is not granted. Handle the case where the user denies permission.
    }
  }
}


