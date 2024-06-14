import '../controller/quote_kabadhiwala_controller.dart';
import 'package:get/get.dart';

/// A binding class for the SendPackageScreen.
///
/// This class ensures that the SendPackageController is created when the
/// SendPackageScreen is first loaded.
class QuoteKabadhiwalaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuoteKabadhiwalaController());
  }
}
