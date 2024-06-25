import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/core/utils/validation_functions.dart';
import 'package:courier_delivery/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/custom_floating_edit_text.dart';
import 'controller/log_in_controller.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  LogInController controller = Get.put(LogInController());
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loginViaOTP = false;
  bool _otpSuccess = false;
  List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());
  SharedPreferences? _prefs;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorConstant.whiteA700,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        closeApp();
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
              padding: getPadding(left: 16, top: 41, right: 16, bottom: 41),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: getPadding(top: 5),
                    child: Text(
                      !_loginViaOTP ? "lbl_log_in".tr : "Login via OTP",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtSFProTextBold28,
                    ),
                  ),
                  Padding(
                    padding: getPadding(top: 22),
                    child: Text(
                      "msg_welcome_back_let_s".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtBody,
                    ),
                  ),
                  SizedBox(height: 22),
                  phone_number_field(controller.phoneNumberController, (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "Enter valid number";
                    }
                    return null;
                  }),
                  if (!_loginViaOTP)
                    Obx(
                      () => CustomFloatingEditText(
                        controller: controller.passwordController,
                        labelText: "lbl_password".tr,
                        hintText: "lbl_password".tr,
                        margin: getMargin(top: 24),
                        prefixConstraints: BoxConstraints(
                          maxHeight: getSize(54),
                          minHeight: getSize(54),
                        ),
                        isObscureText: controller.isShowPassword.value,
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
                            return "Please enter 8 digit password";
                          }
                          return null;
                        },
                      ),
                    ),
                  if (_otpSuccess)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(
                                4,
                                (index) => SizedBox(
                                  width: 50,
                                  child: TextField(
                                    controller: controllers[index],
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    decoration: InputDecoration(
                                      counter: Offstage(),
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      if (value.isNotEmpty && index < 3) {
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if (!_loginViaOTP) {
                          onTapTxtForgotpassword();
                        } else {
                          // Send OTP logic
                        }
                      },
                      child: Padding(
                        padding: getPadding(top: 16),
                        child: Text(
                          !_loginViaOTP
                              ? "msg_forgot_password".tr
                              : "Resend OTP",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtBody,
                        ),
                      ),
                    ),
                  ),
                  CustomButton(
                    height: getVerticalSize(54),
                    text: _loginViaOTP
                        ? (_otpSuccess ? "Submit OTP" : "Send OTP")
                        : "lbl_log_in".tr,
                    margin: getMargin(top: 31),
                    onTap: () {
                      if (!_loginViaOTP) {
                        if (_formKey.currentState!.validate()) {
                          controller.loginUser(
                            onSuccess: () {
                              onTapLogin();
                            },
                          );
                        }
                      } else {
                        if (_otpSuccess) {
                          // Send OTP logic
                          // controller.onTapSendOTP();
                        } else {
                          setState(() {
                            _otpSuccess = true;
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "or",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                      fontSize: 18,
                    ),
                  ),
                  CustomButton(
                    variant: ButtonVariant.OutlineDeeppurple600,
                    fontStyle: ButtonFontStyle.SFProTextBold15,
                    height: getVerticalSize(54),
                    text: !_loginViaOTP
                        ? "Login via OTP"
                        : "Login with Password".tr,
                    margin: getMargin(top: 20),
                    onTap: () {
                      if (!_loginViaOTP) {
                        setState(() {
                          _loginViaOTP = true;
                        });
                      } else {
                        setState(() {
                          _loginViaOTP = false;
                          _otpSuccess = false;
                        });
                      }
                    },
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      onTapTxtDonthaveanaccount();
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "msg_don_t_have_an_account2".tr,
                            style: TextStyle(
                              color: ColorConstant.black900,
                              fontSize: getFontSize(16),
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: "lbl_sign_up".tr,
                            style: TextStyle(
                              color: ColorConstant.deepPurple600,
                              fontSize: getFontSize(16),
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
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

  onTapTxtForgotpassword() {
    Get.toNamed(
      AppRoutes.forgotPasswordScreen,
    );
  }

  onTapLogin() async {
    await _prefs?.setString(
        'phoneNumber', controller.phoneNumberController.text.toString() ?? '');
    await _prefs?.setString(
        'password', controller.passwordController.text.toString() ?? '');
    String phone = _prefs?.getString('phoneNumber') ?? '';
    print("Phone Number check: ${phone}");
    Get.toNamed(
      AppRoutes.homeContainer1Screen,
    );
  }

  onTapTxtDonthaveanaccount() {
    Get.toNamed(
      AppRoutes.signUpScreen,
    );
  }
}
