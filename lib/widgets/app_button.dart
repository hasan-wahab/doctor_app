import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app_styles/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isColor;
  final double? width;
  final Color? borderColor;
  final Color? textColor;
  final double? textSize;
  final double? height;
  final BorderRadius? borderRadius;
  final FontWeight? fontWeight;

  const AppButton({
    super.key,
    required this.text,
    this.onTap,
    this.isColor = true,
    this.width,
    this.borderColor,
    this.textColor,
    this.textSize,
    this.height,
    this.borderRadius,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(24.r);
    final background = isColor
        ? AppColors.primaryColor
        : AppColors.whiteIconColor;
    final foreground = isColor
        ? textColor ?? AppColors.textWhiteColor
        : textColor ?? AppColors.primaryColor;

    return Material(
      color: background,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          alignment: Alignment.center,
          height: height?.h ?? 50.h,
          width: width?.w ?? double.infinity,
          decoration: BoxDecoration(
            borderRadius: radius,
            border: isColor
                ? null
                : Border.all(color: borderColor ?? AppColors.primaryColor),
          ),
          child: CustomText(
            text: text,
            color: foreground,
            fontSize: textSize ?? 16,
            fontWeight: fontWeight ?? FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
