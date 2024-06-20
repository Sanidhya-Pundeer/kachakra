import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/payment_method_screen/razor_pay_api.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:courier_delivery/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/userData.dart';
import '../replace_bin_screen/widgets/waste_example_list.dart';
import 'controller/replace_bin_controller.dart';

class ReplaceBinScreen extends StatefulWidget {
  ReplaceBinScreen({Key? key}) : super(key: key);

  @override
  State<ReplaceBinScreen> createState() => _SendPackageScreenState();
}

class _SendPackageScreenState extends State<ReplaceBinScreen> {
  ReplaceBinController sendPackageController = Get.put(ReplaceBinController());

  List<String> familySize = ['1-4', '5-6', 'more than 6'];

  String? selectedFamilySize;
  int bin_price = 0;
  int addon_price = 0;
  int total_price = 0;
  SharedPreferences? _prefs;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: ColorConstant.whiteA700,
          statusBarIconBrightness: Brightness.dark),
    );
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
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
                    title: AppbarSubtitle1(text: "Replace Bin".tr),
                    styleType: Style.bgFillWhiteA700),
                body: GetBuilder<ReplaceBinController>(
                  init: ReplaceBinController(),
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
                                        Text("Bin Locaion".tr,
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
                                          maxLines:
                                              2, // Set to null or a value greater than 1 for multiple lines
                                          suffix: Container(
                                            margin: getMargin(
                                                left: 15,
                                                top: 15,
                                                right: 15,
                                                bottom: 15),
                                            child: CustomImageView(
                                              onTap: () async {},
                                              svgPath: ImageConstant
                                                  .imgLocationBlack900,
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
                              padding: getPadding(top: 16),
                              child: Text("Discover your Bin!".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtSubheadline)),
                          // if (selectedItem == 'Household')
                          Container(
                            margin: getMargin(top: 16),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                DropdownButton<String>(
                                  isExpanded: true,
                                  value: selectedFamilySize,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedFamilySize = newValue;
                                      if (selectedFamilySize == '1-4') {
                                        sendPackageController
                                            .updateChargeInfo('140');
                                        total_price = 140;
                                      }
                                      if (selectedFamilySize == '5-6') {
                                        sendPackageController
                                            .updateChargeInfo('225');
                                        total_price = 225;
                                      }
                                      if (selectedFamilySize == 'more than 6') {
                                        sendPackageController
                                            .updateChargeInfo('260');
                                        total_price = 260;
                                      }
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      value: null,
                                      child: Text(
                                          'Select Family Size!'), // Placeholder text
                                    ),
                                    ...familySize.map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 2,
                                                height: 20,
                                                color: Color(0xFF03BB85),
                                                margin:
                                                    EdgeInsets.only(right: 8),
                                              ),
                                              Text(item),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                  underline: Container(),
                                  style: AppStyle.txtAvenirRegular16,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: ColorConstant.primaryAqua,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getVerticalSize(16),
                          ),
                          if (selectedFamilySize == '1-4')
                            GestureDetector(
                              onTap: () async {
                                setState(() async {
                                  sendPackageController.updateChargeInfo('140');
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: ColorConstant.highlighter
                                      .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: profileDetail(ImageConstant.imgbin,
                                    "25 L", "Family Size"),
                              ),
                            ),
                          if (selectedFamilySize == '5-6')
                            GestureDetector(
                              onTap: () {
                                setState(() async {
                                  sendPackageController.updateChargeInfo('225');
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: ColorConstant.highlighter
                                      .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: profileDetail(ImageConstant.imgbin,
                                    "40 L", "Family Size"),
                              ),
                            ),
                          if (selectedFamilySize == 'more than 6')
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  sendPackageController.updateChargeInfo('260');
                                });
                                await _prefs?.setString('payment', '260' ?? '');
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: ColorConstant.highlighter
                                      .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: profileDetail(ImageConstant.imgbin,
                                    "50 L", "Family Size"),
                              ),
                            ),
                          if (selectedFamilySize == '1-4' ||
                              selectedFamilySize == '5-6' ||
                              selectedFamilySize == 'more than 6')
                            Container(
                              width: double.infinity,
                              child: Padding(
                                  padding: getPadding(top: 16),
                                  child: Text("Make your life a bit easier.".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: AppStyle.txtSubheadline)),
                            ),
                          if (selectedFamilySize == '1-4' ||
                              selectedFamilySize == '5-6' ||
                              selectedFamilySize == 'more than 6')
                            Container(
                              width: double.infinity,
                              child: Padding(
                                  padding: getPadding(top: 5),
                                  child: Text("With our Bin Accessories".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: AppStyle.txtSubheadline)),
                            ),
                          WasteExanpleList(selectedItem: selectedFamilySize),
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: CustomButton(
                    height: getVerticalSize(54),
                    text: "Pay: ₹ ".tr +
                        sendPackageController.chargeInfo.toString(),
                    margin: getMargin(left: 16, right: 16, bottom: 40),
                    onTap: () async {
                      await _prefs?.setString(
                          'payment', total_price.toString() ?? '');
                      if (selectedFamilySize != null) {
                        onTapNext();
                      }
                      ;
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
    // sendPackageController.generateRequest();
  }

  onTapArrowleft4() {
    Get.back();
  }

  Widget profileDetail(icon, value, previous) {
    return Container(
      child: Padding(
          padding: getPadding(left: 30, right: 20),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (selectedFamilySize == '1-4')
                              CustomImageView(
                                imagePath: icon,
                                width: getSize(50),
                                margin: getMargin(bottom: 10),
                              ),
                            if (selectedFamilySize == '5-6')
                              CustomImageView(
                                imagePath: icon,
                                width: getSize(70),
                                margin: getMargin(bottom: 10),
                              ),
                            if (selectedFamilySize == 'more than 6')
                              CustomImageView(
                                imagePath: icon,
                                width: getSize(90),
                                margin: getMargin(bottom: 10),
                              ),
                          ],
                        ),
                      ],
                    )),
                //
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Text(
                          value,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: ColorConstant.black900,
                            fontSize: 24,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: getHorizontalSize(10)),
                      ]),
                      SizedBox(height: getVerticalSize(2)),
                      Text(
                        'For ' + selectedFamilySize! + ' members',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ColorConstant.gray600,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]),
              ])),
    );
  }
}
