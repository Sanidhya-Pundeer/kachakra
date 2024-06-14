import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/safai_karamchari_screen/models/safai_karamchari_model.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:courier_delivery/presentation/safai_karamchari_screen/widgets/listsignal_item_widget.dart';


import '../home_container_page/controller/home_container_controller.dart';
import 'controller/safai_karamchari_controller.dart';

class SafaiKaramchariScreen extends StatefulWidget {
  const SafaiKaramchariScreen({Key? key}) : super(key: key);

  @override
  State<SafaiKaramchariScreen> createState() =>
      _SelectCourierServiceScreenState();
}

class _SelectCourierServiceScreenState
    extends State<SafaiKaramchariScreen> {
  SafaiKaramchariController controller =
  Get.put(SafaiKaramchariController());
  HomeContainerController homeContainerController =
  Get.put(HomeContainerController());

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: ColorConstant.whiteA700,
          statusBarIconBrightness: Brightness.dark),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: ColorfulSafeArea(
        color: ColorConstant.whiteA700,
        child: Scaffold(
          backgroundColor: ColorConstant.whiteA700,
          appBar: CustomAppBar(
            height: getVerticalSize(79),
            leadingWidth: 42,
            leading: AppbarImage(
              height: getSize(24),
              width: getSize(24),
              svgPath: ImageConstant.imgArrowleft,
              margin: getMargin(left: 18, top: 29, bottom: 26),
              onTap: () {
                onTapArrowleft8();
              },
            ),
            centerTitle: true,
            title: AppbarSubtitle1(text: "Karamchari Near You".tr),
            styleType: Style.bgFillWhiteA700,
          ),
            body: GetBuilder<SafaiKaramchariController>(
              init: SafaiKaramchariController(),
              builder: (controller) => SizedBox(
                height: getVerticalSize(800),
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: getPadding(left: 16, right: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView.separated(
                                padding: getPadding(bottom: 130),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: getVerticalSize(16),
                                  );
                                },
                                itemCount: controller.serviceData.length,
                                itemBuilder: (context, index) {
                                  NearbyKaramchariService model =
                                  controller.serviceData[index];
                                  return ListsignalItemWidget(model, index);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: getPadding(all: 16),
                        decoration: AppDecoration.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomButton(
                              height: getVerticalSize(54),
                              text: "lbl_next".tr,
                              margin: getMargin(bottom: 24),
                              onTap: () {
                                onTapNext();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }

  onTapNext() {
    Get.toNamed(
      AppRoutes.liveTrackingOneScreen,
    );
  }

  onTapArrowleft8() {
    Get.back();
  }
}
