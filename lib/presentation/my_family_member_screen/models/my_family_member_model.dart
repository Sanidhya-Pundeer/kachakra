import 'package:get/get.dart';import 'my_family_member_item_model.dart';/// This class defines the variables used in the [my_address_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class MyFamilyMemberModel {Rx<List<MyFamilyMemberItemModel>> myAddressItemList = Rx(List.generate(3,(index) => MyFamilyMemberItemModel()));

 }
