import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstSlider extends StatefulWidget {
  int currentValue;
  PageController controller;

   FirstSlider({super.key,required this.currentValue,required this.controller});

  @override
  State<FirstSlider> createState() => _FirstSliderState();
}

class _FirstSliderState extends State<FirstSlider> {


  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 174.h,
      child: PageView(
        onPageChanged: (value) {
          widget.currentValue = value;
          setState(() {});
        },
        controller: widget.controller,
        scrollDirection: Axis.horizontal,
        children: List.generate((5), (index) {
          return Container(
         //  margin: EdgeInsets.only(right: 20.w, left: 20.w),
            height: 174.h,
            width: 312.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/istockphoto-2171324541-612x612 1.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          );
        }),
      ),
    );
  }
}
