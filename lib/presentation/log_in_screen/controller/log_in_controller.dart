
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/data/mswDriverData.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/constants/apiConstants.dart';
import '../../../data/userData.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class LogInController extends GetxController {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<bool> isShowPassword = true.obs;
  String otpAuthKey = "416825AXDqe0U0iLy65d80d0aP1";

  Future<void> loginUser({required VoidCallback onSuccess}) async {
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final response = await Dio().post(
        ApiConstants.userLogin,
        data: {
          'mobile': phoneNumberController.text,
          'password': passwordController.text,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            // Add any other required headers here
          },
          responseType: ResponseType.json,
          validateStatus: (status) {
            return status! >= 200 && status < 300;
          },
        ),
      );

      Get.back(); // Close the loading dialog

      if (response.statusCode == 200) {
        // Successful login
        final data = json.decode(response.data);

        final userDetails = data['user_details'];

        // Check if 'user_id' is not null and is a valid integer
        if (userDetails.containsKey('user_id') && userDetails['user_id'] is int) {
          UserData.userId = userDetails['user_id'];
          UserData.userAddress = userDetails['address'];
          UserData.userType = userDetails['user_subtype'];
          UserData.famSize = userDetails['other_detail'];
          UserData.memberType = userDetails['member_type'];
          UserData.mswDriverID = userDetails['msw_driver'];
          if (userDetails.containsKey('msw_driver') && userDetails['msw_driver'] is int) {
            await getMswDriver(UserData.mswDriverID);
          }
          onSuccess(); // Call the onSuccess callback for navigation
        } else {
          // Handle invalid 'user_id'
          print('Invalid user_id in the response');
        }

        print('Response Data: ${response.data}');
        onSuccess(); // Call the onSuccess callback for navigation
      } else {
        // Handle other status codes or errors
        print('Server Error: ${response.statusCode}');
        print('Response Data: ${response.data}');
        Get.snackbar(
          'Error',
          'Invalid credentials. Please check your phone and password.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on DioError catch (e) {
      Get.back(); // Close the loading dialog on error
      print('Dio Error: $e');
      Get.snackbar(
        'Error',
        'Invalid credentials. Please check your phone and password.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getMswDriver(int driverID) async {

    try {
      final response = await Dio().post(
        ApiConstants.getUser + driverID.toString(),
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            // Add any other required headers here
          },
          responseType: ResponseType.json,
          validateStatus: (status) {
            return status! >= 200 && status < 300;
          },
        ),
      );

      if (response.statusCode == 200) {
        // Successful login
        final driverDetails = json.decode(response.data);

        // Check if 'user_id' is not null and is a valid integer
              MswDriverData.name = driverDetails['name'];
              MswDriverData.phoneNumber = driverDetails['phone'];
              MswDriverData.vehicleNumber = driverDetails['other_detail'];

        List<String> latLongStr = driverDetails['long_lat'].split('\,');

        String latitudeStr = latLongStr[0];
        String longitudeStr = latLongStr[1];

        double latitude = double.parse(latitudeStr);
        double longitude = double.parse(longitudeStr);

              MswDriverData.currentLocation = Position(
                latitude: latitude,
                longitude: longitude,
                accuracy: 0.0,
                altitude: 0.0, // Providing default value for altitude
                heading: 0.0, // Providing default value for heading
                speed: 0.0, // Providing default value for speed
                speedAccuracy: 0.0, // Providing default value for speedAccuracy
                timestamp: DateTime.now(), // Providing default value for timestamp
              ); // Call the onSuccess callback for navigation

        print('Response Data: ${response.data}');
      } else {
        // Handle other status codes or errors
        print('Server Error: ${response.statusCode}');
        print('Response Data: ${response.data}');
      }
    } on DioError catch (e) {
      Get.back(); // Close the loading dialog on error
      print('Dio Error: $e');

    }
  }

  onTapSendOTP() async {
    if (_formKey.currentState!.validate()) {
      String phoneNumber = phoneNumberController.text;

      try {
        final response = await http.post(
          Uri.parse("https://control.msg91.com/api/v5/otp?mobile=" + phoneNumber),
          headers: {
            'Content-Type': 'application/json',
            'authkey': otpAuthKey,
            'accept': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          // Successful response, update UI state
          phoneNumberController.clear();
          Fluttertoast.showToast(msg: "OTP sent successfully");
        } else {
          // Handle error and show toast
          Fluttertoast.showToast(
              msg: "Error: ${response.statusCode}, ${response.body}");
        }
      } catch (error) {
        // Handle network or other errors, and show toast
        Fluttertoast.showToast(msg: "Error: $error");
      }
    }
  }

  onTapSubmitOTP() async {
    if (_formKey.currentState!.validate()) {
      String phoneNumber = phoneNumberController.text;
      String otp = otpController.text;

      try {
        final response = await http.post(
          Uri.parse("https://control.msg91.com/api/v5/otp/verify?mobile=" + phoneNumber + "&otp=" + otp),
          headers: {
            'Content-Type': 'application/json',
            'authKey': otpAuthKey,
            'accept': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          Fluttertoast.showToast(msg: "Successfully Verified");

          await loginUser(onSuccess: () {

          });
          // Successful response, navigate to another screen
          Get.toNamed(AppRoutes.homeContainer1Screen);
        } else {
          //Get.toNamed(AppRoutes.homeContainer1Screen);
          // Handle error and show toast
          Fluttertoast.showToast(
              msg: "Error: ${response.statusCode}, ${response.body}");
        }
      } catch (error) {
        // Handle network or other errors, and show toast
        Fluttertoast.showToast(msg: "Error: $error");

      }

    }
  }

}

