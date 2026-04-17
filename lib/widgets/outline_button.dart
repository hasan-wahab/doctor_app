import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app_styles/app_colors.dart';

class AppOutlineButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final double? textSize;
  final FontWeight? fontWeight;
  final VoidCallback onTap;
  const AppOutlineButton({
    super.key,
    required this.onTap,
    required this.text,
    this.height = 22,
    this.width = 100,
    this.fontWeight,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 22.h,
        width: 100.w,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: CustomText(
          text: text,
          fontSize: textSize ?? 10,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      ),
    );
  }
}
