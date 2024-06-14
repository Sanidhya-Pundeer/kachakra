import '../controller/safai_karamchari_controller.dart';
import 'package:get/get.dart';

/// A binding class for the SelectCourierServiceScreen.
///
/// This class ensures that the SelectCourierServiceController is created when the
/// SelectCourierServiceScreen is first loaded.
class SafaiKaramchariBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SafaiKaramchariController());
  }
}
