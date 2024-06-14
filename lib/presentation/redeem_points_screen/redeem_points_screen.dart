import 'package:courier_delivery/presentation/redeem_points_screen/widgets/redeem_points_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../data/pointsData.dart';
import '../../data/requestData.dart';
import '../../widgets/circular_pie_chart.dart';
import 'controller/redeem_points_controller.dart';

class RedeemPointsScreen extends StatefulWidget {
  @override
  State<RedeemPointsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<RedeemPointsScreen> {
  RedeemPointsController controller = Get.put(RedeemPointsController());

  TextEditingController totalAmountController = TextEditingController();
  TextEditingController redeemValueController = TextEditingController();
  double netPayable = 0;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController qrcontroller;
  String selectedItem = '';
  bool _validateTotalAmount = false;
  bool _validateRedeemValue = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorConstant.whiteA700,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    totalAmountController.addListener(_calculateNetPayable);
    redeemValueController.addListener(_calculateNetPayable);
    super.initState();
  }

  @override
  void dispose() {
    totalAmountController.dispose();
    redeemValueController.dispose();
    super.dispose();
  }

  void _calculateNetPayable() {
    double totalAmount = double.tryParse(totalAmountController.text) ?? 0;
    double redeemValue = double.tryParse(redeemValueController.text) ?? 0;
    setState(() {
      netPayable = totalAmount - redeemValue;
    });
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
          body: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: getPadding(left: 16, top: 10, right: 16, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  WasteExanpleList(
                    selectedItem: selectedItem,
                    redeemValue: double.tryParse(redeemValueController.text) ?? 0,
                  ),
                  SizedBox(height: getVerticalSize(10)),
                  Container(
                    padding: getPadding(left: 10),
                    width: double.maxFinite,
                    child: Text(
                      'Selected:',
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // selectedItem = "Petrol";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: PointsData.selectedFuel == "Petrol" ? ColorConstant.highlighter.withOpacity(0.3) : null,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: profileDetail(
                                ImageConstant.imgpetrol,
                                "Petrol",
                                "","",
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // selectedItem = "Diesel";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: PointsData.selectedFuel == "Diesel" ? ColorConstant.highlighter.withOpacity(0.3) : null,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: profileDetail(
                                ImageConstant.imgdiesel,
                                "Diesel",
                                "","",
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // selectedItem = "Compost";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: PointsData.selectedFuel == "CNG" ? ColorConstant.highlighter.withOpacity(0.3) : null,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: profileDetail(
                                ImageConstant.imgcompost,
                                "CNG",
                                "","",
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // selectedItem = "LPG";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: PointsData.selectedFuel == "LPG" ? ColorConstant.highlighter.withOpacity(0.3) : null,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: profileDetail(
                                ImageConstant.imggas,
                                "LPG",
                                "","",
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 2,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 12),
                                child: Text(
                                  'Total Amount:',
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              TextField(
                                controller: totalAmountController,
                                keyboardType:
                                TextInputType.numberWithOptions(
                                    decimal: true),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: ColorConstant.black9007e,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintText: "Enter Total Fuel Amount!",
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  border: InputBorder.none,
                                  errorText: _validateTotalAmount
                                      ? '*Total Amount must be at least 500.'
                                      : null,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _validateTotalAmount =
                                        (double.tryParse(value) ?? 0) < 500;
                                  });
                                  _calculateNetPayable();
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 2,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 12),
                                child: Text(
                                  'Redeem Value:',
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              TextField(
                                controller: redeemValueController,
                                keyboardType:
                                TextInputType.numberWithOptions(
                                    decimal: true),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: ColorConstant.black9007e,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintText: "Enter value to Redeem!",
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  border: InputBorder.none,
                                  errorText: _validateRedeemValue
                                      ? '*Redeem Value must be at least 100.\n*less than Total Amount.'
                                      : null,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _validateRedeemValue =
                                        (double.tryParse(value) ?? 0) < 100 ||
                                            (double.tryParse(value) ?? 0) >=
                                                (double.tryParse(
                                                    totalAmountController
                                                        .text) ??
                                                    0);
                                  });
                                  _calculateNetPayable();
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Net Payable: $netPayable',
                          style: TextStyle(
                            color: ColorConstant.black900,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: getPadding(
                      top: 0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/viewscore.jpg'),
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
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Weekly Bio Waste: 15 kg",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Biogas Generated: 50",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Points Redeemed: 100",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: getSize(120),
                              width: getSize(120),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircularPieChart(
                                    percentage: 0.9,
                                    size: getSize(150),
                                    totalScore: 900,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      if (!_validateTotalAmount && !_validateRedeemValue && totalAmountController.text != "" && redeemValueController.text != "") {
                        scanToPay();
                      }

                      else {
                        Fluttertoast.showToast(
                          msg: "Please enter a valid Total Amount and Redeem Value.",
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
                      padding: EdgeInsets.all(0),
                      child: Card(
                        color: Colors.white,
                        elevation: 3,
                        shadowColor: ColorConstant.highlighter,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Scan",
                                  style: TextStyle(
                                    color: ColorConstant.whiteA700,
                                    fontSize: 24,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
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
      ),
    );
  }

  onTapArrowLeft() {
    Get.back();
  }

  scanToPay() {
    Get.to(
      Scaffold(
        appBar: AppBar(
          title: Text('Scan To Pay'),
        ),
        body: _buildQrView(context),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return Container(
      // color: Colors.white,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/qr-code-bg.jpeg'),
          fit: BoxFit.cover,
        ),
      ),// Set background color to white
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            padding: EdgeInsets.all(16),
            margin: getMargin(all: 50),
            child: Container(
              width: 500,
              height: 300,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
          ),
          Text(
            '\n',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }


  void _onQRViewCreated(QRViewController controller) {
    this.qrcontroller = controller;

    controller.scannedDataStream.listen((scanData) {
      print("Scanned QR Code: ${scanData.code}");

      Get.back();
      controller.dispose();

      handleScannedData(scanData.code);
    });
  }

  void handleScannedData(String? scannedData) {
    // print("Handling Scanned Data: $scannedData");
    RequestData.vendorDetail = scannedData;

    Get.toNamed(
      AppRoutes.paymentMethodScreen,
    );
  }

  Widget profileDetail(icon, title, value, previous) {
    return Container(
      padding: getPadding(top: 10, bottom: 10, left: 15, right: 15),
      child: Padding(
          padding: getPadding(left: 0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomImageView(
                        svgPath: icon,
                        height: getSize(40),
                        width: getSize(40),
                        margin: getMargin(bottom: 8),
                      ),
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ColorConstant.gray600,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
    );
  }
}

