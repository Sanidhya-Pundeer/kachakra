import '../controller/submit_complaint_controller.dart';
import 'package:get/get.dart';

/// A binding class for the AddAddressScreen.
///
/// This class ensures that the AddAddressController is created when the
/// AddAddressScreen is first loaded.
class SubmitComplaintBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubmitComplaintController());
  }
}
