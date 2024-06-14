import 'package:courier_delivery/core/app_export.dart';import 'package:courier_delivery/presentation/customer_support_screen/models/customer_support_model.dart';import 'package:flutter/material.dart';/// A controller class for the CustomerSupportScreen.
///
/// This class manages the state of the CustomerSupportScreen, including the
/// current customerSupportModelObj
class CustomerSupportController extends GetxController {TextEditingController messagefourController = TextEditingController();

Rx<CustomerSupportModel> customerSupportModelObj = CustomerSupportModel().obs;

@override void onClose() { super.onClose(); messagefourController.dispose(); } 
 }
