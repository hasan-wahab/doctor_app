import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app_styles/app_colors.dart';
import 'app_button.dart';
import 'custom_text.dart';

class FeedbackButton extends StatelessWidget {
  final VoidCallback onTap;
  final int initStars;
  const FeedbackButton({super.key, required this.onTap, this.initStars = 0});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        spacing: 20.w,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 3.w,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: 'How was your experience?',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return Icon(
                    initStars < index + 1 ? Icons.star_border : Icons.star,
                    color: initStars < index + 1
                        ? Colors.grey
                        : Colors.amber.shade700,
                    size: 16.r,
                  );
                }),
              ),
            ],
          ),
          Expanded(
            child: AppButton(
              height: 40.h,
              text: 'Give Feedback',
              textSize: 10.sp,
              isColor: false,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
