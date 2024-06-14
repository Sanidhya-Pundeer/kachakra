import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/safai_karamchari_screen/models/safai_karamchari_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/constants/apiConstants.dart';

/// A controller class for the SelectCourierServiceScreen.
///
/// This class manages the state of the SelectCourierServiceScreen, including the
/// current selectCourierServiceModelObj
class SafaiKaramchariController extends GetxController {
  int currentServices = 0;

  void setCurrentCurierServices(int index) {
    currentServices = index;
    update();
  }

  @override
  void onInit() {
    fetchDataFromApi();
    super.onInit();
  }

  List<NearbyKaramchariService> serviceData = [];

  Future<void> fetchDataFromApi() async {
    final apiUrl = ApiConstants.getCleanerService;

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        List<NearbyKaramchariService> services = data.map((item) {
          return NearbyKaramchariService(
            userId: item['user_id']?.toString() ?? '',
            name: item['name']?.toString() ?? '',
            email: item['email']?.toString() ?? '',
            phone: item['phone']?.toString() ?? '',
            address: item['address']?.toString() ?? '',
            longLat: item['long_lat']?.toString() ?? '',
            userType: item['user_type']?.toString() ?? '',
            userSubtype: item['user_subtype']?.toString() ?? '',
            serviceType: item['service_type']?.toString() ?? '',
            serviceItems: item['service_items']?.toString() ?? '',
            serviceTags: item['service_tags']?.toString() ?? '',
            serviceBrands: item['service_brands']?.toString() ?? '',
            otherDetail: item['other_detail']?.toString() ?? '',
            username: item['username']?.toString() ?? '',
            dob: item['dob']?.toString() ?? '',
            password: item['password']?.toString() ?? '',
            kycCard: item['kyc_card']?.toString() ?? '',
            userStatus: item['user_status']?.toString() ?? '',
          );
        }).toList();
        serviceData.assignAll(services);
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      print('Error fetching data: $error');
      print('StackTrace: $stackTrace');
      if (error is http.Response) {
        print('Response body: ${error.body}');
        print('Response status code: ${error.statusCode}');
      } else if (error is FormatException) {
        print('Response body is not valid JSON');
      } else {
        print('Unknown error type: ${error.runtimeType}');
      }
    }finally {
      update(); // Ensure to call update() to notify GetBuilder of state changes
    }
  }

}