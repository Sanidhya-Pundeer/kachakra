import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/my_subscription_screen/models/my_subscription_item_model.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/constants/apiConstants.dart';
import '../../../data/userData.dart';

class MySubscriptionController extends GetxController {
 Rx<List<ProfileDetailsItemModel>> profileDetailsItemList =
 Rx(List.generate(1, (index) => ProfileDetailsItemModel()));

 int userId = UserData.userId;

 Future<void> fetchSubscriptionDetails() async {
  try {
   final response = await http.get(
       Uri.parse(ApiConstants.getUser + userId.toString()));

   if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);

    profileDetailsItemList.update((val) {
     val?[0].nameTxt.value = "Name";
     val?[0].namevalueTxt.value = jsonData["name"] ?? "";
     val?[0].emailvalueTxt.value = jsonData["email"] ?? "";
     val?[0].numbervalueTxt.value = jsonData["phone"] ?? "";
     val?[0].addressvalueTxt.value = jsonData["address"] ?? "";
     val?[0].usernamevalueTxt.value = jsonData["password"] ?? "";
     val?[0].id.value = jsonData["id"] ?? "";
     // Add more fields as needed (email, phone number, address)
    });
   } else {
    throw Exception("Failed to load profile details");
   }
  } catch (e) {
   print("Error fetching data: $e");
  }
 }
}
