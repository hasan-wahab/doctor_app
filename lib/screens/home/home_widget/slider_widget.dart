import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_keys/api_keys.dart';
import '../../../core/app_styles/app_colors.dart';
import '../../../core/app_styles/app_sizes.dart';
import '../../../widgets/network_media.dart';

class FirstSlider extends StatefulWidget {
  const FirstSlider({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  State<FirstSlider> createState() => _FirstSliderState();
}

class _FirstSliderState extends State<FirstSlider> {
  late final PageController _controller = PageController();
  Timer? _autoTimer;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _autoTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_controller.hasClients || widget.images.length < 2) return;
      _controller.animateToPage(
        (_page + 1) % widget.images.length,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.images;
    final count = images.isEmpty ? 1 : images.length;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        boxShadow: [
          BoxShadow(
            color: AppColors.firstTextBlackColor.withValues(alpha: 0.06),
            blurRadius: AppSizes.spaceXl,
            offset: Offset(0, AppSizes.spaceXs),
          ),
        ],
      ),
      child: Material(
        color: AppColors.bgColor,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          side: BorderSide(color: AppColors.borderColor),
        ),
        child: SizedBox(
          height: 180.h,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: count,
                onPageChanged: (value) => setState(() => _page = value),
                itemBuilder: (_, index) {
                  return NetworkMedia(
                    url: images.isEmpty
                        ? null
                        : '${ApiKeys.sliderImageUrl}/${images[index]}',
                    emptyMessage: 'Image not found',
                    overlay: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.firstTextBlackColor.withValues(
                              alpha: 0.35,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              if (images.length > 1)
                Padding(
                  padding: EdgeInsets.only(bottom: AppSizes.spaceMd),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < images.length; i++)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          height: 6,
                          width: _page == i ? 18 : 6,
                          decoration: BoxDecoration(
                            color: _page == i
                                ? AppColors.primaryColor
                                : AppColors.bgColor.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusSm,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
