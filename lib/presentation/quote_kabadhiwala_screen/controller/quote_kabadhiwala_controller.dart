import 'package:courier_delivery/core/app_export.dart';
import 'package:flutter/material.dart';

import '../models/quote_kabadhiwala_model.dart';

/// A controller class for the SendPackageScreen.
///
/// This class manages the state of the SendPackageScreen, including the
/// current sendPackageModelObj
class QuoteKabadhiwalaController extends GetxController {
  TextEditingController locationController = TextEditingController();

  TextEditingController locationoneController = TextEditingController();

  TextEditingController grouptwentyfourController = TextEditingController();

  Rx<QuoteKabadhiwalaModel> sendPackageModelObj = QuoteKabadhiwalaModel().obs;
int packageQuentyty = 1;

void increagePackageQuentity(){
 packageQuentyty++;
 update();
}

void decreseQuentity(){
  packageQuentyty--;
  update();
}

}
