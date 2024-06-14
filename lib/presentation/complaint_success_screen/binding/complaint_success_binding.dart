import '../controller/complaint_success_controller.dart';
import 'package:get/get.dart';

/// A binding class for the OrderSuccessScreen.
///
/// This class ensures that the OrderSuccessController is created when the
/// OrderSuccessScreen is first loaded.
class ComplaintSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ComplaintSuccessController());
  }
}
