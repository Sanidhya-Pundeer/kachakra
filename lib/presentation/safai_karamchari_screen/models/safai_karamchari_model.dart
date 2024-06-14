import 'package:get/get.dart';
import 'listsignal_item_model.dart';

/// This class defines the variables used in the [select_courier_service_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class SelectCourierServiceModel {
  Rx<List<ListsignalItemModel>> listsignalItemList =
      Rx(List.generate(4, (index) => ListsignalItemModel()));
}
class NearbyKaramchariService {
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String longLat;
  final String userType;
  final String userSubtype;
  final String serviceType;
  final String serviceItems;
  final String serviceTags;
  final String serviceBrands;
  final String otherDetail;
  final String username;
  final String dob;
  final String password;
  final String kycCard;
  final String userStatus;

  NearbyKaramchariService({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.longLat,
    required this.userType,
    required this.userSubtype,
    required this.serviceType,
    required this.serviceItems,
    required this.serviceTags,
    required this.serviceBrands,
    required this.otherDetail,
    required this.username,
    required this.dob,
    required this.password,
    required this.kycCard,
    required this.userStatus,
  });

  factory NearbyKaramchariService.fromJson(Map<String, dynamic> json) {
    try{
    return NearbyKaramchariService(
      userId: json['user_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      longLat: json['long_lat']?.toString() ?? '',
      userType: json['user_type']?.toString() ?? '',
      userSubtype: json['user_subtype']?.toString() ?? '',
      serviceType: json['service_type']?.toString() ?? '',
      serviceItems: json['service_items']?.toString() ?? '',
      serviceTags: json['service_tags']?.toString() ?? '',
      serviceBrands: json['service_brands']?.toString() ?? '',
      otherDetail: json['other_detail']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      dob: json['dob']?.toString() ?? '',
      password: json['password']?.toString() ?? '',
      kycCard: json['kyc_card']?.toString() ?? '',
      userStatus: json['user_status']?.toString() ?? '',
    );
  }
    catch (e) {
      print('Error parsing JSON: $e');
      print('Problematic JSON: $json');
      print('Problematic key: ${json.keys.firstWhere((key) => json[key] == null)}');
      rethrow;
    }
  }


}
