import 'package:get/get.dart';/// This class is used in the [listeye1_item_widget] screen.
class Listeye1ItemModel {Rx<String> homeTxt = Rx("Home");

Rx<String>? id = Rx("");
String? addressTitle;
String? addressline1;
String? addressline2;
String? country;
String? state;
String? city;
String? pinCode;
String? mobileNumber;

Listeye1ItemModel(this.addressTitle, this.addressline1, this.addressline2,
    this.country, this.state, this.city, this.pinCode,this.mobileNumber);
 }
