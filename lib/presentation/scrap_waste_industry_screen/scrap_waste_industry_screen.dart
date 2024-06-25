import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/data/userData.dart';
import 'package:courier_delivery/presentation/scrap_waste_industry_screen/widgets/category_button_industry_widget.dart';
import 'package:courier_delivery/presentation/textile_waste_screen/models/waste_example_list.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:courier_delivery/widgets/custom_icon_button.dart';
import 'package:courier_delivery/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import '../show_loading_screen/show_loading_screen.dart';
import 'controller/scrap_waste_industry_controller.dart';
import 'models/scrap_waste_industry_card_item_list.dart';
import 'widgets/category_button_industry_widget.dart';

class ScrapWasteIndustryScreen extends StatefulWidget {
  ScrapWasteIndustryScreen({Key? key}) : super(key: key);

  @override
  State<ScrapWasteIndustryScreen> createState() => _SendPackageScreenState();
}

class _SendPackageScreenState extends State<ScrapWasteIndustryScreen> {
  ScrapWasteIndustryController sendPackageController =
      Get.put(ScrapWasteIndustryController());

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
            title: AppbarSubtitle1(text: "Scrap Waste".tr),
            styleType: Style.bgFillWhiteA700,
          ),
          body: SingleChildScrollView(
            child: GetBuilder<ScrapWasteIndustryController>(
              init: ScrapWasteIndustryController(),
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
                                                'sourceScreen': 'ScrapWaste'
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
                      if (UserData.userType == 'industry')
                        Padding(
                          padding: getPadding(left: 16, right: 16),
                          child: Column(children: [
                            Text(
                              "What type of scrap do you want us to pick?".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSubheadline,
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                category_button_industry(
                                    "Metal".tr, 'assets/images/metal.png'),
                                SizedBox(
                                  width: getHorizontalSize(16),
                                ),
                                category_button_industry("Plastic".tr,
                                    'assets/images/plastic-wast.jpg'),
                                SizedBox(
                                  width: getHorizontalSize(16),
                                ),
                                category_button_industry(
                                    "Paper".tr, 'assets/images/paper-wast.jpg'),
                                SizedBox(
                                  width: getHorizontalSize(16),
                                ),
                                category_button_industry(
                                    "E-Waste".tr, 'assets/images/e-waste.jpg'),
                              ],
                            ),
                          ]),
                        ),
                      SizedBox(height: 20),
                      if (UserData.userType == 'industry')
                        if (selectedCategory != null)
                          Padding(
                            padding: getPadding(left: 16, right: 16),
                            child: Container(
                              margin: getMargin(bottom: 16),
                              padding: getPadding(
                                  top: 16, bottom: 16, left: 16, right: 16),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.3), // Shadow color
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset:
                                        Offset(0, 2), // Offset of the shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                    getHorizontalSize(10)),
                                color: Colors.white.withOpacity(0.9),
                              ),
                              child: Column(children: [
                                Text(
                                  "Which type of " +
                                      selectedCategory! +
                                      " you deal in?".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtSubheadline,
                                ),
                                SizedBox(height: 16),
                                if (selectedCategory == 'Metal')
                                  Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CategoryButtonIndustryWidget(
                                            text: "Mild Steel".tr,
                                            // icon: ImageConstant.imgScrapIcon,
                                            onTap: (isSelected) {},
                                          ),
                                          SizedBox(
                                            width: getHorizontalSize(16),
                                          ),
                                          CategoryButtonIndustryWidget(
                                            text: "Stainless Steel".tr,
                                            // icon: ImageConstant.imgTextileIcon,
                                            onTap: (isSelected) {},
                                          ),
                                          SizedBox(
                                            width: getHorizontalSize(16),
                                          ),
                                          CategoryButtonIndustryWidget(
                                            text: "Copper".tr,
                                            // icon: ImageConstant.imgChemicalIcon,
                                            onTap: (isSelected) {},
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CategoryButtonIndustryWidget(
                                            text: "Sponge Iron".tr,
                                            // icon: ImageConstant.imgWastewaterIcon,
                                            onTap: (isSelected) {},
                                          ),
                                          SizedBox(
                                            width: getHorizontalSize(16),
                                          ),
                                          CategoryButtonIndustryWidget(
                                            text: "Aluminium".tr,
                                            // icon: ImageConstant.imgCndWasteIcon,
                                            onTap: (isSelected) {},
                                          ),
                                          SizedBox(
                                            width: getHorizontalSize(16),
                                          ),
                                          CategoryButtonIndustryWidget(
                                            text: "Brass".tr,
                                            // icon: ImageConstant.imgCndWasteIcon,
                                            onTap: (isSelected) {},
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                if (selectedCategory == 'Plastic')
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          CategoryButtonIndustryWidget(
                                            text: "PET".tr,
                                            // icon: ImageConstant.imgScrapIcon,
                                            onTap: (isSelected) {},
                                          ),
                                          SizedBox(
                                            width: getHorizontalSize(16),
                                          ),
                                          CategoryButtonIndustryWidget(
                                            text: "HDPE".tr,
                                            // icon: ImageConstant.imgTextileIcon,
                                            onTap: (isSelected) {},
                                          ),
                                          SizedBox(
                                            width: getHorizontalSize(16),
                                          ),
                                          CategoryButtonIndustryWidget(
                                            text: "PP".tr,
                                            // icon: ImageConstant.imgChemicalIcon,
                                            onTap: (isSelected) {},
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CategoryButtonIndustryWidget(
                                            text: "HIPS".tr,
                                            // icon: ImageConstant.imgWastewaterIcon,
                                            onTap: (isSelected) {},
                                          ),
                                          SizedBox(
                                            width: getHorizontalSize(16),
                                          ),
                                          CategoryButtonIndustryWidget(
                                            text: "LDPE".tr,
                                            // icon: ImageConstant.imgCndWasteIcon,
                                            onTap: (isSelected) {},
                                          ),
                                          SizedBox(
                                            width: getHorizontalSize(16),
                                          ),
                                          CategoryButtonIndustryWidget(
                                            text: "PC".tr,
                                            // icon: ImageConstant.imgCndWasteIcon,
                                            onTap: (isSelected) {},
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CategoryButtonIndustryWidget(
                                            text: "PS".tr,
                                            // icon: ImageConstant.imgWastewaterIcon,
                                            onTap: (isSelected) {},
                                          ),
                                          SizedBox(
                                            width: getHorizontalSize(16),
                                          ),
                                          CategoryButtonIndustryWidget(
                                            text: "PVC".tr,
                                            // icon: ImageConstant.imgCndWasteIcon,
                                            onTap: (isSelected) {},
                                          ),
                                          SizedBox(
                                            width: getHorizontalSize(16),
                                          ),
                                          CategoryButtonIndustryWidget(
                                            text: "MLP".tr,
                                            // icon: ImageConstant.imgCndWasteIcon,
                                            onTap: (isSelected) {},
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                if (selectedCategory == 'Paper')
                                  Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CategoryButtonIndustryWidget(
                                            text: "Carton \nBox".tr,
                                            // icon: ImageConstant.imgScrapIcon,
                                            onTap: (isSelected) {},
                                          ),
                                          SizedBox(
                                            width: getHorizontalSize(16),
                                          ),
                                          CategoryButtonIndustryWidget(
                                            text: "Old News Paper".tr,
                                            // icon: ImageConstant.imgTextileIcon,
                                            onTap: (isSelected) {},
                                          ),
                                          SizedBox(
                                            width: getHorizontalSize(16),
                                          ),
                                          CategoryButtonIndustryWidget(
                                            text: "White Waste Paper".tr,
                                            // icon: ImageConstant.imgChemicalIcon,
                                            onTap: (isSelected) {},
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CategoryButtonIndustryWidget(
                                            text: "Tetra \nPack".tr,
                                            // icon: ImageConstant.imgWastewaterIcon,
                                            onTap: (isSelected) {},
                                          ),
                                          SizedBox(
                                            width: getHorizontalSize(16),
                                          ),
                                          CategoryButtonIndustryWidget(
                                            text: "Mixed \nPaper".tr,
                                            // icon: ImageConstant.imgCndWasteIcon,
                                            onTap: (isSelected) {},
                                          ),
                                          SizedBox(
                                            width: getHorizontalSize(16),
                                          ),
                                          CategoryButtonIndustryWidget(
                                            text: "Glass Bottle Waste".tr,
                                            // icon: ImageConstant.imgCndWasteIcon,
                                            onTap: (isSelected) {},
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                if (selectedCategory == 'E-Waste')
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          CategoryButtonIndustryWidget(
                                            text: "Wires".tr,
                                            // icon: ImageConstant.imgScrapIcon,
                                            onTap: (isSelected) {},
                                          ),
                                          SizedBox(
                                            width: getHorizontalSize(16),
                                          ),
                                          CategoryButtonIndustryWidget(
                                            text: "Boards".tr,
                                            // icon: ImageConstant.imgTextileIcon,
                                            onTap: (isSelected) {},
                                          ),
                                          SizedBox(
                                            width: getHorizontalSize(16),
                                          ),
                                          CategoryButtonIndustryWidget(
                                            text: "Chips".tr,
                                            // icon: ImageConstant.imgChemicalIcon,
                                            onTap: (isSelected) {},
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                              ]),
                            ),
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
                                        controller.chargeInfo.value.tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ]));
                      }),
                      Container(
                          margin: getMargin(all: 10),
                          alignment: Alignment.center,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.6),
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
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    ColorConstant.highlighter),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            '( Every Saturday )',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            'Between 9 - 11 AM',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.normal,
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
                                          color: ColorConstant.highlighter
                                              .withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.6),
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
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w400,
                                                color: ColorConstant.whiteA700),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            '( ₹ 10 per km )',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.normal,
                                                color: ColorConstant.gray300),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            'Calculate Charges',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.normal,
                                                color: ColorConstant.gray300),
                                            textAlign: TextAlign.center,
                                          ),
                                        ]))),
                              ])),
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
                    color: selectedCategory == text
                        ? ColorConstant.highlighter
                            .withOpacity(0.9) // Selected border color
                        : Colors.grey, // Shadow color
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 1), // Offset of the shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(getHorizontalSize(10)),
                // Set the background color based on whether this category is selected
                color: Colors.white,
                border: Border.all(
                  color: selectedCategory == text
                      ? ColorConstant.highlighter
                          .withOpacity(0.3) // Selected border color
                      : Colors.transparent, // Transparent color if not selected
                  width: 1.0, // Adjust the border width as needed
                  style: selectedCategory == text
                      ? BorderStyle.solid // Solid border style when selected
                      : BorderStyle.none, // No border style when not selected
                ),
              ),
              height: getSize(90),
              width: getSize(90),
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
