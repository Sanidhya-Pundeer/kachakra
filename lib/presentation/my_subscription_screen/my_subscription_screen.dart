// Import necessary packages and files
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../data/userData.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_subtitle_1.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import 'controller/my_subscription_controller.dart';
// my_subscription_screen.dart

class MySubscriptionScreen extends StatefulWidget {
  @override
  State<MySubscriptionScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<MySubscriptionScreen> {
  MySubscriptionController controller = Get.put(MySubscriptionController());

  int plan_price = 0;
  int bin_cost = 0;

  @override
  void initState() {
    super.initState();
    controller.fetchSubscriptionDetails();
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
              title: AppbarSubtitle1(text: "My Subscription".tr),
              actions: [],
              styleType: Style.bgFillWhiteA700),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Unlock Premium Features",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Premium Subscription",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.highlighter,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Unlock exclusive features and content",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Family Size:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              UserData.famSize,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Plan Price:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\₹ 300",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  "Per Quarter",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        if (UserData.memberType == 'guest')
                        SizedBox(height: 20),
                        if (UserData.memberType == 'guest')
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Bin Cost:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\₹ 140",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Benefits:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("- Unlimited access to premium content"),
                        Text("- Ad-free experience"),
                        Text("- Exclusive features"),
                        // Add more benefits here if needed
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
          bottomNavigationBar: UserData.memberType == 'guest' ? CustomButton(
            onTap: () {
              Get.toNamed(AppRoutes.paymentMethodScreen);
            },
            height: getVerticalSize(54),
            text: "Pay & Subscribe",
            margin: getMargin(left: 16, right: 16, bottom: 40),
          ) : CustomButton(
            onTap: () {
              Get.toNamed(AppRoutes.paymentMethodScreen);
            },
            height: getVerticalSize(54),
            text: "Renew Subscription",
            margin: getMargin(left: 16, right: 16, bottom: 40),
          ), // if the user is not a guest, render an empty SizedBox

        )
      ),
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
