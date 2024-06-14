import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_image.dart';
import 'package:courier_delivery/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:courier_delivery/widgets/app_bar/custom_app_bar.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../select_delivery_address_screen/controller/select_delivery_address_controller.dart';
import '../select_delivery_address_screen/models/listeye1_item_model.dart';
import '../select_delivery_address_screen/widgets/listeye1_item_widget.dart';
import 'controller/my_family_member_controller.dart';

class MyFamilyMemberScreen extends GetWidget<MyFamilyMemberController> {
  const MyFamilyMemberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(79),
                leadingWidth: 42,
                leading: AppbarImage(
                    height: getSize(24),
                    width: getSize(24),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 18, top: 29, bottom: 26),
                    onTap: () {
                      onTapArrowleft29();
                    }),
                centerTitle: true,
                title: AppbarSubtitle1(text: "My Family".tr),
                styleType: Style.bgFillWhiteA700),
            body: GetBuilder<SelectDeliveryAddressController>(
              init: SelectDeliveryAddressController(),
              builder: (controller) => Container(
                  width: double.maxFinite,
                  padding: getPadding(left: 16, top: 19, right: 16, bottom: 19),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Members added".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtSFProTextBold20),
                        Expanded(
                            child: Padding(
                                padding: getPadding(top: 20),
                                child: ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                          height: getVerticalSize(16));
                                    },
                                    itemCount:
                                        controller.familyMemberData.length,
                                    itemBuilder: (context, index) {
                                      Listeye1ItemModel model =
                                          controller.familyMemberData[index];
                                      return Listeye1ItemWidget(model, index,
                                          onTapAddress: () {});
                                    })))
                      ])),
            ),
            bottomNavigationBar: CustomButton(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.addAddressScreen,
                  );
                },
                height: getVerticalSize(54),
                text: "Add Members".tr,
                margin: getMargin(left: 16, right: 16, bottom: 40))));
  }

  onTapArrowleft29() {
    Get.back();
  }
}
