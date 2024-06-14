import 'package:courier_delivery/core/app_export.dart';import 'package:courier_delivery/presentation/courier_services_screen/models/courier_services_model.dart';/// A controller class for the CourierServicesScreen.
///
/// This class manages the state of the CourierServicesScreen, including the
/// current courierServicesModelObj
class CourierServicesController extends GetxController {Rx<CourierServicesModel> courierServicesModelObj = CourierServicesModel().obs;

 }
