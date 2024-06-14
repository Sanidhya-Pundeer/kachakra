import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/replace_bin_screen/models/replace_bin_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/constants/apiConstants.dart';
import '../../../data/userData.dart';

/// A controller class for the SendPackageScreen.
///
/// This class manages the state of the SendPackageScreen, including the
/// current sendPackageModelObj
class ReplaceBinController extends GetxController {
  TextEditingController locationController = TextEditingController();

  TextEditingController locationoneController = TextEditingController();

  TextEditingController grouptwentyfourController = TextEditingController();

  Rx<ReplaceBinModel> sendPackageModelObj = ReplaceBinModel().obs;
int packageQuentyty = 1;

  final apiUrl = ApiConstants.addRequest;
  RxString chargeInfo = "0".tr.obs;


  void updateChargeInfo(String newInfo) {
    chargeInfo.value = newInfo;
  }

  void increagePackageQuentity() {
    packageQuentyty++;
    update();
  }

  void decreseQuentity() {
    packageQuentyty--;
    update();
  }

  Future<void> generateRequest() async {
    int user_id = UserData.userId; // Replace with your logic
    int vendor_id = 0; // Replace with your logic
    String request_type = 'MSW'; // Replace with your logic
    String customer_address = UserData.userAddress; // Replace with your logic
    String service_name = 'Replace/Buy Bin'; // Replace with your logic
    String replacement_part = ''; // Replace with your logic
    String type_of_waste = ''; // Replace with your logic
    String weight = '10 Kg'; // Replace with your logic
    String other_detail = ''; // Replace with your logic
    String quantity = packageQuentyty.toString(); // Replace with your logic
    String scrap_material_one = ''; // Replace with your logic
    String scrap_material_five = ''; // Replace with your logic
    String scrap_material_two = '';
    String scrap_material_three = ''; // Replace with your logic
    String scrap_material_four = ''; // Replace with your logic
    String status = 'Pending'; // Replace with your logic
    String vendor_type = ''; // Replace with your logic
    String price = 'Rs. 400/-';
    String payment_method = 'UPI'; // Replace with your logic
    String transaction_number = '7841848489269'; // Replace with your logic

    try {
      final response = await http.post(
        Uri.parse(apiUrl), // Replace with your actual API endpoint
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': user_id,
          'customer_address': customer_address,
          'request_type': request_type,
          'service_name': service_name,
          'replacement_part': replacement_part,
          'type_of_waste': type_of_waste,
          'weight': weight,
          'quantity': quantity,
          'scrap_material_one': scrap_material_one,
          'scrap_material_two': scrap_material_two,
          'scrap_material_three': scrap_material_three,
          'scrap_material_four': scrap_material_four,
          'scrap_material_five': scrap_material_five,
          'vendor_type': vendor_type,
          'vendor_id': vendor_id,
          'other_detail': other_detail,
          'price': price,
          'payment_method': payment_method,
          'transaction_number': transaction_number,
          'status': status,
        }),
      );

      if (response.statusCode == 200) {
        print("Request Generated Successfully---- ${response.body}");

        Get.toNamed(
          AppRoutes.orderSuccessScreen,
        );
      } else {
        print(
            "Error generating request: ${response.statusCode}, ${response.body}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}
