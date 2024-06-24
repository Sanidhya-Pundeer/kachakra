import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/payment_method_screen/models/payment_method_model.dart';
import 'package:pay/pay.dart';

class PaymentData{
  static List<PaymentMethodModel> getpaymentDAta(){
   return [
     PaymentMethodModel(ImageConstant.imgRazorPayIcon,"RazorPay"),
     PaymentMethodModel(ImageConstant.imgPhonePeIcon,"PhonePe"),
     PaymentMethodModel(ImageConstant.imgGooglePayIcon,"Google pay"),
     PaymentMethodModel(ImageConstant.imgUpiIcon,"UPI Payments"),
   ];
  }
}