import 'controller/splash_two_controller.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class SplashTwoScreen extends GetWidget<SplashTwoController> {
  const SplashTwoScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.deepPurple50,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                svgPath: ImageConstant.imgXmlid1,
                height: getVerticalSize(
                  107,
                ),
                width: getHorizontalSize(
                  113,
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 13,
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
