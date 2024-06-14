import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/home_container_page/models/home_data.dart';

import '../models/corier_service_model.dart';
import '../models/home_slider_model.dart';
import '../models/recently_shipped_data_model.dart';

import '../models/nearby_service_model.dart';
import '../models/nearby_kabadhiwala_model.dart';

/// A controller class for the HomeContainerPage.
///
/// This class manages the state of the HomeContainerPage, including the
/// current homeContainerModelObj
class HomeContainerController extends GetxController {
  List<HomeSlider> sliderData = HomeData.getSliderData();
  List<NearbyService> courierData = HomeData.getCourierData();
  List<CourierService> nearbyData = HomeData.getnearbyData();
  List<CourierService> nearbyDataall = HomeData.getnearbyDataall();
  List<CourierService> nearbyStations = HomeData.getnearbyStations();
  List<CourierService> nearbyData02 = HomeData.getnearbyData02();
  List<NearbyService> serviceData = HomeData.getServiceData();
  List<NearbyKabadhiwala> kabadhiwalaData = HomeData.getKabadhiwalaData();
  List<RecentlyShipped> recentlyShipped = HomeData.getShippedData();
  Rx<int> sliderIndex = 0.obs;
}
