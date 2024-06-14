import '../controller/view_score_controller.dart';
import '../models/view_score_item_model.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewScoreItemWidget extends StatelessWidget {
  ViewScoreItemWidget(
    this.profileDetailsItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  ViewScoreItemModel profileDetailsItemModelObj;

  var controller = Get.find<ViewScoreController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
          svgPath: ImageConstant.imgUser,
          height: getSize(
            24,
          ),
          width: getSize(
            24,
          ),
          margin: getMargin(
            bottom: 30,
          ),
        ),
        Expanded(
          child: Padding(
            padding: getPadding(
              left: 16,
              top: 1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    profileDetailsItemModelObj.nameTxt.value,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtBodyGray600,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 12,
                  ),
                  child: Obx(
                    () => Text(
                      profileDetailsItemModelObj.namevalueTxt.value,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtBody,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
