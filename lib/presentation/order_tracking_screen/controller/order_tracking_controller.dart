import 'package:courier_delivery/data/userData.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/constants/apiConstants.dart';
import '../models/order_tracking_model.dart';

class OrderTrackingController extends GetxController {
  RxList<OrderTrackingModel> orderTrackingModelObj = <OrderTrackingModel>[].obs;
  final apiUrl = ApiConstants.getRequestByID;

  @override
  void onInit() {
    // Fetch data from the API when the controller is initialized
    fetchDataFromApi();
    super.onInit();
    update();
  }

  Future<void> fetchDataFromApi() async {
    try {
      final response = await http.get(Uri.parse(apiUrl + UserData.userId.toString()));
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is List) {
          // If the response is a list, map each item to OrderTrackingModel
          final List<OrderTrackingModel> data = responseData
              .map((json) => OrderTrackingModel.fromJson(json))
              .toList();

          // Update the observable list with the fetched data
          orderTrackingModelObj.assignAll(data);
          print('Unexpected response format ${response.body}');

        } else if (responseData is Map<String, dynamic>) {
          // If the response is a single object, create a list with one item
          final List<OrderTrackingModel> data = [
            OrderTrackingModel.fromJson(responseData),
          ];

          // Update the observable list with the fetched data
          orderTrackingModelObj.assignAll(data);

        } else {
          // Handle other cases if needed
          print('Unexpected response format');
        }
      } else {
        // Handle errors, e.g., show an error message
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors
      print('Error fetching data: $e');
    }
  }

}
