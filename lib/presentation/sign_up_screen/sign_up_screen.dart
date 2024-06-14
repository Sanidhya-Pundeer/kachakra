import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/core/utils/validation_functions.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:courier_delivery/widgets/custom_floating_edit_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controller/sign_up_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignUpController controller = Get.put(SignUpController());

  List<String> items = [
    'Household',
    'Hotels',
    'Shops / Malls',
    'Hospital',
    'Industrial',
    'Others'
  ];

  String? selectedItem;

  List<String> familySize = ['1-4', '5-6', 'more than 6'];

  String? selectedFamilySize;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: ColorConstant.whiteA700,
          statusBarIconBrightness: Brightness.dark),
    );
    super.initState();
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
                body: Form(
                    key: _formKey,
                    child: Container(
                        width: double.maxFinite,
                        padding: getPadding(
                            left: 16, top: 41, right: 16, bottom: 41),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: getPadding(top: 5),
                                  child: Text("lbl_sign_up2".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtSFProTextBold28)),
                              Padding(
                                  padding: getPadding(top: 22),
                                  child: Text("msg_join_the_community".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtBody)),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    DropdownButton<String>(
                                      isExpanded: true,
                                      value: selectedItem,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedItem = newValue;
                                        });
                                      },
                                      items: [
                                        DropdownMenuItem(
                                          value: null,
                                          child: Text(
                                              'Describe yourself!'), // Placeholder text
                                        ),
                                        ...items.map((String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 2,
                                                    height: 20,
                                                    color: Color(0xFF03BB85),
                                                    margin: EdgeInsets.only(
                                                        right: 8),
                                                  ),
                                                  Text(item),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ],
                                      underline: Container(),
                                      style: AppStyle.txtAvenirRegular16,
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: ColorConstant.primaryAqua,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ],
                                ),
                              ),
                              if (selectedItem == 'Others')
                                CustomFloatingEditText(
                                    labelText:
                                        "Please Explain the nature of your organisation."
                                            .tr,
                                    hintText: "Type here...".tr,
                                    margin: getMargin(top: 16),
                                    prefixConstraints: BoxConstraints(
                                        maxHeight: getSize(54),
                                        minHeight: getSize(54)),
                                    textInputType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter valid name";
                                      }
                                      return null;
                                    }),
                              if (selectedItem == 'Household')
                                Container(
                                  margin: getMargin(top: 16),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      DropdownButton<String>(
                                        isExpanded: true,
                                        value: selectedFamilySize,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedFamilySize = newValue;
                                          });
                                        },
                                        items: [
                                          DropdownMenuItem(
                                            value: null,
                                            child: Text(
                                                'Select Family Size!'), // Placeholder text
                                          ),
                                          ...familySize.map((String item) {
                                            return DropdownMenuItem<String>(
                                              value: item,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 2,
                                                      height: 20,
                                                      color: Color(0xFF03BB85),
                                                      margin: EdgeInsets.only(
                                                          right: 8),
                                                    ),
                                                    Text(item),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ],
                                        underline: Container(),
                                        style: AppStyle.txtAvenirRegular16,
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: ColorConstant.primaryAqua,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ],
                                  ),
                                ),
                              CustomFloatingEditText(
                                  controller: controller.nameController,
                                  labelText: "lbl_name".tr,
                                  hintText: "lbl_name".tr,
                                  margin: getMargin(top: 16),
                                  prefixConstraints: BoxConstraints(
                                      maxHeight: getSize(54),
                                      minHeight: getSize(54)),
                                  textInputType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter valid name";
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                height: getVerticalSize(16),
                              ),
                              phone_number_field(
                                  controller.phoneNumberController, (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return "Enter valid number";
                                }
                                return null;
                              }),
                              CustomFloatingEditText(
                                  controller: controller.emailController,
                                  labelText:
                                      "lbl_email_address".tr + " (Optional)",
                                  hintText:
                                      "lbl_email_address".tr + " (Optional)",
                                  margin: getMargin(top: 16),
                                  prefixConstraints: BoxConstraints(
                                      maxHeight: getSize(54),
                                      minHeight: getSize(54)),
                                  textInputType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (!isValidEmail(value,
                                        isRequired: false)) {
                                      return "Please enter valid email";
                                    }
                                    return null;
                                  }),
                              Obx(
                                () => CustomFloatingEditText(
                                  controller: controller.passwordController,
                                  labelText: "lbl_password".tr,
                                  hintText: "lbl_password".tr,
                                  margin: getMargin(top: 16),
                                  prefixConstraints: BoxConstraints(
                                    maxHeight: getSize(54),
                                    minHeight: getSize(54),
                                  ),
                                  isObscureText:
                                      controller.isShowPassword.value,
                                  textInputType: TextInputType.emailAddress,
                                  suffix: InkWell(
                                    onTap: () {
                                      controller.isShowPassword.value =
                                          !controller.isShowPassword.value;
                                    },
                                    child: Container(
                                      margin: getMargin(left: 16, right: 16),
                                      child: CustomImageView(
                                        svgPath: controller.isShowPassword.value
                                            ? ImageConstant.imgIcPasswordStoke
                                            : ImageConstant.imgIcPasswordStoke,
                                      ),
                                    ),
                                  ),
                                  suffixConstraints: BoxConstraints(
                                    maxHeight: getVerticalSize(63),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter valid password";
                                    } else if (value.length < 8) {
                                      return "Password must be at least 8 characters long";
                                    } else if (!RegExp(
                                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)')
                                        .hasMatch(value)) {
                                      return "Password must contain at least\n one lowercase letter,\n one uppercase letter,\n one number";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              CustomButton(
                                  height: getVerticalSize(54),
                                  text: "lbl_sign_up2".tr,
                                  margin: getMargin(top: 30),
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      onTapSignup();
                                    }
                                  }),
                              Padding(
                                  padding: getPadding(top: 19),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [])),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    onTapTxtAlreadyhavean();
                                  },
                                  child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: "msg_already_have_an2".tr,
                                            style: TextStyle(
                                                color: ColorConstant.black900,
                                                fontSize: getFontSize(16),
                                                fontFamily: 'SF Pro Text',
                                                fontWeight: FontWeight.w400)),
                                        TextSpan(
                                            text: "lbl_sign_in".tr,
                                            style: TextStyle(
                                                color:
                                                    ColorConstant.deepPurple600,
                                                fontSize: getFontSize(16),
                                                fontFamily: 'SF Pro Text',
                                                fontWeight: FontWeight.w400))
                                      ]),
                                      textAlign: TextAlign.left))
                            ]))))));
  }

  onTapSignup() {
    Get.toNamed(
      AppRoutes.citySelectionScreen,
    );
  }

  onTapGoogle() {
    Get.toNamed(
      AppRoutes.citySelectionScreen,
    );
  }

  onTapApple() {
    Get.toNamed(
      AppRoutes.citySelectionScreen,
    );
  }

  onTapTxtAlreadyhavean() {
    Get.back();
  }
}
