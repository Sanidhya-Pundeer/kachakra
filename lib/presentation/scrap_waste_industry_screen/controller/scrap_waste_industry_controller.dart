import 'dart:async';

import 'package:courier_delivery/core/app_export.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/constants/apiConstants.dart';
import '../../../data/requestData.dart';
import '../../../data/userData.dart';
import '../models/scrap_waste_industry_model.dart';

class ScrapWasteIndustryController extends GetxController {
  TextEditingController locationController = TextEditingController();
  TextEditingController locationoneController = TextEditingController();
  TextEditingController grouptwentyfourController = TextEditingController();
  Rx<ScrapWasteIndustryModel> sendPackageModelObj = ScrapWasteIndustryModel().obs;
  int packageQuentyty = 1;
  final apiUrl = ApiConstants.addRequest;

  bool continueCheckingStatus = true;

  RxString chargeInfo = "150".tr.obs;
  
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
    int user_id = UserData.userId;
    int vendor_id = 0;
    String request_type = 'Pickup';
    String customer_address = UserData.userAddress;
    String service_name = 'Waste Pickup';
    String replacement_part = '';
    String type_of_waste = RequestData.type_of_waste;
    String weight = RequestData.weight;
    String other_detail = '';
    String quantity = '';
    String scrap_material_one = '';
    String scrap_material_five = '';
    String scrap_material_two = '';
    String scrap_material_three = '';
    String scrap_material_four = '';
    String status = 'Pending';
    String vendor_type = '';
    String price = RequestData.price;
    String payment_method = 'UPI';
    String transaction_number = '5974534695269';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
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
        checkStatusPeriodically();
      } else {
        print("Error generating request: ${response.statusCode}, ${response.body}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  Future<void> checkStatusPeriodically() async {
    const duration = Duration(seconds: 10);
    bool statusChanged = false;
    await showLoadingDialog();

    while (!statusChanged && continueCheckingStatus) {

      var statusResponse = await checkStatusApiCall();

      if (statusResponse.statusCode == 200) {

        final List<dynamic> responseData = json.decode(statusResponse.body);

        if (responseData.isNotEmpty && responseData.first is Map<String, dynamic>) {
          // Assuming that responseData is a list and the first element is a map

          final Map<String, dynamic> firstElement = responseData.first;

          // Check if the key "status" exists and its value is "In-Progress"
          if (firstElement.containsKey('status') && firstElement['status'] == "In-Progress") {
            print("Status Changed to In-Progress: $responseData");

            RequestData.requestId = firstElement['ID'];
            RequestData.requestStatus = firstElement['status'];
            RequestData.requestType = firstElement['request_type'];
            RequestData.vendorId = firstElement['vendor_id'];
            RequestData.weight = firstElement['weight'];
            RequestData.price = firstElement['price'];
            RequestData.type_of_waste = firstElement['type_of_waste'];
            RequestData.transactionNumber = firstElement['transaction_number'];
            RequestData.serviceName = firstElement['service_name'];

            statusChanged = true;
            showRequestDetailsDialog();
          } else {
            print("Status Not Changed: $responseData");
            RequestData.requestId = firstElement['ID'];
            RequestData.requestStatus = firstElement['status'];
            RequestData.requestType = firstElement['request_type'];
            RequestData.vendorId = firstElement['vendor_id'];
            RequestData.weight = firstElement['weight'];
            RequestData.price = firstElement['price'];
            RequestData.type_of_waste = firstElement['type_of_waste'];
            RequestData.transactionNumber = firstElement['transaction_number'];
            RequestData.serviceName = firstElement['service_name'];
            // Wait for 10 seconds before the next API call
            await Future.delayed(duration);
          }
        } else {
          print("Invalid response format");
        }
      } else {
        print("Error checking status: ${statusResponse.statusCode}, ${statusResponse.body}");
      }

    }
  }

  Future<http.Response> checkStatusApiCall() async {
    try {
      final statusResponse = await http.get(
        Uri.parse(ApiConstants.getRequestCurrentStatusByID + UserData.userId.toString()),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (statusResponse.statusCode == 200) {
        try {
          final cleanedBody = statusResponse.body;
          return http.Response(cleanedBody, 200);
        } catch (e) {
          return http.Response(statusResponse.body, 200);
        }
      } else {
        return statusResponse;
      }
    } catch (error) {
      print("Error making API call: $error");
      return http.Response('Error making API call', 500);
    }
  }

  Future<void> showLoadingDialog() async {
    Get.defaultDialog(
      title: 'Please Wait',
        textConfirm:'Minimize',
      content: Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Looking for vehicles for you..'),
        ],
      ),
      barrierDismissible: false,
      onCancel: () {
        continueCheckingStatus = false; // Stop checking when canceled
        navigateBackToSendPackageScreen('Please Try again later.');
      },
      onConfirm: () {
        navigateBackToHomeScreen('message');
      }
    );
  }

  void showRequestDetailsDialog() {
    Get.toNamed(AppRoutes.trackingDetailsScreen);
  }

  void navigateBackToSendPackageScreen(String message) {
    Get.offNamed(AppRoutes.sendPackageScreen, arguments: {'message': message});
  }

  void navigateBackToHomeScreen(String message) {
    Get.offNamed(AppRoutes.homeContainer1Screen, arguments: {'message': message});
  }

}
