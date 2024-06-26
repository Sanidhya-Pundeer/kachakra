import 'package:courier_delivery/presentation/faq_screen/models/faq_model.dart';

class FaqData {
  static List<FaqModel> getFaqData() {
    return [
      FaqModel("How to run the app?", "Open the application"),
      FaqModel("How to install the app?", "Download from the app store"),
      FaqModel("How to update the app?", "Check for updates in the app store"),
      FaqModel("How to uninstall the app?", "Remove it from your device"),
      FaqModel(
          "How to contact support?", "Visit the support section in the app"),
    ];
  }
}




// class PaymentData {
//   static List<PaymentMethodModel> getpaymentDAta() {
//     return [
//       PaymentMethodModel(ImageConstant.imgRazorPayIcon, "RazorPay"),
//       // PaymentMethodModel(ImageConstant.imgPhonePeIcon,"PhonePe"),
//       // PaymentMethodModel(ImageConstant.imgGooglePayIcon,"Google pay"),
//       // PaymentMethodModel(ImageConstant.imgUpiIcon,"UPI Payments"),
//     ];
//   }
// }


// class PaymentMethodModel {
//   String? icon;
//   String? title;
//   PaymentMethodModel(this.icon, this.title);
// }
