import 'package:courier_delivery/presentation/view_score_screen/widgets/view_score_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/pointsData.dart';
import '../../data/userData.dart';
import 'controller/view_score_controller.dart';

class ViewScoreScreen extends StatefulWidget {
  @override
  State<ViewScoreScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ViewScoreScreen> {
  ViewScoreController controller = Get.put(ViewScoreController());

  String selectedItem = '';
  String selectedFuel = '';

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
                onTapArrowLeft();
              },
            ),
            centerTitle: true,
            title: AppbarSubtitle1(text: "Your Score".tr),
            styleType: Style.bgFillWhiteA700,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   alignment: Alignment.bottomCenter,
                      //   image: AssetImage('assets/images/biofuel.jpg'),
                      //   fit: BoxFit.fitWidth,
                      // ),
                    ),
                    width: double.maxFinite,
                    padding: getPadding(left: 16, top: 5, right: 16, bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        WasteExanpleList(selectedItem: selectedItem),
                        SizedBox(height: getVerticalSize(0)),
                        Container(
                          padding: getPadding(left: 10),
                          width: double.maxFinite,
                          child: Text(
                            'Please select:',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorConstant.black900,
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: getVerticalSize(10)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedFuel = "Petrol";
                                  PointsData.selectedFuel = selectedFuel;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: selectedFuel == "Petrol"
                                      ? ColorConstant.highlighter.withOpacity(0.3)
                                      : null,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: profileDetail(ImageConstant.imgpetrol, "Petrol", "92/ltr", "89/ltr"),
                              ),
                            ),
                            SizedBox(height: getVerticalSize(0)),
                            Divider(
                              height: getVerticalSize(1),
                              thickness: getVerticalSize(1),
                              color: ColorConstant.gray200,
                            ),
                            SizedBox(height: getVerticalSize(0)),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedFuel = "Diesel";
                                  PointsData.selectedFuel = selectedFuel;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: selectedFuel == "Diesel"
                                      ? ColorConstant.highlighter.withOpacity(0.3)
                                      : null,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: profileDetail(ImageConstant.imgdiesel, "Diesel", "59/l", "51/l"),
                              ),
                            ),
                            SizedBox(height: getVerticalSize(0)),
                            Divider(
                              height: getVerticalSize(1),
                              thickness: getVerticalSize(1),
                              color: ColorConstant.gray200,
                            ),
                            SizedBox(height: getVerticalSize(0)),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedFuel = "LPG";
                                  PointsData.selectedFuel = selectedFuel;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: selectedFuel == "LPG"
                                      ? ColorConstant.highlighter.withOpacity(0.3)
                                      : null,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: profileDetail(ImageConstant.imggas, "LPG", "1100/cyl", "1050/cyl"),
                              ),
                            ),
                            SizedBox(height: getVerticalSize(0)),
                            Divider(
                              height: getVerticalSize(1),
                              thickness: getVerticalSize(1),
                              color: ColorConstant.gray200,
                            ),
                            SizedBox(height: getVerticalSize(0)),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedFuel = "CNG";
                                  PointsData.selectedFuel = selectedFuel;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: selectedFuel == "CNG"
                                      ? ColorConstant.highlighter.withOpacity(0.3)
                                      : null,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: profileDetail(ImageConstant.imggas, "CNG", "50/kg", "52/kg"),
                              ),
                            ),
                            SizedBox(height: getVerticalSize(15)),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // Handle onTap event here
                              if (selectedFuel != "") {
                                viewStations();
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Please select any type from above",
                                  toastLength: Toast.LENGTH_SHORT, // Duration for which the toast should be visible
                                  gravity: ToastGravity.BOTTOM, // Position where the toast should appear
                                  timeInSecForIosWeb: 1, // Time duration in seconds for the toast to be visible on iOS/web platforms
                                  backgroundColor: Colors.black54, // Background color of the toast
                                  textColor: Colors.white, // Text color of the toast message
                                  fontSize: 16.0, // Font size of the toast message
                                );
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.maxFinite,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.9),
                                  spreadRadius: 3,
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(ImageConstant.imgNearStationsBg),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20.0), // Match the border radius of the outer container
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Nearest ' + selectedFuel + ' Location...',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      CustomImageView(
                                        width: 30,
                                        height: 30,
                                        imagePath: ImageConstant.imgMapMarker,
                                        margin: getMargin(top: 15),
                                      ),
                                      // Text(
                                      //   'Click Here!',
                                      //   textAlign: TextAlign.center,
                                      //   style: TextStyle(
                                      //     color: Colors.black,
                                      //     fontSize: 15,
                                      //     fontStyle: FontStyle.normal,
                                      //     fontWeight: FontWeight.w500,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        Text(
                          "Note : Conversion rate is based on today's market price of above commodities. Only single option can be selected against rebate points. ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (selectedFuel != "") {
                    Get.toNamed(
                      AppRoutes.redeemPointsScreen,
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: "Please select any type from above",
                      toastLength: Toast.LENGTH_SHORT, // Duration for which the toast should be visible
                      gravity: ToastGravity.BOTTOM, // Position where the toast should appear
                      timeInSecForIosWeb: 1, // Time duration in seconds for the toast to be visible on iOS/web platforms
                      backgroundColor: Colors.black54, // Background color of the toast
                      textColor: Colors.white, // Text color of the toast message
                      fontSize: 16.0, // Font size of the toast message
                    );
                  }

                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 4,
                        blurRadius: 2,
                        offset: Offset(1, 0),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Card(
                    elevation: 3,
                    shadowColor: ColorConstant.highlighter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 4,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Redeem Now",
                              style: TextStyle(
                                color: ColorConstant.whiteA700,
                                fontSize: 18,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onTapArrowLeft() {
    Get.back();
  }

  viewStations() async {
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
      await Get.toNamed(AppRoutes.redeemStationsMapScreen);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch location: $e');
    } finally {
      // Close the CircularProgressIndicator() when returning to this screen
      Get.back();
    }
  }


  Widget profileDetail(icon, title, value, previous) {
    return Container(
      child: Padding(
          padding: getPadding(left: 30, right: 20),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomImageView(
                              svgPath: icon,
                              height: getSize(50),
                              width: getSize(50),
                              margin: getMargin(bottom: 10),
                            ),
                            Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: ColorConstant.gray600,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height:
                          80, // Set the height to fill the entire space vertically
                          child: VerticalDivider(
                            color: Colors.grey, // Customize the color as needed
                            thickness: 1.0, // Customize the thickness as needed
                          ),
                        ),
                      ],
                    )),
                //
                Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Text(
                          '₹ ' + value,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: ColorConstant.black900,
                            fontSize: 22,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: getHorizontalSize(10)),
                        Image.asset(
                            title == 'Fuel' || title == 'CNG'
                                ? 'assets/images/redarrow.png'
                                : 'assets/images/greenarrow.png',
                            width: 15,
                            height: 25),
                      ]),
                      SizedBox(height: getVerticalSize(2)),
                      Text(
                        "₹ " + previous,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ColorConstant.gray600,
                          fontSize: 11,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '(Updated on: 29/01/24)',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ColorConstant.gray600,
                          fontSize: 9,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ]),
              ])),
    );
  }
}
