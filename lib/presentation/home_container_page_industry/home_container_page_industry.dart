import 'package:courier_delivery/data/mswDriverData.dart';
import 'package:courier_delivery/data/requestData.dart';
import 'package:courier_delivery/presentation/home_container_page_industry/controller/home_container_controller_industry.dart';
import 'package:courier_delivery/presentation/home_container_page_industry/models/home_slider_model.dart';
import 'package:courier_delivery/presentation/home_container_page_industry/widgets/slidermaskgroup_item_widget.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/userData.dart';
import '../../widgets/circular_pie_chart.dart';

import 'models/recently_shipped_data_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class HomeContainerPageIndustry extends StatelessWidget {
  HomeContainerPageIndustry({Key? key}) : super(key: key);

  HomeContainerIndustryController controller =
      Get.put(HomeContainerIndustryController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.white,
      child: Column(
        children: [
          Padding(
            padding: getPadding(top: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imglogowhite,
                      height: 30,
                      width: 30,
                      margin: getMargin(left: 16),
                    ),
                    AppbarImage(
                        height: getSize(20),
                        width: getSize(20),
                        svgPath: ImageConstant.imgSignal,
                        margin: getMargin(left: 8, top: 18, bottom: 18)),
                    SizedBox(
                      width: getHorizontalSize(12),
                    ),
                    Container(
                      width: 200, // Set your desired width
                      child: Text(
                        UserData.userAddress.tr,
                        style: AppStyle.txtSFProDisplayBold20,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: getPadding(right: 16),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.profileDetailsScreen);
                    },
                    child: Container(
                      height: getSize(48),
                      width: getSize(48),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(getHorizontalSize(55)),
                          color: ColorConstant.deepPurple600),
                      child: Padding(
                        padding: getPadding(all: 0),
                        child: CustomImageView(
                          height: getSize(26),
                          width: getSize(26),
                          imagePath: ImageConstant.imgEllipse240,
                          radius: BorderRadius.circular(
                            getHorizontalSize(
                              55,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: getVerticalSize(10),
          ),
          Expanded(
              child: ListView(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate the desired width as 80% of the available width
                  double desiredWidth = constraints.maxWidth * 0.9;

                  return CarouselSlider.builder(
                    options: CarouselOptions(
                      aspectRatio: desiredWidth /
                          (desiredWidth * 0.36), // Maintain the aspect ratio
                      initialPage: 0,
                      autoPlay: true,
                      viewportFraction: 0.8,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        controller.sliderIndex.value = index;
                      },
                    ),
                    itemCount: controller.sliderData.length,
                    itemBuilder: (context, index, realIndex) {
                      HomeSliderIndustry model = controller.sliderData[index];
                      return SlidermaskgroupItemWidget(model);
                    },
                  );
                },
              ),
              Obx(
                () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        List.generate(controller.sliderData.length, (index) {
                      return AnimatedContainer(
                        margin: getMargin(left: 4, top: 16, right: 4),
                        duration: const Duration(milliseconds: 300),
                        height: getVerticalSize(6),
                        width: getHorizontalSize(
                            index == controller.sliderIndex.value ? 16 : 6),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(getHorizontalSize(12)),
                            color: (index == controller.sliderIndex.value)
                                ? ColorConstant.black900
                                : ColorConstant.black900.withOpacity(0.10)),
                      );
                    })),
              ),
              if (RequestData.requestStatus != "" &&
                  RequestData.requestStatus != "Completed")
                Padding(
                  padding: getPadding(left: 16, right: 16, top: 16),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.trackingDetailsScreen);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.3), // Shadow color
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: Offset(0, 2), // Offset of the shadow
                            ),
                          ],
                          borderRadius:
                              BorderRadius.circular(getHorizontalSize(16)),
                          color: ColorConstant.gray50),
                      height: getSize(70),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Last \nRequest",
                              maxLines: null,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextBoldWhite15),
                          Text(" |\n | ",
                              maxLines: null,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextMedium14),
                          SizedBox(
                            width: getHorizontalSize(8),
                          ),
                          Text(
                              RequestData.type_of_waste +
                                  " " +
                                  RequestData.requestType +
                                  "\n" +
                                  RequestData.weight,
                              maxLines: null,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextMedium14),
                          if (RequestData.requestStatus == "Pending")
                            Container(
                              margin: getMargin(
                                  left: 50, top: 0, right: 0, bottom: 0),
                              child: CustomImageView(
                                imagePath: ImageConstant.imgbinloading,
                                height: getSize(50),
                                width: getSize(50),
                              ),
                            ),
                          if (RequestData.requestStatus == "In-Progress")
                            Container(
                              margin: getMargin(
                                  left: 5, top: 15, right: 15, bottom: 15),
                              child: CustomImageView(
                                svgPath: ImageConstant.imgTickIcon,
                                height: getSize(30),
                                width: getSize(30),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: getPadding(left: 16, top: 21),
                      child: Text("lbl_categories".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtSFProTextBold20))),
              SizedBox(
                height: getVerticalSize(16),
              ),
              Padding(
                padding: getPadding(left: 16, right: 16),
                child: Row(
                  children: [
                    category_button(() {
                      Get.toNamed(AppRoutes.sendPackageScreen);
                    }, "lbl_send_package".tr, ImageConstant.imgSendPackegeIcon),
                    SizedBox(
                      width: getHorizontalSize(8),
                    ),
                    category_button(() {
                      Get.toNamed(AppRoutes.submitComplaintScreen);
                    }, "Any \nComplaints?".tr,
                        ImageConstant.imgShipmentPriceIcon),
                    SizedBox(
                      width: getHorizontalSize(8),
                    ),
                    category_button(() {
                      Get.toNamed(AppRoutes.orderTrackingScreen);
                    }, "Request \nStatus".tr,
                        ImageConstant.imgOrderTracingIcon),
                  ],
                ),
              ),
              SizedBox(
                width: getHorizontalSize(16),
              ),
              GestureDetector(
                onTap: () {
                  // Handle the onTap event here
                  onTapPlumbing();
                },
                child: Padding(
                  padding: getPadding(top: 16, left: 16, right: 16),
                  child: Container(
                    height: 120.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/plumbing05.jpg'), // Replace with your image path
                        fit: BoxFit.cover,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          ColorConstant.black900,
                          ColorConstant.gray8004c
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Choked Drain?',
                              style: AppStyle.txtSFProTextBoldWhite20),
                          SizedBox(
                            height: getVerticalSize(5),
                          ),
                          Text('CALL NOW',
                              style: AppStyle.txtSFProTextBoldWhiteUnderline),
                        ]),
                  ),
                ),
              ),
              Padding(
                padding: getPadding(top: 16, left: 16, right: 16),
                child: Row(
                  children: [
                    category_button(() {
                      Get.toNamed(AppRoutes.replaceBinScreen);
                    }, "lbl_bin_change".tr, ImageConstant.imgReplaceBinIcon),
                    SizedBox(
                      width: getHorizontalSize(8),
                    ),
                    category_button(() {
                      Get.toNamed(AppRoutes.requestPeBagScreen);
                    }, "lbl_pe_bag".tr, ImageConstant.imgPeBagIcon),
                    SizedBox(
                      width: getHorizontalSize(8),
                    ),
                    category_button(() {
                      Get.toNamed(AppRoutes.buyStickerScreen);
                    }, "lbl_new_sticker".tr, ImageConstant.imgBuyStickersIcon),
                  ],
                ),
              ),
              Padding(
                  padding: getPadding(left: 16, top: 19, right: 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Collection Vehicle".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextBold20),
                        GestureDetector(
                            onTap: () {
                              onTapTxtViewall();
                            },
                            child: Padding(
                                padding: getPadding(top: 3, bottom: 3),
                                child: Text("Location".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtSFProTextRegular14)))
                      ])),
              SizedBox(
                height: getVerticalSize(8),
              ),
              Padding(
                padding: getPadding(left: 16, right: 16),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3), // Shadow color
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 2), // Offset of the shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(getHorizontalSize(8)),
                      color: ColorConstant.gray50),
                  // Set padding
                  child: Row(
                    children: [
                      // Left Column with three rows of text
                      Expanded(
                          child: Padding(
                        padding: getPadding(left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              MswDriverData.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 1),
                            Text(
                              "Contact : " + MswDriverData.phoneNumber,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 1),
                            Text(
                              "Vehicle No. - " + MswDriverData.vehicleNumber,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      )),
                      // Right Column with an image
                      GestureDetector(
                        onTap: () {
                          // Handle the onTap event here
                          onTapTxtViewall();
                        },
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: getPadding(right: 16),
                              child: CustomImageView(
                                svgPath: ImageConstant.imgtruck,
                                height: getSize(100),
                                width: getSize(100),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: getHorizontalSize(16),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  child: Row(
                    children: [
                      // First Column
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Action for the first column tap
                            onTapViewSafaiKaramchari();
                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/safai01.jpg'),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.centerLeft),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Need \nCleaner Street ?',
                                    style: AppStyle.txtSFProTextBold15,
                                  ),
                                ]),
                          ),
                        ),
                      ),

                      // Spacer between columns
                      SizedBox(width: 16),

                      // Second Column
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Action for the second column tap
                            onTapViewKabadhiwala();
                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/kachra.png'),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Call your \nKachra Seth!',
                                    style: AppStyle.txtSFProTextBold15,
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Handle the onTap event here
                  onTapViewScore();
                },
                child: Padding(
                  padding: getPadding(left: 16, right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/viewscore.jpg'), // Replace with your image path
                        fit: BoxFit.cover,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          ColorConstant.black900,
                          ColorConstant.gray8004c
                        ], // Specify the gradient colors
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(16), // Set padding
                    child: Row(
                      children: [
                        // Left Column with three rows of text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Weekly Bio Waste = 15 kg",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                "Biogas Generated = 50",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 1),
                              Text(
                                "Rebate Points = 1800",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Right Column with an image
                        Align(
                          alignment: Alignment.topLeft,
                          child: CircularPieChart(
                            percentage: 0.9, // Set the percentage to 90%
                            size: getSize(100), // Adjust the size as needed
                            totalScore:
                                900, // Provide the total score to display inside the pie chart
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getVerticalSize(16),
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  child: CustomImageView(
                    imagePath: ImageConstant.imgSubBanner,
                  ),
                ),
              ),
              SizedBox(
                height: getVerticalSize(16),
              ),
              Padding(
                padding: getPadding(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("msg_recently_shipped".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtSFProTextBold20),
                    GestureDetector(
                        onTap: () {
                          onTapTxtViewallone();
                        },
                        child: Padding(
                            padding: getPadding(top: 1, bottom: 5),
                            child: Text("lbl_view_all".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFProTextRegular14)))
                  ],
                ),
              ),
              SizedBox(
                height: getVerticalSize(16),
              ),
              SizedBox(
                height: getSize(194),
                child: ListView.builder(
                  padding: getPadding(left: 8, right: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.recentlyShipped.length < 2
                      ? controller.recentlyShipped.length
                      : 2,
                  itemBuilder: (context, index) {
                    RecentlyShipped data = controller.recentlyShipped[index];
                    return Padding(
                      padding: getPadding(left: 8, right: 8),
                      child: Container(
                        width: getSize(308),
                        decoration: BoxDecoration(
                            color: ColorConstant.gray50,
                            borderRadius:
                                BorderRadius.circular(getHorizontalSize(8))),
                        child: Padding(
                          padding: getPadding(top: 16, left: 16, right: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomIconButton(
                                        height: 42,
                                        width: 42,
                                        shape: IconButtonShape.CircleBorder20,
                                        child: CustomImageView(
                                            svgPath: ImageConstant
                                                .imgArrowdownDeepPurple600)),
                                    SizedBox(
                                      width: getHorizontalSize(8),
                                    ),
                                    Container(
                                        margin: getMargin(left: 8, top: 3),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder8),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("lbl_shipped_to".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: AppStyle
                                                      .txtSubheadlineGray600),
                                              Padding(
                                                  padding: getPadding(top: 4),
                                                  child: Text(data.name!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .txtSubheadline))
                                            ]))
                                  ]),
                              SizedBox(
                                height: getVerticalSize(15),
                              ),
                              Text("Request id : ${data.orderID}",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtSFProTextRegular14),
                              Padding(
                                  padding: getPadding(top: 4),
                                  child: Text("Request date : ${data.date}",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtFootnote)),
                              SizedBox(
                                height: getVerticalSize(15),
                              ),
                              CustomButton(
                                onTap: () {
                                  Get.toNamed(AppRoutes.trackingDetailsScreen);
                                },
                                height: getSize(40),
                                text: "lbl_track_package".tr,
                                fontStyle:
                                    ButtonFontStyle.SFProTextBold15WhiteA700,
                                padding: ButtonPadding.PaddingT0,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: getVerticalSize(20),
              ),
            ],
          ))
        ],
      ),
    );
  }

  onTapTxtViewall() async {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    try {
      var position = await Geolocator.getCurrentPosition();
      UserData.currentPosition = position;
      // Navigate to the redeem stations map screen
      await Get.toNamed(
        AppRoutes.liveTrackingOneScreen,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch location: $e');
    } finally {
      // Close the CircularProgressIndicator() when returning to this screen
      Get.back();
    }
  }

  onTapTxtViewallone() {
    Get.toNamed(
      AppRoutes.recentlyShippedScreen,
    );
  }

  onTapViewScore() {
    Get.toNamed(
      AppRoutes.viewScoreScreen,
    );
  }

  onTapViewKabadhiwala() {
    Get.toNamed(
      AppRoutes.quoteKabadhiwalaScreen,
    );
  }

  onTapViewSafaiKaramchari() {
    Get.toNamed(
      AppRoutes.safaiKaramchariScreen,
    );
  }

  onTapPlumbing() {
    Get.toNamed(
      AppRoutes.plumbingScreen,
    );
  }

  Widget category_button(function, text, icon) {
    return Expanded(
      child: GestureDetector(
        onTap: function,
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2), // Offset of the shadow
                ),
              ],
              borderRadius: BorderRadius.circular(getHorizontalSize(8)),
              color: ColorConstant.gray50),
          height: getSize(70),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                svgPath: icon,
                height: getSize(24),
                width: getSize(24),
              ),
              SizedBox(
                width: getHorizontalSize(8),
              ),
              Text(text,
                  maxLines: null,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtSFProTextMedium14)
            ],
          ),
        ),
      ),
    );
  }
}
