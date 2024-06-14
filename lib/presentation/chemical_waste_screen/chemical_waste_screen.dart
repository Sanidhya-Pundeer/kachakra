import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/data/userData.dart';
import 'package:courier_delivery/presentation/chemical_waste_screen/models/card_item_list.dart';
import 'package:courier_delivery/presentation/chemical_waste_screen/models/waste_example_list.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:courier_delivery/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../show_loading_screen/show_loading_screen.dart';
import 'controller/chemical_waste_controller.dart';

class ChemicalWasteScreen extends StatefulWidget {
  ChemicalWasteScreen({Key? key}) : super(key: key);

  @override
  State<ChemicalWasteScreen> createState() => _SendPackageScreenState();
}

class _SendPackageScreenState extends State<ChemicalWasteScreen> {
  ChemicalWasteController sendPackageController =
      Get.put(ChemicalWasteController());

  List<String> items = ['Re-Sell: \n"Turn your waste materials and get paid."'];

  String? selectedItem = 'Re-Sell: \n"Turn your waste materials and get paid."';

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorConstant.whiteA700,
        statusBarIconBrightness: Brightness.dark,
      ),
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
              height: getSize(25),
              width: getSize(24),
              svgPath: ImageConstant.imgArrowleft,
              margin: getMargin(left: 18, top: 29, bottom: 26),
              onTap: () {
                onTapArrowleft4();
              },
            ),
            centerTitle: true,
            title: AppbarSubtitle1(text: "Chemical Waste".tr),
            styleType: Style.bgFillWhiteA700,
          ),
          body: SingleChildScrollView(
            child: GetBuilder<ChemicalWasteController>(
              init: ChemicalWasteController(),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "lbl_pickup_from".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSubheadline,
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(8),
                                    ),
                                    CustomTextFormField(
                                      hintText: UserData.userCurrentAddress == "" ? UserData.userAddress.tr : UserData.userCurrentAddress.tr,
                                      maxLines: 2,
                                      suffix: Container(
                                        margin: getMargin(
                                          left: 15,
                                          top: 15,
                                          right: 15,
                                          bottom: 15,
                                        ),
                                        child: CustomImageView(
                                          onTap: () async {
                                            // Position position = await Geolocator
                                            //     .getCurrentPosition(
                                            //   desiredAccuracy:
                                            //       LocationAccuracy.high,
                                            // );
                                            Get.toNamed(
                                              AppRoutes.selectLocationScreen,
                                              arguments: {'sourceScreen': 'ChemicalWaste'},
                                            );
                                          },
                                          svgPath:
                                              ImageConstant.imgLocationBlack900,
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
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "What you want to do?".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSubheadline,
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  children: [
                                    Row(
                                      children: items.map((String item) {
                                        return Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                selectedItem = item;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(16.0), backgroundColor: selectedItem == item
                                                  ? ColorConstant.primaryAqua
                                                  : Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: Text(
                                              item,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontStyle: FontStyle.italic,
                                                color: selectedItem == item
                                                    ? Colors.white
                                                    : ColorConstant.primaryAqua,
                                              ),
                                            ),
                                          ),
                                        ));
                                      }).toList(),
                                    ),
                                    if (selectedItem != null)
                                      CardItemList(selectedItem: selectedItem),
                                    SizedBox(height: 16),
                                  ],
                                ),
                              ),
                              if (selectedItem != null)
                                Text(
                                  "Select chemical to Re-Sell!".tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              SizedBox(
                                height: getVerticalSize(5),
                              ),
                              WasteExanpleList(selectedItem: selectedItem),
                              SizedBox(
                                height: getVerticalSize(5),
                              ),
                              Obx(() {
                                return Padding(
                                      padding: getPadding(left: 15, right: 15),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Select your pickup type!".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "Charges: ₹ " +
                                                  controller
                                                      .chargeInfo.value.tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ]));}),
                              Container(
                                  margin: getMargin(all: 10),
                                  alignment: Alignment.center,
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              sendPackageController
                                                  .updateChargeInfo('0');
                                            },
                                            child: Container(
                                                width: 160,
                                                padding: getPadding(all: 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.6),
                                                      spreadRadius: 1,
                                                      blurRadius: 1,
                                                      offset: Offset(0, 1),
                                                    ),
                                                  ],
                                                ),
                                                alignment: Alignment.center,
                                                child: Column(children: [
                                                  Text(
                                                    'Free Pick-Up',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: ColorConstant
                                                            .highlighter),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    '( Every Saturday )',
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black),
                                                    textAlign: TextAlign.center,
                                                  ),Text(
                                                    'Between 9 - 11 AM',
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        fontStyle:
                                                        FontStyle.italic,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        color: Colors.black),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ]))),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              sendPackageController
                                                  .updateChargeInfo('150');
                                            },
                                            child: Container(
                                                width: 160,
                                                padding: getPadding(all: 10),
                                                decoration: BoxDecoration(
                                                  color: ColorConstant
                                                      .highlighter
                                                      .withOpacity(0.8),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.6),
                                                      spreadRadius: 1,
                                                      blurRadius: 1,
                                                      offset: Offset(0, 1),
                                                    ),
                                                  ],
                                                ),
                                                alignment: Alignment.center,
                                                child: Column(children: [
                                                  Text(
                                                    'Immediate Pick-Up',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: ColorConstant
                                                            .whiteA700),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    '( ₹ 10 per km )',
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: ColorConstant
                                                            .gray300),
                                                    textAlign: TextAlign.center,
                                                  ),Text(
                                                    'Calculate Charges',
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        fontStyle:
                                                        FontStyle.italic,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        color: ColorConstant
                                                            .gray300),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ]))),
                                      ])),
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
          bottomNavigationBar: CustomButton(
            height: getVerticalSize(54),
            text: "lbl_next".tr,
            margin: getMargin(left: 16, right: 16, bottom: 40),
            onTap: () {
              onTapNext();
            },
          ),
        ),
      ),
    );
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
    // sendPackageController.generateRequest();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ShowLoadingScreen()),
    );
  }

  onTapArrowleft4() {
    Get.back();
  }

  void navigateBack(dynamic arguments) {
    if (arguments != null && arguments['message'] != null) {
      Get.back();
    }
  }
}
