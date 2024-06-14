import 'package:courier_delivery/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../home_container_page/models/select_nearby_kabadhiwala_model.dart';
import '../controller/select_nearby_kabadhiwala_controller.dart';

// ignore: must_be_immutable
class ListsignalItemWidget extends StatelessWidget {
  ListsignalItemWidget(
    this.listsignalItemModelObj,
    this.index, {
    Key? key,
  }) : super(
          key: key,
        );

  NearbyKabadhiwala listsignalItemModelObj;
  int index;

  SelectNearbyKabadhiwalaController selectCourierServiceController =
      Get.put(SelectNearbyKabadhiwalaController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectNearbyKabadhiwalaController>(
      init: SelectNearbyKabadhiwalaController(),
      builder: (controller) => SizedBox(
        width: double.maxFinite,
        child: GestureDetector(
          onTap: () {
            controller.setCurrentCurierServices(index);
          },
          child: Container(
            padding: getPadding(
              all: 0,
            ),
            decoration: controller.currentServices == index
                ? AppDecoration.outlineDeeppurple600.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder16,
                  )
                : AppDecoration.fillGray50.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder16,
                  ),
            child: Padding(
              padding: getPadding(left: 16, right: 16, bottom: 16, top: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomImageView(
                        svgPath: listsignalItemModelObj.icon,
                        height: getVerticalSize(
                          20,
                        ),
                        width: getHorizontalSize(
                          65,
                        ),
                        margin: getMargin(
                          top: 10,
                          bottom: 9,
                        ),
                      ),
                      CircularPercentIndicator(
                        radius: 20.0,
                        lineWidth: 2.0,
                        percent:
                            (double.parse(listsignalItemModelObj.rating!) * 2) /
                                10,
                        center: Text(
                          listsignalItemModelObj.rating!,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtFootnote,
                        ),
                        progressColor: ColorConstant.amber500,
                      )
                    ],
                  ),
                  Padding(
                    padding: getPadding(
                      top: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listsignalItemModelObj.subtitle!,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtBody,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: getPadding(
                            bottom: 1,
                          ),
                          child: Text(
                            listsignalItemModelObj.discription!,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: getPadding(
                            top: 1,
                          ),
                          child: Text(
                            "esstimated charges".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtBody,
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            bottom: 1,
                          ),
                          child: Text(
                            listsignalItemModelObj.charges!,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
