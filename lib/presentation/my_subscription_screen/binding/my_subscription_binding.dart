import 'package:courier_delivery/presentation/my_subscription_screen/controller/my_subscription_controller.dart';
import 'package:get/get.dart';

/// A binding class for the ProfileDetailsScreen.
///
/// This class ensures that the ProfileDetailsController is created when the
/// ProfileDetailsScreen is first loaded.
class MySubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MySubscriptionController());
  }
}
