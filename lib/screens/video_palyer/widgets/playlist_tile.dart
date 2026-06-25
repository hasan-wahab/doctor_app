import 'package:doctor_app/core/app_styles/app_colors.dart';
import 'package:doctor_app/screens/video_palyer/models/video_playlist_item.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaylistTile extends StatelessWidget {
  final VideoPlaylistItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const PlaylistTile({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryColor : null,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                item.thumbnailUrl,
                height: 72.h,
                width: 120.w,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 72.h,
                  width: 120.w,
                  color: Colors.grey.shade200,
                  child: Icon(Icons.play_circle_outline, size: 32.sp),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (isSelected) ...[
                        Icon(
                          Icons.play_arrow_rounded,
                          color: AppColors.primaryColor,
                          size: 20.sp,
                        ),
                        SizedBox(width: 4.w),
                      ],
                      Expanded(
                        child: CustomText(
                          text: item.title,
                          fontSize: 15,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.firstTextBlackColor,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    text: item.description,
                    fontSize: 12,
                    color: AppColors.secondaryTextColor,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
