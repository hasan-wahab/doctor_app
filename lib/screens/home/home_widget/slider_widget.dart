import 'package:doctor_app/data/models/slider_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/api_service/api_service.dart';

class FirstSlider extends StatefulWidget {
  SliderModel? sliderModel;
  int currentValue;
  PageController controller;

  FirstSlider({
    super.key,
    required this.currentValue,
    required this.controller,
    this.sliderModel,
  });

  @override
  State<FirstSlider> createState() => _FirstSliderState();
}

class _FirstSliderState extends State<FirstSlider> {
  @override
  Widget build(BuildContext context) {
    return widget.sliderModel != null
        ? SizedBox(
            height: 174.h,
            child: PageView(
              onPageChanged: (value) {
                widget.currentValue = value;
                print(value);
                setState(() {});
              },
              controller: widget.controller,
              scrollDirection: Axis.horizontal,
              children: List.generate((widget.sliderModel?.data.length ?? 1), (
                index,
              ) {
                return SizedBox(
                  height: 174.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: widget.sliderModel!.data.isNotEmpty
                        ? Image.network(widget.sliderModel!.data[index])
                        : Image.asset(
                            'assets/images/istockphoto-2171324541-612x612 1.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                );
              }),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
