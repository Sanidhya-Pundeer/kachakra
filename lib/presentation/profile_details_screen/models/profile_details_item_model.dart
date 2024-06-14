import 'package:get/get.dart';/// This class is used in the [profile_details_item_widget] screen.

/// This class is used in the [profile_details_item_widget] screen.
class ProfileDetailsItemModel {
 Rx<String> nameTxt = Rx("Name");
 Rx<String> namevalueTxt = Rx("Ronald richards");
 Rx<String> emailvalueTxt = Rx("Ronald richards");
 Rx<String> numbervalueTxt = Rx("Ronald richards");
 Rx<String> addressvalueTxt = Rx("Ronald richards");
 Rx<String> usernamevalueTxt = Rx("Ronald richards");
 Rx<String> id = Rx("");

 ProfileDetailsItemModel({
  String nameTxtValue = "Name",
  String namevalueTxtValue = "Ronald richards",
  String emailvalueTxtValue = "Ronald richards",
  String numbervalueTxtValue = "Ronald richards",
  String addressvalueTxtValue = "Ronald richards",
  String usernamevalueTxtValue = "Ronald richards",
  String idValue = "",
 }) {
  nameTxt.value = nameTxtValue;
  namevalueTxt.value = namevalueTxtValue;
  emailvalueTxt.value = emailvalueTxtValue;
  numbervalueTxt.value = numbervalueTxtValue;
  addressvalueTxt.value = addressvalueTxtValue;
  usernamevalueTxt.value = usernamevalueTxtValue;
  id.value = idValue;
 }
}


