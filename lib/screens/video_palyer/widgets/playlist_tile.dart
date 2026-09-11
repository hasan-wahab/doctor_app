import 'package:doctor_app/core/app_styles/app_colors.dart';
import 'package:doctor_app/core/app_styles/app_sizes.dart';
import 'package:doctor_app/core/app_styles/app_text_styles.dart';
import 'package:doctor_app/screens/video_palyer/models/video_playlist_item.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/network_media.dart';
import 'package:flutter/material.dart';

class PlaylistTile extends StatelessWidget {
  final VideoPlaylistItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final bool dense;

  const PlaylistTile({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    final thumbHeight = dense
        ? AppSizes.buttonHeightSm
        : AppSizes.buttonHeight + AppSizes.spaceXl;
    final thumbWidth = thumbHeight * 16 / 9;

    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.spaceMd),
      child: Material(
        color: isSelected ? AppColors.secondaryColor : AppColors.bgColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: EdgeInsets.all(dense ? AppSizes.gapSm : AppSizes.gapMd),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.borderColor,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  child: SizedBox(
                    height: thumbHeight,
                    width: thumbWidth,
                    child: NetworkMedia(
                      url: item.thumbnailUrl,
                      emptyMessage: 'Video unavailable',
                      emptyIcon: Icons.videocam_off_outlined,
                      overlay: isSelected
                          ? ColoredBox(
                              color: AppColors.firstTextBlackColor.withValues(
                                alpha: 0.28,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.equalizer_rounded,
                                  color: AppColors.textWhiteColor,
                                  size: AppSizes.iconMd,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
                SizedBox(width: AppSizes.gapMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isSelected)
                        Padding(
                          padding: EdgeInsets.only(bottom: AppSizes.spaceXs),
                          child: CustomText(
                            text: 'Now playing',
                            style: AppTextStyles.chipPrimary.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      CustomText(
                        text: item.title,
                        style: AppTextStyles.body.copyWith(
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w600,
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.firstTextBlackColor,
                        ),
                        maxLines: dense ? 1 : 2,
                      ),
                      if (!dense) ...[
                        SizedBox(height: AppSizes.spaceXs),
                        CustomText(
                          text: item.description,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.labelTextColor,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
