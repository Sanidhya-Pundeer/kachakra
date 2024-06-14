import 'package:get/get.dart';import 'repair_service_details_item_model.dart';/// This class defines the variables used in the [profile_details_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class RepairServiceDetailsModel {Rx<List<RepairServiceDetailsItemModel>> profileDetailsItemList = Rx(List.generate(3,(index) => RepairServiceDetailsItemModel()));

 }
