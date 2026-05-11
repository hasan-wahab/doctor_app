import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/slider_model.dart';

class FirstSlider extends StatefulWidget {
  SliderModel? sliderModel;
  int currentValue;
  PageController controller;

  FirstSlider({
    super.key,
    required this.currentValue,
    required this.controller,
    required this.sliderModel,
  });

  @override
  State<FirstSlider> createState() => _FirstSliderState();
}

class _FirstSliderState extends State<FirstSlider> {
  @override
  Widget build(BuildContext context) {
    final images = widget.sliderModel;

    return images != null
        ? SizedBox(
            height: 174.h,
            child: PageView(
              onPageChanged: (value) {
                widget.currentValue = value;
                setState(() {});
              },
              controller: widget.controller,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                (images.data.isNotEmpty ? images.data.length : 5),
                (index) {
                  return SizedBox(
                    height: 174.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: images.data.isNotEmpty
                          ? Image.network(images.data[index])
                          : Image.asset(
                              'assets/images/istockphoto-2171324541-612x612 1.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                  );
                },
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
