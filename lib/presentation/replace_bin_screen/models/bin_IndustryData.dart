import 'package:courier_delivery/presentation/replace_bin_screen/models/bin_IndustryModel.dart';

class IndustryData {
  static List<Bin_IndustryModel> getBinData() {
    return [
      Bin_IndustryModel("assets/images/200L_bin.png", "black", "Mild Steel",
          "20 x 48 inch", "200 L", "Hindgreco", "outdoors", "500"),
      Bin_IndustryModel("assets/images/660L_bin.jpg", "blue", "HDPE",
          "85 x 90 x 86 cms", "660 L", "Ultima", "outdoors", "17500"),
      Bin_IndustryModel("assets/images/1100L_bin.jpg", "blue", "HDPE",
          "103 x 105 x 100 cms", "1100 L", "Ultima", "outdoors", "21500"),
    ];
  }
}
