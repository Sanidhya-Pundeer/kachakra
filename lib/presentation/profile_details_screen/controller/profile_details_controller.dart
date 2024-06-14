import 'package:courier_delivery/core/app_export.dart';
/// A controller class for the ProfileDetailsScreen.
///
/// This class manages the state of the ProfileDetailsScreen, including the
/// current profileDetailsModelObj
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/constants/apiConstants.dart';
import '../../../data/userData.dart';
import '../models/profile_details_item_model.dart';

class ProfileDetailsController extends GetxController {
 Rx<List<ProfileDetailsItemModel>> profileDetailsItemList =
 Rx(List.generate(1, (index) => ProfileDetailsItemModel()));

 int userId = UserData.userId;

 Future<void> fetchProfileDetails() async {
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
