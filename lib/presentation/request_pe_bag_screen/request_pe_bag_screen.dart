import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:courier_delivery/widgets/custom_icon_button.dart';
import 'package:courier_delivery/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/userData.dart';
import 'controller/request_pe_bag_controller.dart';

class RequestPeBagScreen extends StatefulWidget {
  RequestPeBagScreen({Key? key}) : super(key: key);

  @override
  State<RequestPeBagScreen> createState() => _SendPackageScreenState();
}

class _SendPackageScreenState extends State<RequestPeBagScreen> {
  RequestPeBagController sendPackageController =
      Get.put(RequestPeBagController());

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
                resizeToAvoidBottomInset: false,
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
                          onTapArrowleft4();
                        }),
                    centerTitle: true,
                    title: AppbarSubtitle1(text: "PE Bags".tr),
                    styleType: Style.bgFillWhiteA700),
                body: GetBuilder<RequestPeBagController>(
                  init: RequestPeBagController(),
                  builder: (controller) => Container(
                    child: Padding(
                      padding: getPadding(left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomImageView(
                                svgPath: ImageConstant.imgTimeLineIcon,
                              ),
                              SizedBox(
                                width: getHorizontalSize(16),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text("Location".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtSubheadline),
                                        SizedBox(
                                          height: getVerticalSize(8),
                                        ),
                                        CustomTextFormField(
                                          alignment: Alignment.center,
                                          hintText: UserData.userAddress.tr,
                                          readOnly: true,
                                          maxLines: 2, // Set to null or a value greater than 1 for multiple lines
                                          suffix: Container(
                                            margin: getMargin(left: 15, top: 15, right: 15, bottom: 15),
                                            child: CustomImageView(
                                              onTap: () async {
                                              },
                                              svgPath: ImageConstant.imgLocationBlack900,
                                            ),
                                          ),
                                          suffixConstraints: BoxConstraints(
                                            maxHeight: getVerticalSize(54),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(16),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                              padding: getPadding(top: 19),
                              child: Text("Bag Size".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtSubheadline)),
                          CustomTextFormField(
                              hintText: "weight",
                              suffix: Padding(
                                padding: getPadding(top: 16, bottom: 16),
                                child: Text(
                                  "Kg",
                                  style: AppStyle.txtSFProDisplayRegular16,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              controller: controller.grouptwentyfourController,
                              margin: getMargin(top: 9),
                              textInputAction: TextInputAction.done,
                              variant: TextFormFieldVariant.OutlineGray300,
                              prefix: Container(
                                  margin: getMargin(
                                      left: 16, top: 15, right: 16, bottom: 15),
                                  child: CustomImageView(
                                      svgPath: ImageConstant.imgMail)),
                              prefixConstraints: BoxConstraints(
                                  maxHeight: getVerticalSize(54))),
                          Padding(
                              padding: getPadding(top: 19),
                              child: Text("Quantity".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtSubheadline)),
                          Container(
                              margin: getMargin(top: 9, bottom: 5),
                              padding: getPadding(
                                  left: 16, top: 13, right: 16, bottom: 13),
                              decoration: AppDecoration.outlineGray300.copyWith(
                                  borderRadius:
                                  BorderRadiusStyle.roundedBorder8),
                              child: Row(children: [
                                Padding(
                                    padding: getPadding(top: 5, bottom: 2),
                                    child: Text("lbl_1_package".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtBody)),
                                Spacer(),
                                CustomIconButton(
                                    onTap: () {
                                      controller.packageQuentyty == 1
                                          ? () {}
                                          : controller.decreseQuentity();
                                    },
                                    height: 28,
                                    width: 28,
                                    variant: IconButtonVariant.FillGray50,
                                    shape: IconButtonShape.CircleBorder14,
                                    child: CustomImageView(
                                        svgPath: ImageConstant.imgMenu)),
                                Padding(
                                    padding:
                                    getPadding(left: 10, top: 2, bottom: 2),
                                    child: Text(
                                        controller.packageQuentyty.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtBody)),
                                CustomIconButton(
                                    onTap: () {
                                      controller.increagePackageQuentity();
                                    },
                                    height: 28,
                                    width: 28,
                                    margin: getMargin(left: 11),
                                    variant:
                                    IconButtonVariant.FillDeeppurple600,
                                    shape: IconButtonShape.CircleBorder14,
                                    child: CustomImageView(
                                        svgPath: ImageConstant.imgPlus))
                              ]))
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: CustomButton(
                    height: getVerticalSize(54),
                    text: "lbl_next".tr,
                    margin: getMargin(left: 16, right: 16, bottom: 40),
                    onTap: () {
                      onTapNext();
                    }))));
  }

  onTapDeliverto() {
    Get.toNamed(
      AppRoutes.selectDeliveryAddressScreen,
    );
  }

  onTapPickup() {
    Get.toNamed(
      AppRoutes.selectPickupAddressScreen,
    );
  }

  onTapNext() {
    // Get.toNamed(
    //   AppRoutes.paymentMethodScreen,
    // );
    sendPackageController.generateRequest();

  }

  onTapArrowleft4() {
    Get.back();
  }
}