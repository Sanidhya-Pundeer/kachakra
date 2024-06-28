import 'package:courier_delivery/data/mswDriverData.dart';
import 'package:courier_delivery/data/requestData.dart';
import 'package:courier_delivery/presentation/home_container_page/models/home_slider_model.dart';
import 'package:courier_delivery/presentation/marketplace_screen/marketplace_homescreen.dart';
import 'package:courier_delivery/presentation/refer_and_earn_screen/refer_and_screen.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/userData.dart';
import '../../widgets/circular_pie_chart.dart';
import '../home_container_page/widgets/slidermaskgroup_item_widget.dart';
import '../switch_profile_dialog_screen/switch_profile_dialog_screen.dart';
import 'controller/home_container_controller.dart';
import 'models/corier_service_model.dart';
import 'models/recently_shipped_data_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable

class HomeContainerPage extends StatefulWidget {
  HomeContainerPage({Key? key}) : super(key: key);

  @override
  State<HomeContainerPage> createState() => _SendPackageScreenState();
}

class _SendPackageScreenState extends State<HomeContainerPage> {
  HomeContainerController controller = Get.put(HomeContainerController());
  final List<String> profiles = [
    'Household',
    'Industry',
    'Hospital',
    'Hotel',
    'School',
    'Mall-Shop',
    'Mandi',
    'Cattle-Farm'
    // Add more profiles as needed
  ];

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
                  child: PopupMenuButton<String>(
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'my_profile',
                        child: Row(children: [
                          CustomImageView(
                            svgPath: ImageConstant.imgProfileUnselected,
                            height: 15,
                            width: 15,
                          ),
                          SizedBox(width: 10),
                          Text('My Profile'),
                        ]),
                      ),
                      PopupMenuItem<String>(
                        value: 'switch_profile',
                        child: Row(children: [
                          CustomImageView(
                            svgPath: ImageConstant.imgRefresh,
                            height: 15,
                            width: 15,
                          ),
                          SizedBox(width: 10),
                          Text('Switch Account'),
                        ]),
                      ),
                    ],
                    onSelected: (String value) {
                      if (value == 'switch_profile') {
                        // Show bottom sheet for switching profile
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled:
                              true, // Set to true to allow scrolling
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Select Account',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          NeverScrollableScrollPhysics(), // Disable GridView scrolling
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 3.0,
                                        mainAxisSpacing: 3.0,
                                      ),
                                      itemCount: profiles.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            // Navigator.pop(context, profiles[index]);
                                            UserData.userType =
                                                profiles[index].toLowerCase();
                                            // Navigate to the same screen to refresh
                                            setState(() {});
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            padding: EdgeInsets.all(4.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: UserData
                                                                        .userType ==
                                                                    profiles[
                                                                            index]
                                                                        .toLowerCase()
                                                                ? ColorConstant
                                                                    .highlighter
                                                                : Colors.black
                                                                    .withOpacity(
                                                                        0.3), // Shadow color
                                                            spreadRadius: 5,
                                                            blurRadius: 5,
                                                            offset: Offset(0,
                                                                1), // Offset of the shadow
                                                          ),
                                                        ],
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                getHorizontalSize(
                                                                    60)),
                                                        color: ColorConstant
                                                            .gray50),
                                                    child: CircleAvatar(
                                                      backgroundImage: AssetImage(
                                                          'assets/images/${profiles[index].toLowerCase()}.png'),
                                                      radius: 30,
                                                    )),
                                                SizedBox(height: 4.0),
                                                Text(
                                                  profiles[index],
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 16.0),
                                    Text(
                                      'Need another account type? Add here!',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (value == 'my_profile') {
                        // Handle navigating to my profile
                        Get.toNamed(AppRoutes.profileDetailsScreen);
                      }
                    },
                    child: Container(
                      height: getSize(48),
                      width: getSize(48),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(getHorizontalSize(55)),
                        color:
                            Colors.white, // Changing background color to white
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: getPadding(all: 0),
                        child: CustomImageView(
                          height: getSize(26),
                          width: getSize(26),
                          imagePath: ImageConstant.imgEllipse240,
                          radius: BorderRadius.circular(getHorizontalSize(55)),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          if (UserData.userType == 'household')
            SizedBox(
              height: getVerticalSize(10),
            ),
          Expanded(
              child: ListView(
            children: [
              if (UserData.userType == 'household')
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
                        HomeSlider model = controller.sliderData[index];
                        return SlidermaskgroupItemWidget(model);
                      },
                    );
                  },
                ),
              if (UserData.userType == 'household')
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
                  RequestData.requestStatus != "Completed" &&
                  RequestData.requestStatus != "Cancelled")
                Padding(
                  padding: getPadding(left: 16, right: 16, top: 16),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.trackingDetailsScreen);
                    },
                    child: Container(
                      padding: getPadding(left: 10, right: 10),
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
                          Text("Active \nRequest",
                              maxLines: null,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFProTextBoldWhite15),
                          Container(
                            padding: getPadding(top: 15, bottom: 15),
                            height:
                                80, // Set the height to fill the entire space vertically
                            child: VerticalDivider(
                              color:
                                  Colors.grey, // Customize the color as needed
                              thickness:
                                  1.0, // Customize the thickness as needed
                            ),
                          ),
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
              if (UserData.userType != 'household')
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: getPadding(left: 16, top: 21),
                        child: Text("What can we help you with today!".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextBold20))),
              if (UserData.userType == 'household')
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
              if (UserData.userType == 'industry')
                Padding(
                  padding: getPadding(left: 16, right: 16),
                  child: Row(
                    children: [
                      category_button_industry(() {
                        Get.toNamed(AppRoutes.scrapWasteIndustryScreen);
                      }, "Scrap Waste".tr, ImageConstant.imgScrapIcon),
                      SizedBox(
                        width: getHorizontalSize(16),
                      ),
                      category_button_industry(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MarketPlaceScreen(),
                            ));
                        ;
                      }, "Textile Waste".tr, ImageConstant.imgTextileIcon),
                      SizedBox(
                        width: getHorizontalSize(16),
                      ),
                      category_button_industry(() {
                        Get.toNamed(AppRoutes.chemicalWasteScreen);
                      }, "Chemical Waste".tr, ImageConstant.imgChemicalIcon),
                      SizedBox(
                        width: getHorizontalSize(16),
                      ),
                      category_button_industry(() {
                        Get.toNamed(
                          AppRoutes.sendPackageScreen,
                          arguments: {'previous_screen': 'wastewater_industry'},
                        );
                      }, "Waste water".tr, ImageConstant.imgWastewaterIcon),
                      SizedBox(
                        width: getHorizontalSize(16),
                      ),
                      category_button_industry(() {
                        Get.toNamed(AppRoutes.sendPackageScreen);
                      }, "C&D \nWaste".tr, ImageConstant.imgCndWasteIcon),
                    ],
                  ),
                ),
              if (UserData.userType == 'industry')
                SizedBox(
                  height: getVerticalSize(16),
                ),
              if (UserData.userType == 'industry')
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
                                if (UserData.userType == 'industry')
                                  Text(
                                    "Net Collected Waste = 100 Ton",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                if (UserData.userType == 'household')
                                  Text(
                                    "Weekly Bio Waste = 15 kg",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                SizedBox(height: 12),
                                if (UserData.userType == 'household')
                                  Text(
                                    "Biogas Generated = 50",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                if (UserData.userType == 'industry')
                                  Text(
                                    "CO₂ reduced = 50 Kg",
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
              if (UserData.userType == 'industry')
                SizedBox(
                  height: getVerticalSize(16),
                ),
              Padding(
                padding: getPadding(left: 16, right: 16),
                child: Row(
                  children: [
                    if (UserData.userType == 'household')
                      category_button(() {
                        Get.toNamed(AppRoutes.sendPackageScreen);
                      }, "lbl_send_package".tr,
                          ImageConstant.imgSendPackegeIcon),
                    if (UserData.userType == 'household')
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReferAndEarn(),
                          ));
                    }, "Refer & Earn", ImageConstant.imgSendPackegeIcon),
                    if (UserData.userType == 'industry')
                      SizedBox(
                        width: getHorizontalSize(8),
                      ),
                    if (UserData.userType == 'industry')
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
              if (UserData.userType == 'household')
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
                    }, "Your Bins".tr, ImageConstant.imgReplaceBinIcon),
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
                      if (UserData.userType == 'industry')
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Handle the onTap event here
                              onTapPlumbing();
                            },
                            child: Container(
                              height: 100.0,
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Choked Drain?',
                                      style: AppStyle.txtSFProTextBold15,
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(5),
                                    ),
                                    Text(
                                      'CALL NOW',
                                      style: AppStyle.txtSFProTextBold15,
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      // Second Column
                      if (UserData.userType == 'household')
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
                                    image:
                                        AssetImage('assets/images/kachra.png'),
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
              if (UserData.userType == 'household')
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
              if (UserData.userType == 'household')
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
          )),
          // if (UserData.userType == 'industry')
          //   Align(
          //       alignment: Alignment.centerLeft,
          //       child: Padding(
          //           padding: getPadding(left: 16, top: 21),
          //           child: Text("Industrial Waste ".tr,
          //               overflow: TextOverflow.ellipsis,
          //               textAlign: TextAlign.left,
          //               style: AppStyle.txtSFProTextBold20))),
          // if (UserData.userType == 'shop_mall')
          //   Align(
          //       alignment: Alignment.centerLeft,
          //       child: Padding(
          //           padding: getPadding(left: 16, top: 21),
          //           child: Text("Shops n Malls ".tr,
          //               overflow: TextOverflow.ellipsis,
          //               textAlign: TextAlign.left,
          //               style: AppStyle.txtSFProTextBold20))),
          // if (UserData.userType == 'hospital')
          //   Align(
          //       alignment: Alignment.centerLeft,
          //       child: Padding(
          //           padding: getPadding(left: 16, top: 21),
          //           child: Text("Hospitals ".tr,
          //               overflow: TextOverflow.ellipsis,
          //               textAlign: TextAlign.left,
          //               style: AppStyle.txtSFProTextBold20))),
          // if (UserData.userType == 'hotels')
          //   Align(
          //       alignment: Alignment.centerLeft,
          //       child: Padding(
          //           padding: getPadding(left: 16, top: 21),
          //           child: Text("Hotels ".tr,
          //               overflow: TextOverflow.ellipsis,
          //               textAlign: TextAlign.left,
          //               style: AppStyle.txtSFProTextBold20))),
          // if (UserData.userType == 'other')
          //   Align(
          //       alignment: Alignment.centerLeft,
          //       child: Padding(
          //           padding: getPadding(left: 16, top: 21),
          //           child: Text("Other Businesses ".tr,
          //               overflow: TextOverflow.ellipsis,
          //               textAlign: TextAlign.left,
          //               style: AppStyle.txtSFProTextBold20))),
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

  Widget category_button_industry(function, text, icon) {
    return Expanded(
      child: GestureDetector(
        onTap: function,
        child: Column(
          children: [
            Container(
              padding: getPadding(all: 5),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstant.highlighter
                          .withOpacity(0.6), // Shadow color
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2), // Offset of the shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(getHorizontalSize(60)),
                  color: ColorConstant.gray50),
              height: getSize(70),
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
            Text(text,
                maxLines: null,
                textAlign: TextAlign.center,
                style: AppStyle.txtSFProTextMedium14)
          ],
        ),
      ),
    );
  }
}
