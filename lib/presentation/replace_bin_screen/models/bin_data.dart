import 'package:courier_delivery/presentation/replace_bin_screen/models/bin_model.dart';

class BinData {
  static List<BinModel> getBinData() {
    return [
      BinModel("assets/images/5L_hbin.png", "red, green", "Polypropylene",
          "23 cms", "5 L", "Hindgreco", "1-2", "Kitchen", "40"),
      BinModel("assets/images/30L_hbin.jpg", "red, green", "Polypropylene",
          "23 cms", "30 L", "Hindgreco", "4-5", "Kitchen", "200"),
      BinModel("assets/images/45L_hbin.jpg", "red, green", "Polypropylene",
          "23 cms", "45 L", "Hindgreco", "4-5", "Kitchen", "200"),
      BinModel(
          "assets/images/8L_hbin.png",
          "red, green",
          "Stainless Steel",
          "8 x 13 inch",
          "8 L",
          "OPR",
          "All",
          "Bathroom, Bedroom, Toilet, Office",
          "350")
    ];
  }
}
