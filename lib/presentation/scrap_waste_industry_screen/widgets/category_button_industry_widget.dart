import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class CategoryButtonIndustryWidget extends StatefulWidget {
  final String text;
  final String icon;
  final Function(bool isSelected) onTap;

  const CategoryButtonIndustryWidget({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  _CategoryButtonIndustryWidgetState createState() =>
      _CategoryButtonIndustryWidgetState();
}

class _CategoryButtonIndustryWidgetState
    extends State<CategoryButtonIndustryWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
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
                  CustomImageView(
                    imagePath: widget.icon,
                    fit: BoxFit.contain,
                  ),
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
