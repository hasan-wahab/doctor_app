import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app_styles/app_colors.dart';

class CheckCircle extends StatelessWidget {
  final bool isSelected;
  final String text;
  final VoidCallback onChange;
  const CheckCircle({
    super.key,
    required this.isSelected,
    required this.text,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChange(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 15.h,
            width: 15.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 8.h,
                  width: 8.h,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryColor : null,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 5.w),
          CustomText(text: text),
        ],
      ),
    );
  }
}
