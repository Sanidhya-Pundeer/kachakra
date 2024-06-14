import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:courier_delivery/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/userData.dart';
import 'controller/quote_kabadhiwala_controller.dart';

class QuoteKabadhiwalaScreen extends StatefulWidget {
  QuoteKabadhiwalaScreen({Key? key}) : super(key: key);

  @override
  State<QuoteKabadhiwalaScreen> createState() => _SendPackageScreenState();
}

class _SendPackageScreenState extends State<QuoteKabadhiwalaScreen> {
  QuoteKabadhiwalaController sendPackageController =
      Get.put(QuoteKabadhiwalaController());

  String? selectedCategory;
  List<Uint8List> _selectedImages = [];

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
                    title: AppbarSubtitle1(text: "Scrap Collection".tr),
                    styleType: Style.bgFillWhiteA700),
                body: GetBuilder<QuoteKabadhiwalaController>(
                  init: QuoteKabadhiwalaController(),
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
                                      "Metal".tr, ImageConstant.imgScrapIcon),
                                  SizedBox(
                                    width: getHorizontalSize(16),
                                  ),
                                  category_button_industry(
                                      "Plastic".tr, ImageConstant.imgTextileIcon),
                                  SizedBox(
                                    width: getHorizontalSize(16),
                                  ),
                                  category_button_industry(
                                      "Paper".tr, ImageConstant.imgChemicalIcon),
                                  SizedBox(
                                    width: getHorizontalSize(16),
                                  ),
                                  category_button_industry(
                                      "E-Waste".tr, ImageConstant.imgWastewaterIcon),

                                ],
                              ),
                              SizedBox(
                                height: getHorizontalSize(16),
                              ),

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

                              SizedBox(
                                height: getHorizontalSize(16),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  var status = await Permission.photos.request();
                                  if (status.isGranted) {
                                    List<Uint8List> selectedPhotos =
                                    await _pickMultiplePhotos();
                                    setState(() {
                                      _selectedImages.addAll(selectedPhotos);
                                    });
                                  } else {
                                    print("Permission denied");
                                  }
                                },
                                child: Text("Upload Photos"),
                              ),
                              SizedBox(height: getVerticalSize(16)),
                              if (_selectedImages.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Uploaded Photos:"),
                                    SizedBox(height: 8),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        for (Uint8List imageBytes in _selectedImages)
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10), // Adjust the horizontal spacing
                                            child: Image.memory(
                                              imageBytes,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                              SizedBox(height: 10),
                              Text(
                                "Note : On every successful request you get 10% off on your next request.",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "After request generation, Our kachra seth will be at your home to collect the scrap. Please verify the weight collected and price calculation carefully.",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                ),
                              ),
                            ]),
                          ),

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
      AppRoutes.orderSuccessScreen,
    );
  }

  onTapArrowleft4() {
    Get.back();
  }

  Widget category_button(function, text) {
    return Expanded(
      child: GestureDetector(
        onTap: function,
        child: Container(
          height: getSize(70),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: getHorizontalSize(8),
              ),
              Text(text,
                  maxLines: null,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtSFProDisplaySemibold18)
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextfield({
    required Function(String) onChanged,
  }) {
    return Expanded(
        child: IntrinsicWidth(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(getHorizontalSize(8)),
              color: ColorConstant.whiteA700,
            ),
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: "Enter value",
                filled: true,
                fillColor: ColorConstant.whiteA700,
                contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(getHorizontalSize(8)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(getHorizontalSize(8)),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(getHorizontalSize(8)),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(getHorizontalSize(8)),
                  borderSide: BorderSide.none,
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(getHorizontalSize(8)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      );
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
                        ? ColorConstant.highlighter.withOpacity(0.9) // Selected border color
                        : Colors.grey, // Shadow color
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 1), // Offset of the shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(getHorizontalSize(60)),
                // Set the background color based on whether this category is selected
                color: Colors.white,
                border: Border.all(
                  color: selectedCategory == text
                      ? ColorConstant.highlighter.withOpacity(0.3) // Selected border color
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

  Future<List<Uint8List>> _pickMultiplePhotos() async {
    List<Uint8List> result = [];

    // try {
    //   List<Asset> images = await MultiImagePicker.pickImages(
    //     maxImages: 5,
    //     enableCamera: true,
    //     selectedAssets: [],
    //     cupertinoOptions: CupertinoOptions(
    //       selectionFillColor: "#000000",
    //       selectionTextColor: "#000000",
    //       selectionCharacter: '✓',
    //     ),
    //     materialOptions: MaterialOptions(
    //       actionBarColor: "#000000",
    //       actionBarTitle: "Select Images",
    //       allViewTitle: "All Photos",
    //       useDetailsView: false,
    //       selectCircleStrokeColor: "#000000",
    //     ),
    //   );
    //
    //   result = await controller.processImages(images);
    // }
    // catch (e) {
    //   print("Error picking images: $e");
    // }

    return result;
  }


}
