import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_keys/api_keys.dart';
import '../../../core/app_styles/app_colors.dart';
import '../../../data/models/slider_model.dart';
import '../../../widgets/custom_text.dart';

class FirstSlider extends StatefulWidget {
  List sliderImages;
  int currentValue;
  PageController controller;
  bool hasInternet;

  FirstSlider({
    super.key,
    this.hasInternet = false,
    required this.currentValue,
    required this.controller,
    required this.sliderImages,
  });

  @override
  State<FirstSlider> createState() => _FirstSliderState();
}

class _FirstSliderState extends State<FirstSlider> {
  @override
  Widget build(BuildContext context) {
    final images = widget.sliderImages;

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
              children: List.generate((images.isNotEmpty ? images.length : 1), (
                index,
              ) {
                return SizedBox(
                  height: 174.h,
                  child: widget.hasInternet
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColors.primaryColor),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.network(
                              fit: BoxFit.cover,
                              "${ApiKeys.sliderImageUrl}/${images[index]}",
                              // 'https://alitherapy.neonweb.tech/storage/sliders/5lzEOvuOk3hYxVG8DyTBQixcV8YRpw3mo2CxwWMh.jpg',
                              loadingBuilder: (context, child, loading) {
                                if (loading != null) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return child;
                              },
                              errorBuilder: (context, obj, err) {
                                return Center(
                                  child: CustomText(
                                    text: 'Image not\nfound!',
                                    color: AppColors.secondaryTextColor,
                                    align: TextAlign.center,
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Center(
                          child: CustomText(
                            align: TextAlign.center,
                            maxLines: 3,
                            text: 'No Internet\nImage not found!',
                          ),
                        ),
                );
              }),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
