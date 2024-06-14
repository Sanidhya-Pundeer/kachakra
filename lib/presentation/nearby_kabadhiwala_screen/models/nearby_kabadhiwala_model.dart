import 'package:get/get.dart';import 'kabadhiwala_item_model.dart';/// This class defines the variables used in the [courier_services_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class NearbyKabadhiwalaModel {Rx<List<KabadhiwalaItemModel>> courierItemList = Rx(List.generate(5,(index) => KabadhiwalaItemModel()));

 }
