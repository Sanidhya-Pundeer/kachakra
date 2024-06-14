import 'package:courier_delivery/core/app_export.dart';import 'package:courier_delivery/presentation/tracking_details_screen/models/tracking_details_model.dart';/// A controller class for the TrackingDetailsScreen.
///
/// This class manages the state of the TrackingDetailsScreen, including the
/// current trackingDetailsModelObj
class TrackingDetailsController extends GetxController {Rx<TrackingDetailsModel> trackingDetailsModelObj = TrackingDetailsModel().obs;

 }
