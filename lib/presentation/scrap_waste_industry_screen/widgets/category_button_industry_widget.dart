import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../core/utils/color_constant.dart';
import '../../../theme/app_style.dart';
import '../../../widgets/custom_image_view.dart';

class CategoryButtonIndustryWidget extends StatefulWidget {
  final String text;

  final Function(bool isSelected) onTap;

  const CategoryButtonIndustryWidget({
    required this.text,
    required this.onTap,
  });

  @override
  _CategoryButtonIndustryWidgetState createState() =>
      _CategoryButtonIndustryWidgetState();
}

class _CategoryButtonIndustryWidgetState
    extends State<CategoryButtonIndustryWidget> {
  bool isSelected = false;

  String extractUppercaseCharacters(String input) {
    StringBuffer result = StringBuffer();

    // Iterate through each character in the input string
    for (int i = 0; i < input.length; i++) {
      // Check if the character is uppercase
      if (input[i].toUpperCase() == input[i] &&
          input[i].toLowerCase() != input[i]) {
        result.write(input[i]);
      }
    }

    // Convert StringBuffer to String and return it
    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    String upperCaseLetters = extractUppercaseCharacters(widget.text);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
          widget.onTap(isSelected);
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                color: isSelected
                    ? ColorConstant.highlighter.withOpacity(0.3)
                    : Colors.white,
              ),
              height: 90,
              width: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    upperCaseLetters,
                    style: TextStyle(
                      color: Color(0xff071952),
                      fontSize: getFontSize(
                        24,
                      ),
                      fontFamily: 'SF Pro Text',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // CustomImageView(
                  //   imagePath: widget.icon,
                  //   fit: BoxFit.contain,
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: AppStyle.txtSFProTextMedium14,
            )
          ],
        ),
      ),
    );
  }
}
