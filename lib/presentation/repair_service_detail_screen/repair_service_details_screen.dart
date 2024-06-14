import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'controller/repair_service_details_controller.dart';
import 'package:maps_launcher/maps_launcher.dart';

class RepairServiceDetailsScreen extends StatefulWidget {
  @override
  State<RepairServiceDetailsScreen> createState() =>
      _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<RepairServiceDetailsScreen> {
  RepairServiceDetailsController controlelr =
      Get.put(RepairServiceDetailsController());

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
    Map<String, dynamic> arguments = Get.arguments;

    // Now you can access the data passed from CalculatePriceScreen
    String subtitle = arguments['subtitle'];
    String discription = arguments['discription'];
    String charges = arguments['charges'];
    String rating = arguments['rating'];
    double longitude = arguments['long'];
    double latitude = arguments['lat'];
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
                          onTapArrowleft22();
                        }),
                    centerTitle: true,
                    title: AppbarSubtitle1(text: "Repair".tr),
                    actions: [],
                    styleType: Style.bgFillWhiteA700),
                body: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Container(
                        width: double.maxFinite,
                        padding:
                            getPadding(left: 0, top: 0, right: 0, bottom: 0),
                        child: Column(children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                  height: getSize(310),
                                  width: double.infinity,
                                  child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        CustomImageView(
                                            imagePath:
                                                ImageConstant.imgRepairDetail,
                                            height: getSize(310),
                                            width: double.infinity,
                                            fit: BoxFit.fill,
                                            alignment: Alignment.topCenter),
                                      ]))),
                          SizedBox(
                            height: getVerticalSize(0),
                          ),
                          Container(
                              child: Column(children: [
                            SizedBox(
                              height: getVerticalSize(20),
                            ),
                            profileDetail(
                                ImageConstant.imgUSerIcon, "Name", subtitle),
                            SizedBox(
                              height: getVerticalSize(20),
                            ),
                            Divider(
                                height: getVerticalSize(1),
                                thickness: getVerticalSize(1),
                                color: ColorConstant.gray200),
                            SizedBox(
                              height: getVerticalSize(20),
                            ),
                            profileDetail(
                                ImageConstant.imgMailIcon, "Deals In", rating),
                            SizedBox(
                              height: getVerticalSize(20),
                            ),
                            Divider(
                                height: getVerticalSize(1),
                                thickness: getVerticalSize(1),
                                color: ColorConstant.gray200),
                            SizedBox(
                              height: getVerticalSize(20),
                            ),
                            profileDetail(ImageConstant.imgCallIcon,
                                "Phone Number", charges),
                            SizedBox(
                              height: getVerticalSize(20),
                            ),
                            Divider(
                                height: getVerticalSize(1),
                                thickness: getVerticalSize(1),
                                color: ColorConstant.gray200),
                            SizedBox(
                              height: getVerticalSize(20),
                            ),
                            profileDetail(ImageConstant.imgCallIcon, "Address",
                                discription),
                            SizedBox(
                              height: getVerticalSize(20),
                            ),
                            Divider(
                                height: getVerticalSize(1),
                                thickness: getVerticalSize(1),
                                color: ColorConstant.gray200),
                            SizedBox(
                              height: getVerticalSize(20),
                            ),
                            ElevatedButton(
                                onPressed: launchGoogleMaps,
                                child: Text("Get Directions ->".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtOutfitRegular14Green)),
                          ]))
                        ]))))));
  }

  onTapArrowleft22() {
    Get.back();
  }

  Widget profileDetail(icon, title, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: getHorizontalSize(10),
        ),
        CustomImageView(
          svgPath: icon,
          height: getSize(
            24,
          ),
          width: getSize(
            24,
          ),
          margin: getMargin(
            bottom: 30,
          ),
        ),
        Expanded(
          child: Padding(
            padding: getPadding(
              left: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtBodyGray600,
                ),
                Container(
                  width: 0.9 * MediaQuery.of(context).size.width,
                  child: Text(
                    value,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtBody,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void launchGoogleMaps() {
    Map<String, dynamic> arguments = Get.arguments;
    double latitude = arguments['lat'];
    double longitude = arguments['long'];

    MapsLauncher.launchCoordinates(
      latitude,
      longitude,
      arguments['subtitle'], // Replace with a suitable title for the marker
    );
  }
}
