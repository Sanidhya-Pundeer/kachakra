import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/data/userData.dart';
import 'package:courier_delivery/presentation/textile_waste_screen/models/waste_example_list.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:courier_delivery/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../show_loading_screen/show_loading_screen.dart';
import 'controller/textile_waste_controller.dart';
import 'models/card_item_list.dart';

class TextileWasteScreen extends StatefulWidget {
  TextileWasteScreen({Key? key}) : super(key: key);

  @override
  State<TextileWasteScreen> createState() => _SendPackageScreenState();
}

class _SendPackageScreenState extends State<TextileWasteScreen> {
  TextileWasteController sendPackageController =
      Get.put(TextileWasteController());

  List<String> items = ['Sell Old', 'Upcycle', 'Tailors'];

  String? selectedItem = 'Sell Old';

  String? selectedCategory;

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
            title: AppbarSubtitle1(text: "Textile Waste".tr),
            styleType: Style.bgFillWhiteA700,
          ),
          body: SingleChildScrollView(
            child: GetBuilder<TextileWasteController>(
              init: TextileWasteController(),
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
                                      hintText:
                                          UserData.userCurrentAddress == ""
                                              ? UserData.userAddress.tr
                                              : UserData.userCurrentAddress.tr,
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
                                              arguments: {
                                                'sourceScreen': 'TextileWaste'
                                              },
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
                      if (UserData.userType == 'household')
                        Padding(
                          padding: getPadding(top: 19),
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "What you want to do?:".tr,
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
                                                backgroundColor: selectedItem == item
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
                                                  color: selectedItem == item
                                                      ? Colors.white
                                                      : ColorConstant
                                                          .primaryAqua,
                                                ),
                                              ),
                                            ),
                                          ));
                                        }).toList(),
                                      ),
                                      if (selectedItem != null)
                                        CardItemList(
                                            selectedItem: selectedItem),
                                      SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                                if (selectedItem != null)
                                  WasteExanpleList(selectedItem: selectedItem),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      if (UserData.userType == 'industry')
                        Padding(
                          padding: getPadding(left: 16, right: 16),
                          child: Column(
                              children: [
                            Text(
                              "Please select preferred textile category?:".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSubheadline,
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                category_button_industry(
                                    "Acrylic".tr, ImageConstant.imgScrapIcon),
                                SizedBox(
                                  width: getHorizontalSize(16),
                                ),
                                category_button_industry(
                                    "Cotton".tr, ImageConstant.imgTextileIcon),
                                SizedBox(
                                  width: getHorizontalSize(16),
                                ),
                                category_button_industry(
                                    "Nylon".tr, ImageConstant.imgTextileIcon),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                category_button_industry(
                                    "Wool".tr, ImageConstant.imgChemicalIcon),
                                SizedBox(
                                  width: getHorizontalSize(16),
                                ),
                                category_button_industry(
                                    "Silk".tr, ImageConstant.imgWastewaterIcon),
                                SizedBox(
                                  width: getHorizontalSize(16),
                                ),
                                category_button_industry(
                                    "Fabric".tr, ImageConstant.imgTextileIcon),
                              ],
                            ),
                            Padding(
                                padding: getPadding(top: 10),
                                child: Text("".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtSubheadline)),
                            CustomTextFormField(
                                hintText: "Estimated Weight (Optional)",
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

                          ]),
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

  Widget category_button_industry(String text, String icon) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Update the selected category and trigger UI update
          setState(() {
            selectedCategory = text;
          });
        },
        child: Column(
          children: [
            Container(
              padding: getPadding(all: 1),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2), // Offset of the shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(getHorizontalSize(60)),
                // Set the background color based on whether this category is selected
                color: selectedCategory == text
                    ? ColorConstant.highlighter.withOpacity(0.3)
                    : Colors.white,
              ),
              height: getSize(110),
              width: getSize(110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: icon,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getHorizontalSize(8),
            ),
            Text(
              text,
              maxLines: null,
              textAlign: TextAlign.center,
              style: AppStyle.txtSFProTextMedium14,
            )
          ],
        ),
      ),
    );
  }
}
