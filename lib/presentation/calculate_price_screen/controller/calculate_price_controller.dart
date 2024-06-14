import 'package:courier_delivery/core/app_export.dart';import 'package:courier_delivery/presentation/calculate_price_screen/models/calculate_price_model.dart';/// A controller class for the CalculatePriceScreen.
///
/// This class manages the state of the CalculatePriceScreen, including the
/// current calculatePriceModelObj
class CalculatePriceController extends GetxController {Rx<CalculatePriceModel> calculatePriceModelObj = CalculatePriceModel().obs;

 }
