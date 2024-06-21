import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/data/requestData.dart';
import 'package:courier_delivery/presentation/payment_method_screen/googlepay_screen.dart';
import 'package:courier_delivery/presentation/payment_method_screen/payment_configurations.dart';
import 'package:courier_delivery/presentation/payment_method_screen/razor_pay_api.dart';
import 'package:courier_delivery/presentation/payment_method_screen/phonepe_payment.dart';
import 'package:courier_delivery/presentation/payment_method_screen/upi_payment_screen.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pay/pay.dart';

import 'controller/payment_method_controller.dart';
import 'models/payment_method_model.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  PaymentMethodController paymentMethodController =
      Get.put(PaymentMethodController());
  final paymentItems = <PaymentItem>[];
  late int current = 0;
  late PaymentConfiguration _googlePayConfigFuture;

  @override
  void initState() {
    // _googlePayConfigFuture =
    //     PaymentConfiguration.fromAsset('gpay.json') as PaymentConfiguration;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: ColorConstant.whiteA700,
          statusBarIconBrightness: Brightness.dark),
    );
    paymentItems.add(PaymentItem(
        amount: '${retrievePaymentAmount}',
        label: "Bin",
        status: PaymentItemStatus.final_price));
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
                          onTapArrowleft9();
                        }),
                    centerTitle: true,
                    title: AppbarSubtitle1(text: "lbl_payment_method".tr),
                    styleType: Style.bgFillWhiteA700),
                body: GetBuilder<PaymentMethodController>(
                  init: PaymentMethodController(),
                  builder: (controller) => Container(
                      width: double.maxFinite,
                      padding: getPadding(top: 21, bottom: 21),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: getPadding(left: 16, right: 16),
                              child: Text("Vendor details:".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtSFProTextBold20),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                margin: getMargin(all: 16),
                                padding:
                                    getPadding(left: 16, right: 16, top: 8),
                                decoration: AppDecoration.fillGray50.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder16,
                                    color: ColorConstant.deepPurple50,
                                    border: Border.all(
                                        color: ColorConstant.deepPurple600)),
                                child: Padding(
                                  padding: getPadding(left: 16, right: 16),
                                  child: Text(
                                    RequestData.vendorDetail!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                            Padding(
                              padding: getPadding(left: 16, right: 16),
                              child: Text("lbl_payment_method".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtSFProTextBold20),
                            ),
                            ListView.builder(
                              padding: getPadding(left: 16, right: 16, top: 8),
                              primary: false,
                              shrinkWrap: true,
                              itemCount: controller.paymentMethods.length,
                              itemBuilder: (context, index) {
                                PaymentMethodModel data =
                                    controller.paymentMethods[index];
                                return GestureDetector(
                                  onTap: () {
                                    controller.setCurrentPaymentMethod(index);
                                    print("Index: ${index}");
                                    current = index;
                                  },
                                  child: Padding(
                                    padding: getPadding(top: 8, bottom: 8),
                                    child: Container(
                                      decoration: AppDecoration.fillGray50
                                          .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder16,
                                              color:
                                                  controller.currentPayment ==
                                                          index
                                                      ? ColorConstant
                                                          .deepPurple50
                                                      : ColorConstant.gray50,
                                              border: Border.all(
                                                  color: controller
                                                              .currentPayment ==
                                                          index
                                                      ? ColorConstant
                                                          .deepPurple600
                                                      : ColorConstant.gray50)),
                                      child: Padding(
                                        padding: getPadding(
                                            top: 20,
                                            bottom: 20,
                                            left: 16,
                                            right: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                CustomImageView(
                                                    svgPath: data.icon,
                                                    height: getSize(36),
                                                    width: getSize(36),
                                                    alignment:
                                                        Alignment.center),
                                                Text(data.title!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle.txtHeadline)
                                              ],
                                            ),
                                            CustomImageView(
                                              svgPath: controller
                                                          .currentPayment ==
                                                      index
                                                  ? ImageConstant.imgEyeBlack900
                                                  : ImageConstant
                                                      .imgIcRadioButton,
                                            )
                                            //ImageConstant.imgIcRadioButton,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            ElevatedButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpiPayment(),
                                    )),
                                child: Text('for upi payment')),
                            SizedBox(
                              height: getVerticalSize(24),
                            ),
                            GestureDetector(
                              onTap: () {
                                onTapAddnewcard();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomImageView(
                                      svgPath: ImageConstant.imgIcAdd),
                                  SizedBox(
                                    width: getHorizontalSize(8),
                                  ),
                                  Text(
                                    "lbl_add_new_card".tr,
                                    style: AppStyle.txtSFProDisplayRegular16,
                                  ),
                                ],
                              ),
                            ),
                          ])),
                ),
                bottomNavigationBar: CustomButton(
                    height: getVerticalSize(54),
                    text: "lbl_pay_now".tr,
                    margin: getMargin(left: 16, right: 16, bottom: 40),
                    onTap: () {
                      onTapPaynow();
                    }))));
  }

  onTapAddnewcard() {
    Get.toNamed(
      AppRoutes.addCardDefualtScreen,
    );
  }

  onTapPaynow() {
    if (current == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RazorPay(),
          ));
    } else if (current == 1) {
      // Get.toNamed(
      //   AppRoutes.orderSuccessScreen,
      // );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhonePePayment(),
          ));
    } else if (current == 2) {
      Get.toNamed(
        AppRoutes.orderSuccessScreen,
      );
    } else if (current == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GooglePayScreen(),
          ));
    }
  }

  onTapArrowleft9() {
    Get.back();
  }

  Future<String> retrievePaymentAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String payment = prefs.getString('payment') ?? '';
    print("Payment Amount: ${payment}");
    return payment;
  }
}
