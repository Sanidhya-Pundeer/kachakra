import '../controller/redeem_stations_map_controller.dart';
import 'package:get/get.dart';

/// A binding class for the CourierServicesScreen.
///
/// This class ensures that the CourierServicesController is created when the
/// CourierServicesScreen is first loaded.
class RedeemStationsMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RedeemStationsMapController());
  }
}
