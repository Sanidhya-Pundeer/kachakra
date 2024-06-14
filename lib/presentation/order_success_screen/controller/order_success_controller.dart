import 'package:courier_delivery/core/app_export.dart';import 'package:courier_delivery/presentation/order_success_screen/models/order_success_model.dart';/// A controller class for the OrderSuccessScreen.
///
/// This class manages the state of the OrderSuccessScreen, including the
/// current orderSuccessModelObj
class OrderSuccessController extends GetxController {Rx<OrderSuccessModel> orderSuccessModelObj = OrderSuccessModel().obs;

 }
