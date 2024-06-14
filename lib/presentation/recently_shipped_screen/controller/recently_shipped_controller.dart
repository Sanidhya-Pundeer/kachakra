import 'package:courier_delivery/core/app_export.dart';import 'package:courier_delivery/presentation/recently_shipped_screen/models/recently_shipped_model.dart';/// A controller class for the RecentlyShippedScreen.
///
/// This class manages the state of the RecentlyShippedScreen, including the
/// current recentlyShippedModelObj
class RecentlyShippedController extends GetxController {Rx<RecentlyShippedModel> recentlyShippedModelObj = RecentlyShippedModel().obs;

 }
