import 'package:doctor_app/core/extentions/internect_connectivity.dart';
import 'package:doctor_app/screens/video_palyer/data/app_video_playlist.dart';
import 'package:doctor_app/screens/video_palyer/models/video_playlist_item.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_routes/routes_name.dart';
import '../../../core/app_styles/app_colors.dart';
import '../../../core/app_styles/app_sizes.dart';
import '../../../core/app_styles/app_text_styles.dart';
import '../../../widgets/network_media.dart';

class SecondSlider extends StatelessWidget {
  const SecondSlider({super.key});

  Future<void> _open(BuildContext context, int index) async {
    if (await InternetUtils.isInternetAvailable()) {
      if (context.mounted) {
        context.push(AppRoutes.videoPlayerScreen, extra: index);
      }
    } else if (context.mounted) {
      AppMsg.warning(
        context,
        'Looks like you are offline. Please check your connection and try again.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final videos = AppVideoPlaylist.items;
    final width = 248.w;
    final imageHeight = 158.h;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.pagePaddingH),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < videos.length; i++) ...[
            if (i > 0) SizedBox(width: AppSizes.gapMd),
            _card(context, i, videos[i], width, imageHeight),
          ],
        ],
      ),
    );
  }

  Widget _card(
    BuildContext context,
    int index,
    VideoPlaylistItem video,
    double width,
    double imageHeight,
  ) {
    final description = video.description.isNotEmpty
        ? video.description
        : video.title;

    return InkWell(
      onTap: () => _open(context, index),
      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      child: DecoratedBox(
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
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: AppVideoPlaylist.heroTag(index),
                  child: Material(
                    color: AppColors.bgColor,
                    child: SizedBox(
                      height: imageHeight,
                      width: width,
                      child: NetworkMedia(
                        url: AppVideoPlaylist.thumbnailAt(index),
                        emptyMessage: 'Video unavailable',
                        emptyIcon: Icons.videocam_off_outlined,
                        overlay: Center(
                          child: Container(
                            height: AppSizes.buttonHeightSm,
                            width: AppSizes.buttonHeightSm,
                            decoration: BoxDecoration(
                              color: AppColors.bgColor.withValues(alpha: 0.94),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              size: AppSizes.iconXl,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSizes.gapMd,
                    AppSizes.spaceMd,
                    AppSizes.gapMd,
                    AppSizes.spaceMd,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: video.title,
                        style: AppTextStyles.name,
                        maxLines: 1,
                      ),
                      SizedBox(height: AppSizes.spaceXs),
                      CustomText(
                        text: description,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.labelTextColor,
                        ),
                        textOverflow: TextOverflow.visible,
                      ),
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
