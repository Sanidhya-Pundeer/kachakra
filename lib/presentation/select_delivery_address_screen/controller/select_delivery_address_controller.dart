import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/select_delivery_address_screen/models/select_delivery_address_model.dart';

import '../models/listeye1_item_model.dart';

/// A controller class for the SelectDeliveryAddressScreen.
///
/// This class manages the state of the SelectDeliveryAddressScreen, including the
/// current selectDeliveryAddressModelObj
class SelectDeliveryAddressController extends GetxController {
  List<Listeye1ItemModel> deliveryAddressData =
      SelectDeliveryAddressModel.listeye1ItemList();

  List<Listeye1ItemModel> familyMemberData =
  SelectDeliveryAddressModel.listeye2ItemList();

  int currentAddress = 0;
  void setCurrentAddreddIndex(int index) {
    currentAddress = index;
    update();
  }
}
