import 'package:courier_delivery/core/app_export.dart';
import 'package:flutter/material.dart';

import '../controller/safai_karamchari_controller.dart';
import '../models/safai_karamchari_model.dart';

// ignore: must_be_immutable
class ListsignalItemWidget extends StatelessWidget {
  ListsignalItemWidget(
    this.listsignalItemModelObj,
    this.index, {
    Key? key,
  }) : super(
          key: key,
        );

  NearbyKaramchariService listsignalItemModelObj;
  int index;

  SafaiKaramchariController selectCourierServiceController =
      Get.put(SafaiKaramchariController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SafaiKaramchariController>(
      init: SafaiKaramchariController(),
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
                        imagePath: ImageConstant.imgEllipse24,
                        height: getVerticalSize(
                          50,
                        ),
                        width: getHorizontalSize(
                          50,
                        ),
                        margin: getMargin(
                          top: 10,
                          bottom: 9,
                        ),
                      ),
                      Text( "DOB:\n" +
                          listsignalItemModelObj.dob,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtSFProTextRegular14,
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
                          listsignalItemModelObj.name,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: ColorConstant.primaryAqua,
                            fontSize: getFontSize(
                              18,
                            ),
                            fontFamily: 'SF Pro Text',
                            fontWeight: FontWeight.w700,
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
                            bottom: 1,
                          ),
                          child: Text("Phone Number: " +
                            listsignalItemModelObj.phone,
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
                            "Address".tr,
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
                            listsignalItemModelObj.address,
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
