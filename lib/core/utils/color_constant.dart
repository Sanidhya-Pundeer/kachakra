import 'dart:async';
import 'package:courier_delivery/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../phone_field/intl_phone_field.dart';
import '../phone_field/phone_number.dart';

class ColorConstant {
  static Color gray600 = fromHex('#6b6b6b');

  static Color black9007e = fromHex('#7e000000');

  static Color primaryAqua = fromHex('#03BB85');

  static Color blueGray100 = fromHex('#d9d9d9');

  static Color red700 = fromHex('#d83636');

  static Color blue700 = fromHex('#307dc7');

  static Color blueGray400 = fromHex('#888888');

  static Color amber500 = fromHex('#ffc107');

  static Color amber700 = fromHex('#e1a200');

  static Color deepPurple60075 = fromHex('#191a19');

  static Color deepPurple600 = fromHex('#191a19');

  static Color gray200 = fromHex('#f0f0f0');

  static Color gray300 = fromHex('#e4e4e4');

  static Color gray50 = fromHex('#f8f8f8');

  static Color blue50 = fromHex('#d4e4ff');

  static Color deepPurple50 = fromHex('#f3ebff');

  static Color greenA700 = fromHex('#04b155');

  static Color black900 = fromHex('#000000');

  static Color whiteA700 = fromHex('#ffffff');

  static Color gray8004c = fromHex('#4c3c3c43');

  static Color cyan400 = fromHex('#30acc7');

  static Color red = fromHex('#D93636');

  static Color highlighter = fromHex('#a94177');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

closeApp() {
  Future.delayed(const Duration(milliseconds: 1000), () {
    SystemNavigator.pop();
  });
}

Widget phone_number_field(
    controller,
    FutureOr<String?> Function(String?)? validator,
    ) {
  return IntlPhoneField(
    controller: controller,
    disableLengthCheck: true,
    showCountryFlag: false,
    showDropdownIcon: false,
    flagsButtonMargin: EdgeInsets.only(left: 16, top: 17, bottom: 17, right: 14),
    style: TextStyle(
      color: ColorConstant.black900,
      fontSize: getFontSize(16),
      fontFamily: 'SF Pro Text',
      fontWeight: FontWeight.w400,
    ),
    dropdownTextStyle: TextStyle(
      color: ColorConstant.black900,
      fontSize: getFontSize(16),
      fontFamily: 'SF Pro Text',
      fontWeight: FontWeight.w400,
    ),
    cursorColor: ColorConstant.deepPurple600,
    dropdownIconPosition: IconPosition.trailing,
    dropdownDecoration: BoxDecoration(),
    validator: (PhoneNumber? p0) {
      if (p0 == null || p0.number.isEmpty || p0.number.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(p0.number)) {
        return "Please enter a valid 10-digit phone number";
      }
      return validator?.call(p0.number);
    },
    decoration: InputDecoration(
      floatingLabelStyle: TextStyle(
        color: ColorConstant.black900,
        fontSize: getFontSize(13),
        fontFamily: 'SF Pro Text',
        fontWeight: FontWeight.w400,
      ),
      labelStyle: TextStyle(
        color: ColorConstant.gray600,
        fontSize: getFontSize(16),
        fontFamily: 'SF Pro Text',
        fontWeight: FontWeight.w400,
      ),
      contentPadding: EdgeInsets.zero,
      labelText: "Phone number",
      hintText: "Phone number",
      hintStyle: TextStyle(
        color: ColorConstant.gray600,
        fontSize: getFontSize(16),
        fontFamily: 'SF Pro Text',
        fontWeight: FontWeight.w400,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(getHorizontalSize(8))),
        borderSide: BorderSide(
          color: ColorConstant.red,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(getHorizontalSize(8))),
        borderSide: BorderSide(
          color: ColorConstant.deepPurple600,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(getHorizontalSize(8))),
        borderSide: BorderSide(
          color: ColorConstant.gray300,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(getHorizontalSize(8))),
        borderSide: BorderSide(
          color: ColorConstant.deepPurple600,
          width: 1,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(),
      ),
    ),
    initialCountryCode: 'IN',
    onChanged: (phone) {
      print(phone.completeNumber);
    },
  );
}


