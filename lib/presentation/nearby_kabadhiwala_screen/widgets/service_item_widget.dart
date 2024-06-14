import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/home_container_page/models/nearby_kabadhiwala_model.dart';
import 'package:flutter/material.dart';

import '../controller/nearby_kabadhiwala_controller.dart';

// ignore: must_be_immutable
class ServiceItemWidget extends StatelessWidget {
  ServiceItemWidget(
    this.courierItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  NearbyKabadhiwala courierItemModelObj;

  var controller = Get.find<NearbyKabadhiwalaController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Container(
        padding: getPadding(
          left: 16,
          top: 15,
          right: 16,
          bottom: 15,
        ),
        decoration: AppDecoration.fillGray50.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomImageView(
                  svgPath: courierItemModelObj.icon,
                  height: getVerticalSize(
                    20,
                  ),
                  width: getHorizontalSize(
                    65,
                  ),
                ),
                Spacer(),
                CustomImageView(
                  svgPath: ImageConstant.imgStar,
                  height: getSize(
                    14,
                  ),
                  width: getSize(
                    14,
                  ),
                  margin: getMargin(
                    top: 4,
                    bottom: 2,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 4,
                    top: 3,
                  ),
                  child: Text(
                    courierItemModelObj.rating!,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtFootnote,
                  ),
                ),
              ],
            ),
            Container(
              width: getHorizontalSize(
                348,
              ),
              margin: getMargin(
                top: 18,
                right: 15,
              ),
              child: Text(
                courierItemModelObj.discription!,
                maxLines: null,
                textAlign: TextAlign.left,
                style: AppStyle.txtBody,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
