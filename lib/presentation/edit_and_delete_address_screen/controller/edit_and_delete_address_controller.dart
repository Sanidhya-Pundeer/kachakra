import 'package:courier_delivery/core/app_export.dart';import 'package:courier_delivery/presentation/edit_and_delete_address_screen/models/edit_and_delete_address_model.dart';/// A controller class for the EditAndDeleteAddressScreen.
///
/// This class manages the state of the EditAndDeleteAddressScreen, including the
/// current editAndDeleteAddressModelObj
class EditAndDeleteAddressController extends GetxController {Rx<EditAndDeleteAddressModel> editAndDeleteAddressModelObj = EditAndDeleteAddressModel().obs;

 }
