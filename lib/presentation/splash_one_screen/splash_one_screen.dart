import 'controller/splash_one_controller.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class SplashOneScreen extends GetWidget<SplashOneController> {
  const SplashOneScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.deepPurple600,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imglogonew,
                height: getVerticalSize(
                  500,
                ),
                width: getHorizontalSize(
                  500,
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 17,
                  bottom: 5,
                ),
                child: Text(
                  "Copyright@2023 | Hindgreco".tr,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtSFProTextBoldWhite20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
