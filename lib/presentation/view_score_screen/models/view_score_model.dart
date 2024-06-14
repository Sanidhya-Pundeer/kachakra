import 'package:get/get.dart';import 'view_score_item_model.dart';/// This class defines the variables used in the [profile_details_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class ViewScoreModel {Rx<List<ViewScoreItemModel>> profileDetailsItemList = Rx(List.generate(3,(index) => ViewScoreItemModel()));

 }
