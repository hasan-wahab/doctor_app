import 'package:doctor_app/core/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoInternetOverlay extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetOverlay({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.75),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.wifi_off_rounded, color: Colors.white, size: 56.sp),
          SizedBox(height: 16.h),
          CustomText(
            text: 'No Internet Connection',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            align: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: 'Playback is paused. Reconnect to resume automatically.',
            fontSize: 13,
            color: Colors.white70,
            align: TextAlign.center,
            maxLines: 3,
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
