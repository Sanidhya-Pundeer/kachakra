import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/payment_method_screen/models/payment_method_model.dart';

class PaymentData{
  static List<PaymentMethodModel> getpaymentDAta(){
   return [
     PaymentMethodModel(ImageConstant.imgPaypalIcon,"Paypal"),
     PaymentMethodModel(ImageConstant.imgMasterCardIcon,"Master card"),
     PaymentMethodModel(ImageConstant.imgApplePayIcon,"Apple pay"),
     PaymentMethodModel(ImageConstant.imgGooglePayIcon,"Google pay"),
   ];
  }
}