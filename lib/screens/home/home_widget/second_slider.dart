import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app_styles/app_colors.dart';
import '../../../widgets/custom_text.dart';

class SecondSlider extends StatefulWidget {
  int currentValue;
  PageController controller = PageController();
  SecondSlider({
    super.key,
    required this.controller,
    required this.currentValue,
  });

  @override
  State<SecondSlider> createState() => _SecondSliderState();
}

class _SecondSliderState extends State<SecondSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 188.h,
      child: PageView(
        onPageChanged: (value) {
          widget.currentValue = value;
          setState(() {});
        },
        controller: widget.controller,
        scrollDirection: Axis.horizontal,
        children: List.generate((5), (index) {
          return Container(
            padding: EdgeInsets.only(left: 13.w, right: 13.w, top: 13.h),
            height: 188.h,
            width: 346.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.primaryColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Neurology  Therapy',
                  color: AppColors.secondaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                CustomText(
                  text: 'https://youtube.com/Neurology',
                  color: AppColors.linkTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                Container(
                  height: 120.h,
                  width: 319.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/istockphoto-2171324541-612x612 1.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
