import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/nearby_service_screen/models/nearby_service_model.dart';/// A controller class for the CourierServicesScreen.
///
/// This class manages the state of the CourierServicesScreen, including the
/// current courierServicesModelObj
class NearbyServiceController extends GetxController {Rx<NearbyServiceModel> courierServicesModelObj = NearbyServiceModel().obs;

 }
