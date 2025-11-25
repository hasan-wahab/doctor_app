import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app_routes/routes_name.dart';
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
  final List<String> videoImageId = ['x3sKVlYFj5w','ho3Wpg1gPAQ','NuAFBlMGTwI','1Z6Iu0JcIhI'];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.videoPlayerScreen,
          arguments: <String, dynamic>{"currentIndex": widget.currentValue},
        );
      },
      child: SizedBox(
        height: 188.h,
        child: PageView(
          onPageChanged: (value) {
            widget.currentValue = value;
            setState(() {});
          },
          controller: widget.controller,
          scrollDirection: Axis.horizontal,
          children: List.generate((4), (index) {
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(13.sp),
                  height: 188.h,
                  width: 346.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 120.h,
                    width: 319.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://img.youtube.com/vi/${videoImageId[index]}/0.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,

                  child: Icon(
                    Icons.play_circle_fill,
                    size: 50,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
