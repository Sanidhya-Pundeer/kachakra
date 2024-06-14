import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:courier_delivery/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controller/plumbing_controller.dart';

class PlumbingScreen extends StatefulWidget {
  PlumbingScreen({Key? key}) : super(key: key);

  @override
  State<PlumbingScreen> createState() => _SendPackageScreenState();
}

class _SendPackageScreenState extends State<PlumbingScreen> {
  PlumbingController sendPackageController =
      Get.put(PlumbingController());

  List<String> items = ['Bathroom Drainage', 'Toilet Drainage', 'PVC Pipeline', 'Main Sewage'];
  String? selectedItem = 'Bathroom Drainage';

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
                    title: AppbarSubtitle1(text: "Drain Faults".tr),
                    styleType: Style.bgFillWhiteA700),
                body: GetBuilder<PlumbingController>(
                  init: PlumbingController(),
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
                                        Text("Address".tr,
                                            overflow:   TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtSubheadline),
                                        SizedBox(
                                          height: getVerticalSize(8),
                                        ),
                                        CustomTextFormField(
                                            hintText: "location".tr,
                                            suffix: Container(
                                                margin: getMargin(
                                                    left: 15,
                                                    top: 15,
                                                    right: 15,
                                                    bottom: 15),
                                                child: CustomImageView(
                                                    onTap: () {
                                                      Get.toNamed(AppRoutes
                                                          .selectPickupAddressScreen);
                                                    },
                                                    svgPath: ImageConstant
                                                        .imgLocationBlack900)),
                                            suffixConstraints: BoxConstraints(
                                                maxHeight:
                                                    getVerticalSize(54))),
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
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Blockage type:".tr,
                                    overflow:   TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtSubheadline,
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      style: AppStyle.txtSFProDisplayRegular16,
                                      value: selectedItem,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedItem = newValue;
                                        });
                                      },
                                      items: items.map((String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item),
                                        );
                                      }).toList(),

                                      underline: Container(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Padding(
                              padding: getPadding(top: 19),
                              child: Text("Any other problem?".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtSubheadline)),
                          CustomTextFormField(
                              hintText: "Clogged Drainage or PVC Pipleines",
                              controller: controller.grouptwentyfourController,
                              margin: getMargin(top: 9),
                              textInputAction: TextInputAction.done,
                              variant: TextFormFieldVariant.OutlineGray300,
                              prefix: Container(
                                  margin: getMargin(
                                      left: 16, top: 15, right: 16, bottom: 15),
                                  child: CustomImageView(
                                      svgPath: ImageConstant.imgAddIcon)),
                              prefixConstraints: BoxConstraints(
                                  maxHeight: getVerticalSize(54))),

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
    Get.toNamed(
      AppRoutes.paymentMethodScreen,
    );
  }

  onTapArrowleft4() {
    Get.back();
  }
}
