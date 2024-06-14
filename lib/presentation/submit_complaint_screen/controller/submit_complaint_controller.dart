import 'dart:convert';
import 'dart:typed_data';
import 'package:courier_delivery/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
// import 'package:multi_image_picker/multi_image_picker.dart';

import '../../../core/constants/apiConstants.dart';
import '../../../data/userData.dart';

class SubmitComplaintController extends GetxController {
 TextEditingController nameController = TextEditingController();
 TextEditingController addressController = TextEditingController();
 TextEditingController landmarkController = TextEditingController();
 TextEditingController phoneNumberController = TextEditingController();
 TextEditingController problemController = TextEditingController();

 RxList<String> uploadedPhotos = <String>[].obs;
 List<List<int>> imageDataList = [];

 // Future<List<Uint8List>> processImages(List<Asset> images) async {
 //  List<Uint8List> result = [];
 //
 //  for (Asset image in images) {
 //   ByteData byteData = await image.getByteData();
 //   List<int> imageData = byteData.buffer.asUint8List();
 //
 //   imageDataList.add(Uint8List.fromList(imageData));
 //   result.add(Uint8List.fromList(imageData));
 //
 //   print('Complaint submitted successfully: $imageData');
 //  }
 //
 //  return result;
 // }


 Future<void> submitComplaint() async {
  String name = nameController.text;
  String address = addressController.text;
  String landmark = landmarkController.text;
  String phoneNumber = phoneNumberController.text;
  String problem = problemController.text;

  try {
   // Upload selected photos to the server
   await uploadPhotosToServer(imageDataList);

   final response = await http.post(
    Uri.parse(ApiConstants.submitComplaint),
    headers: {
     'Content-Type': 'application/json',
    },
    body: jsonEncode({
     'user_id': UserData.userId,
     'name': name,
     'address': address,
     'landmark': landmark,
     'phone_number': phoneNumber,
     'problem': problem,
     'photos': uploadedPhotos.toList(),
     'date': DateTime.now().toString(),
     'status': 'Pending',
    }),
   );

   if (response.statusCode == 200) {
    print('Complaint submitted successfully');

    Get.offNamed(AppRoutes.complaintSuccessScreen);
    // You might want to handle success feedback or navigation here
   } else {
    print('Error submitting complaint: ${response.statusCode}, ${response.body}');
    // You might want to handle error feedback here
   }
  } catch (error) {
   print('Error: $error');
   // You might want to handle error feedback here
  }
 }

 Future<void> uploadPhotosToServer(List<List<int>> imageDataList) async {
  try {
   for (List<int> imageData in imageDataList) {
    var response = await http.post(
     Uri.parse(ApiConstants.submitComplaint),
     headers: {'Content-Type': 'application/octet-stream'}, // Set appropriate content type for raw data
     body: jsonEncode(Uint8List.fromList(imageData)),
    );

    if (response.statusCode == 200) {
     print('Photo uploaded successfully');
    } else {
     print('Error uploading photo: ${response.statusCode}, ${response.body}');
    }
   }
  } catch (error) {
   print('Error uploading photos to server: $error');
  }
 }


}
