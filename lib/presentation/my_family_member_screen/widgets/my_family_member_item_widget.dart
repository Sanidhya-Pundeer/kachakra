import '../controller/my_family_member_controller.dart';
import '../models/my_family_member_item_model.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyFamilyMemberItemWidget extends StatelessWidget {
  MyFamilyMemberItemWidget(
    this.myAddressItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  MyFamilyMemberItemModel myAddressItemModelObj;

  var controller = Get.find<MyFamilyMemberController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(
        left: 16,
        top: 15,
        right: 16,
        bottom: 15,
      ),
      decoration: AppDecoration.fillGray50.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconButton(
            height: 33,
            width: 34,
            margin: getMargin(
              bottom: 42,
            ),
            child: CustomImageView(
              svgPath: ImageConstant.imgEye,
            ),
          ),
          Padding(
            padding: getPadding(
              left: 16,
              top: 3,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    myAddressItemModelObj.homeTxt.value,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtHeadline,
                  ),
                ),
                Container(
                  width: getHorizontalSize(
                    241,
                  ),
                  margin: getMargin(
                    top: 7,
                  ),
                  child: Text(
                    "msg_4140_parker_rd".tr,
                    maxLines: null,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtBody,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          CustomImageView(
            svgPath: ImageConstant.imgOverflowmenu,
            height: getSize(
              20,
            ),
            width: getSize(
              20,
            ),
            margin: getMargin(
              bottom: 56,
            ),
          ),
        ],
      ),
    );
  }
}
