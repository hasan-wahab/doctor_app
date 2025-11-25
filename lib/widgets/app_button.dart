import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String text;
  VoidCallback? onTap;
  bool isColor;
  final double? width;
  final Color? borderColor;
  final Color? textColor;
  final double? textSize;
  final double? height;

  AppButton({
    super.key,
    required this.text,
    this.onTap,
    this.isColor = true,
    this.width,
    this.borderColor,
    this.textColor,
    this.textSize,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height?.h ?? 50.h,
        width: width?.w ?? MediaQuery.sizeOf(context).width.w,
        decoration: BoxDecoration(
          color: isColor ? AppColors.primaryColor : AppColors.whiteIconColor,
          borderRadius: BorderRadius.circular(12.r),
          border: isColor == false
              ? Border.all(color: borderColor ?? AppColors.primaryColor)
              : null,
        ),
        child: CustomText(
          text: text,
          color: isColor
              ? textColor ?? AppColors.textWhiteColor
              : textColor ?? AppColors.primaryColor,
          fontSize: textSize?.sp ?? 18.sp,
        ),
      ),
    );
  }
}
