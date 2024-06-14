import 'package:courier_delivery/core/app_export.dart';

import '../models/redeem_stations_map_model.dart';/// A controller class for the CourierServicesScreen.
///
/// This class manages the state of the CourierServicesScreen, including the
/// current courierServicesModelObj
class RedeemStationsMapController extends GetxController {

 Rx<RedeemStationsMapModel> courierServicesModelObj = RedeemStationsMapModel().obs;

}
