import 'package:courier_delivery/core/app_export.dart';

/// A controller class for the SelectCourierServiceScreen.
///
/// This class manages the state of the SelectCourierServiceScreen, including the
/// current selectCourierServiceModelObj
class KabadhiwalaController extends GetxController {
  int currentServices = 0;

  void setCurrentCurierServices(int index) {
    currentServices = index;
    update();
  }
}
