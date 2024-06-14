import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home_container_page/controller/home_container_controller.dart';
import '../home_container_page/models/nearby_service_model.dart';
import '../select_courier_service_screen/widgets/listsignal_item_widget.dart';
import 'controller/select_courier_service_controller.dart';

class SelectCourierServiceScreen extends StatefulWidget {
  const SelectCourierServiceScreen({Key? key}) : super(key: key);

  @override
  State<SelectCourierServiceScreen> createState() =>
      _SelectCourierServiceScreenState();
}

class _SelectCourierServiceScreenState
    extends State<SelectCourierServiceScreen> {
  SelectCourierServiceController controller =
      Get.put(SelectCourierServiceController());
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
                        }),
                    centerTitle: true,
                    title: AppbarSubtitle1(text: "Collection vehicles".tr),
                    styleType: Style.bgFillWhiteA700),
                body: GetBuilder<HomeContainerController>(
                  init: HomeContainerController(),
                  builder: (controller) => SizedBox(
                      height: getVerticalSize(800),
                      width: double.maxFinite,
                      child:
                          Stack(alignment: Alignment.bottomCenter, children: [
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
                                              separatorBuilder:
                                                  (context, index) {
                                                return SizedBox(
                                                    height:
                                                        getVerticalSize(16));
                                              },
                                              itemCount:
                                                  controller.courierData.length,
                                              itemBuilder: (context, index) {
                                                NearbyService model =
                                                    controller
                                                        .courierData[index];
                                                return ListsignalItemWidget(
                                                    model, index);
                                              })),
                                    ]))),
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
                                          })
                                    ])))
                      ])),
                ))));
  }

  onTapNext() {
    Get.toNamed(
      AppRoutes.paymentMethodScreen,
    );
  }

  onTapArrowleft8() {
    Get.back();
  }
}
