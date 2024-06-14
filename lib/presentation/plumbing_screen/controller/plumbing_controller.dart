import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/plumbing_screen/models/plumbing_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the SendPackageScreen.
///
/// This class manages the state of the SendPackageScreen, including the
/// current sendPackageModelObj
class PlumbingController extends GetxController {
  TextEditingController locationController = TextEditingController();

  TextEditingController locationoneController = TextEditingController();

  TextEditingController grouptwentyfourController = TextEditingController();

  Rx<PlumbingModel> sendPackageModelObj = PlumbingModel().obs;
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
