import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/data/requestData.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:courier_delivery/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TrackingDetailsScreen extends StatefulWidget {
  const TrackingDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TrackingDetailsScreen> createState() => _TrackingDetailsScreenState();
}

class _TrackingDetailsScreenState extends State<TrackingDetailsScreen> {

  List<String> cancelReasons = [
    'Request generated accidently.',
    'Change my mind.',
    'Looking for better options',
    // Add more reasons as needed
  ];

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
                          onTapArrowleft12();
                        }),
                    centerTitle: true,
                    title: AppbarSubtitle1(text: "msg_tracking_details".tr),
                    styleType: Style.bgFillWhiteA700),
                body: Container(
                    width: double.maxFinite,
                    padding: getPadding(all: 16),
                    child: ListView(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  padding: getPadding(all: 16),
                                  decoration: AppDecoration.fillGray50.copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder8),
                                  child: Row(children: [
                                    CustomIconButton(
                                        height: 64,
                                        width: 64,
                                        shape: IconButtonShape.CircleBorder32,
                                        padding: IconButtonPadding.PaddingAll14,
                                        child: CustomImageView(
                                            svgPath: ImageConstant
                                                .imgArrowdownDeepPurple600)),
                                    Padding(
                                        padding: getPadding(
                                            left: 8, top: 8, bottom: 4),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(RequestData.type_of_waste.tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle.txtHeadline),
                                              Container(
                                                  height: getVerticalSize(16),
                                                  width: getHorizontalSize(140),
                                                  margin: getMargin(top: 12),
                                                  child: Stack(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      children: [
                                                        Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                                "# " + RequestData.transactionNumber
                                                                    .tr,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: AppStyle
                                                                    .txtFootnote)),
                                                        Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Container(
                                                                height:
                                                                    getSize(3),
                                                                width:
                                                                    getSize(3),
                                                                margin:
                                                                    getMargin(
                                                                        left:
                                                                            60,
                                                                        top: 5),
                                                                decoration: BoxDecoration(
                                                                    color: ColorConstant
                                                                        .black900,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            getHorizontalSize(1)))))
                                                      ]))
                                            ]))
                                  ])),
                              Container(
                                  height: getVerticalSize(224),
                                  width: getHorizontalSize(396),
                                  margin: getMargin(top: 16),
                                  child: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        CustomImageView(
                                            imagePath:
                                                ImageConstant.imgRectangle4428,
                                            height: getVerticalSize(224),
                                            width: getHorizontalSize(396),
                                            radius: BorderRadius.circular(
                                                getHorizontalSize(8)),
                                            alignment: Alignment.center),
                                        CustomButton(
                                            height: getVerticalSize(40),
                                            width: getHorizontalSize(143),
                                            text: "lbl_live_tracking".tr,
                                            margin:
                                                getMargin(left: 8, bottom: 8),
                                            padding: ButtonPadding.PaddingAll11,
                                            fontStyle: ButtonFontStyle
                                                .SFProTextBold15WhiteA700,
                                            onTap: () {
                                              onTapLivetracking();
                                            },
                                            alignment: Alignment.bottomLeft)
                                      ])),
                              Padding(
                                  padding: getPadding(top: 21),
                                  child: Text("msg_tracking_history".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextBold20)),
                              SizedBox(
                                height: getVerticalSize(16),
                              ),
                              Row(
                                children: [
                                  CustomImageView(
                                    svgPath: ImageConstant.imgTrackingOrder,
                                    height: getSize(318),
                                  ),
                                  SizedBox(width: getHorizontalSize(14)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("lbl_checking".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.txtHeadline),
                                            Padding(
                                                padding: getPadding(top: 8),
                                                child: Text(
                                                    "Assigned Driver ID: " + RequestData.vendorId.toString().tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style:
                                                        AppStyle.txtFootnote))
                                          ]),
                                      SizedBox(
                                        height: getVerticalSize(40),
                                      ),
                                      Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("msg_waiting_for_pick2".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.txtHeadline),
                                            Padding(
                                                padding: getPadding(top: 13),
                                                child: Text(
                                                    RequestData.weight.tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style:
                                                        AppStyle.txtFootnote))
                                          ]),
                                      SizedBox(
                                        height: getVerticalSize(40),
                                      ),
                                      Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: getPadding(top: 13),
                                                child: Text(RequestData.requestStatus.tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.txtHeadline)),
                                            CustomButton(
                                                    height: getVerticalSize(30),
                                                    width: getHorizontalSize(50),
                                                    text: "Pay".tr,
                                                    margin:
                                                    getMargin(left: 8),
                                                    padding: ButtonPadding.PaddingAll8,
                                                    fontStyle: ButtonFontStyle
                                                        .SFProTextBold15WhiteA700,
                                                    onTap: () {
                                                      Get.toNamed(
                                                        AppRoutes.paymentMethodScreen,
                                                      );
                                                      },
                                                    alignment: Alignment.center),
                                            Padding(
                                                padding: getPadding(top: 13, left: 10),
                                                child: Text('or',
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle.txtHeadline)),
                                            CustomButton(
                                                height: getVerticalSize(30),
                                                width: getHorizontalSize(50),
                                                text: "Cancel".tr,
                                                margin:
                                                getMargin(left: 8),
                                                padding: ButtonPadding.PaddingAll8,
                                                fontStyle: ButtonFontStyle
                                                    .SFProTextBold15WhiteA700,
                                                onTap: () {
                                                  _showCancelReasonDialog();

                                                },
                                                alignment: Alignment.center),
                                          ]),
                                      SizedBox(
                                        height: getVerticalSize(40),
                                      ),
                                      Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Completed".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle.txtHeadline),
                                            Padding(
                                                padding: getPadding(top: 13),
                                                child: Text(
                                                    "Your Request is Completed".tr,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style:
                                                    AppStyle.txtFootnote))
                                          ])
                                    ],
                                  )
                                ],
                              ),
                            ]),
                      ],
                    )))));
  }

  _showCancelReasonDialog() {
    String? selectedReason;
    String otherReason = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Select reason for cancellation",
              style: TextStyle(
                fontSize: 16,

              ),),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // List of predefined reasons with radio buttons
                    for (String reason in cancelReasons)
                      RadioListTile(
                        title: Text(reason,
                          style: TextStyle(
                            fontSize: 14,
                          ),),
                        value: reason,
                        groupValue: selectedReason,
                        onChanged: (value) {
                          setState(() {
                            selectedReason = value;
                          });
                        },
                      ),
                    // Text input for other reasons
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Other Reason',
                      ),
                      onChanged: (value) {
                        otherReason = value;
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Get.back();
                  },
                ),
                TextButton(
                  child: Text('Confirm'),
                  onPressed: () {
                    String? finalReason = selectedReason != '' ? selectedReason : otherReason;
                    if (finalReason != '') {
                      RequestData.requestStatus = 'Cancelled';
                      // Perform any other necessary actions here
                      Get.toNamed(AppRoutes.homeContainer1Screen);
                    } else {
                      RequestData.requestStatus = 'Cancelled';
                      // Perform any other necessary actions here
                      Get.toNamed(AppRoutes.homeContainer1Screen);
                      // Show error message or handle empty reason
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }



  onTapLivetracking() {
    Get.toNamed(
      AppRoutes.liveTrackingOneScreen,
    );
  }

  onTapArrowleft12() {
    Get.back();
  }
}
