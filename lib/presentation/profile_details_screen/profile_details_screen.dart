// Import necessary packages and files
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_subtitle_1.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'controller/profile_details_controller.dart';
import 'models/profile_details_item_model.dart';
// profile_details_screen.dart

class ProfileDetailsScreen extends StatefulWidget {
  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  ProfileDetailsController controller = Get.put(ProfileDetailsController());

  @override
  void initState() {
    super.initState();
    controller.fetchProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: ColorfulSafeArea(
      color: ColorConstant.whiteA700,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                  onTapArrowleft22();
                }),
            centerTitle: true,
            title: AppbarSubtitle1(text: "lbl_profile".tr),
            actions: [
              // AppbarImage(
              //     height: getSize(24),
              //     width: getSize(24),
              //     svgPath: ImageConstant.imgTicket,
              //     margin: getMargin(
              //         left: 16, top: 29, right: 16, bottom: 26),
              //     onTap: () {
              //       onTapTicket();
              //     })
            ],
            styleType: Style.bgFillWhiteA700),
        body: Obx(
              () => ListView(
            padding: EdgeInsets.all(16),
            children: [
              profileDetail(controller.profileDetailsItemList.value[0]),
            ],
          ),
        ),
      ),
      ),

    );
  }

  Widget profileDetail(ProfileDetailsItemModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 110,
            width: 110,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/img_ellipse240.jpg"), // Add your profile image
                  radius: 55,
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Handle profile image editing
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.person, size: 24),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.namevalueTxt.value,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Divider(height: 1, thickness: 1, color: Colors.grey[200]),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.mail, size: 24),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.emailvalueTxt.value,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Divider(height: 1, thickness: 1, color: Colors.grey[200]),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.phone, size: 24),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phone Number",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.numbervalueTxt.value,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(height: 1, thickness: 1, color: Colors.grey[200]),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.home, size: 24),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.addressvalueTxt.value,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(height: 1, thickness: 1, color: Colors.grey[200]),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.verified_user, size: 24),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Username",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.usernamevalueTxt.value,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Divider(height: 1, thickness: 1, color: Colors.grey[200]),
        // Add more rows for additional fields like address
      ],
    );
  }

  void onTapArrowleft22() {
    // Implement the logic when the arrow left is tapped
    Get.back();
  }

  void onTapTicket() {
    // Implement the logic when the ticket icon is tapped
    Get.toNamed(AppRoutes.editProfileScreen);
  }


}
