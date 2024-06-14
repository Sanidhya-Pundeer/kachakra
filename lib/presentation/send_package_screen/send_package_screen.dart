import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/data/userData.dart';
import 'package:courier_delivery/presentation/send_package_screen/models/waste_example_list.dart';
import 'package:courier_delivery/presentation/show_loading_screen/show_loading_screen.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:courier_delivery/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controller/send_package_controller.dart';
import 'models/card_item_list.dart';

class SendPackageScreen extends StatefulWidget {
  SendPackageScreen({Key? key}) : super(key: key);

  @override
  State<SendPackageScreen> createState() => _SendPackageScreenState();
}

class _SendPackageScreenState extends State<SendPackageScreen> {
  SendPackageController sendPackageController =
  Get.put(SendPackageController());

  List<String> items = ['Construction Waste', 'Bulky Waste'];

  String? selectedItem = 'Construction Waste';

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
    final arguments = Get.arguments;
    final previous_screen = arguments != null ? arguments['previous_screen'] : null;

    if (UserData.userType == 'industry'){
    items = ['Construction Waste'];
    }
    if ((UserData.userType == 'industry') && (previous_screen == 'wastewater_industry')) {
      items = ['Sewage Wastewater'];
      selectedItem = 'Sewage Wastewater';
    }// accessing the argument

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
            title: AppbarSubtitle1(text: "lbl_send_package2".tr),
            styleType: Style.bgFillWhiteA700,
          ),
          body: SingleChildScrollView(
            child: GetBuilder<SendPackageController>(
              init: SendPackageController(),
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
                                      controller: sendPackageController.locationController,
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
                                            // Position position = await Geolocator.getCurrentPosition(
                                            //   desiredAccuracy: LocationAccuracy.high,
                                            // );
                                            Get.toNamed(
                                              AppRoutes.selectLocationScreen,
                                              arguments: {'sourceScreen': 'SchedulePickUp'},
                                            );
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
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Type of waste:".tr,
                                overflow: TextOverflow.ellipsis,
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
                                      value: selectedItem,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedItem = newValue;
                                        });
                                      },
                                      items: items.map((String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(vertical: 8),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 2,
                                                  height: 20,
                                                  color: Color(0xFF03BB85),
                                                  margin: EdgeInsets.only(right: 8),
                                                ),
                                                Text(item),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      underline: Container(),
                                      style: AppStyle.txtAvenirRegular16,
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: ColorConstant.primaryAqua,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    if (selectedItem != null)
                                      CardItemList(selectedItem: selectedItem),
                                    SizedBox(height: 16),
                                  ],
                                ),
                              ),
                              if (selectedItem != null)
                                SizedBox(
                                  height: getVerticalSize(24),
                                ),
                                Text(
                                  "What kind of materials are in " + selectedItem! + "?".tr,
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
                              SizedBox(height: 16),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShowLoadingScreen()),
              );

              // onTapNext();
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
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ShowLoadingScreen()),
    );
    // sendPackageController.generateRequest();
  }

  onTapArrowleft4() {
    Get.back();
    UserData.userCurrentAddress = "";

  }

  void navigateBack(dynamic arguments) {
    if (arguments != null && arguments['message'] != null) {
      Get.back();
    }
  }
}
