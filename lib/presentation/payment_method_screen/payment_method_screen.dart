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
import 'package:upi_india/upi_india.dart';
import 'package:upi_india/upi_response.dart';

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
  Future<UpiResponse>? _transaction;
  final UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      print(e);
      apps = [];
    });
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
                      child: SingleChildScrollView(
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
                                child: Text("Payment Gateway".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtSFProTextBold20),
                              ),
                              ListView.builder(
                                padding:
                                    getPadding(left: 16, right: 16, top: 8),
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
                                                color: controller
                                                            .currentPayment ==
                                                        index
                                                    ? ColorConstant.deepPurple50
                                                    : ColorConstant.gray50,
                                                border: Border.all(
                                                    color: controller
                                                                .currentPayment ==
                                                            index
                                                        ? ColorConstant
                                                            .deepPurple600
                                                        : ColorConstant
                                                            .gray50)),
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
                                                      style:
                                                          AppStyle.txtHeadline)
                                                ],
                                              ),
                                              CustomImageView(
                                                svgPath: controller
                                                            .currentPayment ==
                                                        index
                                                    ? ImageConstant
                                                        .imgEyeBlack900
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
                              SizedBox(
                                height: getVerticalSize(24),
                              ),
                              Padding(
                                padding: getPadding(left: 16, right: 16),
                                child: Text("UPI payments".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtSFProTextBold20),
                              ),
                              Padding(
                                padding: getPadding(left: 16, right: 16),
                                child: displayUpiApps(),
                              ),
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
                              FutureBuilder(
                                future: _transaction,
                                builder: (BuildContext context,
                                    AsyncSnapshot<UpiResponse> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text(
                                          _upiErrorHandler(
                                              snapshot.error.runtimeType),
                                        ), // Print's text message on screen
                                      );
                                    }

                                    // If we have data then definitely we will have UpiResponse.
                                    // It cannot be null
                                    UpiResponse _upiResponse = snapshot.data!;

                                    // Data in UpiResponse can be null. Check before printing
                                    String txnId =
                                        _upiResponse.transactionId ?? 'N/A';
                                    String resCode =
                                        _upiResponse.responseCode ?? 'N/A';
                                    String txnRef =
                                        _upiResponse.transactionRefId ?? 'N/A';
                                    String status =
                                        _upiResponse.status ?? 'N/A';
                                    String approvalRef =
                                        _upiResponse.approvalRefNo ?? 'N/A';
                                    _checkTxnStatus(status);

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          displayTransactionData(
                                              'Transaction Id', txnId),
                                          displayTransactionData(
                                              'Response Code', resCode),
                                          displayTransactionData(
                                              'Reference Id', txnRef),
                                          displayTransactionData(
                                              'Status', status.toUpperCase()),
                                          displayTransactionData(
                                              'Approval No', approvalRef),
                                        ],
                                      ),
                                    );
                                  } else
                                    return Center(
                                      child: Text(''),
                                    );
                                },
                              ),
                            ]),
                      )),
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
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GooglePayScreen(),
          ));
    }
    // else if (current == 3) {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => UpiPayment(),
    //       ));
    // }
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

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
        app: app,
        receiverUpiId: '9354694470@paytm',
        receiverName: 'Sanidhya Singh Pundeer',
        transactionRefId: 'Testing UPI',
        transactionNote: 'Not actual, just for testing');
  }

  Widget displayUpiApps() {
    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps!.length == 0)
      return Center(
        child: Text(
          "No apps found to handle transaction.",
        ),
      );
    else
      return Wrap(
        children: apps!.map<Widget>((UpiApp app) {
          return GestureDetector(
            onTap: () {
              _transaction = initiateTransaction(app);
              setState(() {});
            },
            child: Container(
              height: 100,
              width: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.memory(
                    app.icon,
                    height: 60,
                    width: 60,
                  ),
                  Text(app.name),
                ],
              ),
            ),
          );
        }).toList(),
      );
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: "),
          Flexible(
              child: Text(
            body,
          )),
        ],
      ),
    );
  }
}
