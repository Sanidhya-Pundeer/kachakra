import 'package:courier_delivery/core/app_export.dart';

import 'slidertrackyour_item_model.dart';

/// This class defines the variables used in the [onboarding_one_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class OnboardingOneModel {
  // Rx<List<SlidertrackyourItemModel>> slidertrackyourItemList =
  //     Rx(List.generate(1, (index) => SlidertrackyourItemModel()));

  static List<SlidertrackyourItemModel> slidertrackyourItemList() {
    return [
      SlidertrackyourItemModel(
          ImageConstant.imgOnboarding1st,
          "",
          ""),
      SlidertrackyourItemModel(
          ImageConstant.imgOnboarding2nd,
          "",
          ""),
      SlidertrackyourItemModel(
          ImageConstant.imgOnboarding4th,
          "",
          ""),
    ];
  }
}
