import '../controller/scrap_waste_industry_controller.dart';
import 'package:get/get.dart';

/// A binding class for the SendPackageScreen.
///
/// This class ensures that the SendPackageController is created when the
/// SendPackageScreen is first loaded.
class ScrapWasteIndustryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScrapWasteIndustryController());
  }
}
