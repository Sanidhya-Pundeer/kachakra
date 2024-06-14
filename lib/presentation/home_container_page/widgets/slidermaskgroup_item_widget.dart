import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../data/userData.dart';
import '../controller/home_container_controller.dart';
import '../models/home_slider_model.dart';

// ignore: must_be_immutable
class SlidermaskgroupItemWidget extends StatelessWidget {
  SlidermaskgroupItemWidget(
    this.slidermaskgroupItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  HomeSlider slidermaskgroupItemModelObj;

  var controller = Get.find<HomeContainerController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerWidth = constraints.maxWidth * 0.95;
        double containerHeight = containerWidth * 0.36;

        return Container(
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(slidermaskgroupItemModelObj.image!),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Padding(
            padding: getPadding(top: 25, left: 16, bottom: 16),
            child: SingleChildScrollView( // Wrap the Column in a SingleChildScrollView
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: containerWidth * 0.52,
                    child: Text(
                      slidermaskgroupItemModelObj.title!,
                      maxLines: null,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtHeadlineWhiteA700,
                    ),
                  ),
                  SizedBox(
                    height: containerHeight * 0.01,
                  ),
                  CustomButton(
                    onTap: () {
                      onTapSliderView(slidermaskgroupItemModelObj.link!);
                    },
                    height: containerHeight * 0.13,
                    width: containerWidth * 0.21,
                    text: "Check".tr,
                    variant: ButtonVariant.White,
                    padding: ButtonPadding.PaddingAll8,
                    fontStyle: ButtonFontStyle.SFProTextBold15,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  onTapSliderView(String appNavigation) async {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    try {
      var position = await Geolocator.getCurrentPosition();
      UserData.currentPosition = position;
      // Navigate to the redeem stations map screen
      await
      Get.toNamed(
        appNavigation,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch location: $e');
    } finally {
      // Close the CircularProgressIndicator() when returning to this screen
      Get.back();
    }
  }
}
