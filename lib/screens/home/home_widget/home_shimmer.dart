import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_sizes.dart';
import '../../../widgets/app_shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppSizes.contentMaxWidth(context),
          ),
          child: AppShimmer(
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppSizes.pageInsets,
              children: [
                ShimmerBox(
                  height: 180.h,
                  radius: BorderRadius.circular(AppSizes.radiusMd),
                ),
                SizedBox(height: AppSizes.spaceXxl),
                const _SectionBone(),
                SizedBox(height: AppSizes.spaceMd),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Row(
                    children: [
                      _PackageBone(),
                      SizedBox(width: AppSizes.gapMd),
                      _PackageBone(),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.spaceXxl),
                const _SectionBone(),
                SizedBox(height: AppSizes.spaceMd),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Row(
                    children: [
                      _VideoBone(),
                      SizedBox(width: AppSizes.gapMd),
                      _VideoBone(),
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

class _SectionBone extends StatelessWidget {
  const _SectionBone();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerBox(width: 170.w, height: 16.h),
        const Spacer(),
        ShimmerBox(width: 58.w, height: 12.h),
      ],
    );
  }
}

class _PackageBone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(
            height: 132.h,
            radius: BorderRadius.circular(AppSizes.radiusMd),
          ),
          SizedBox(height: AppSizes.spaceMd),
          ShimmerBox(width: 180.w, height: 14.h),
          SizedBox(height: AppSizes.spaceXs),
          ShimmerBox(width: 110.w, height: 12.h),
          SizedBox(height: AppSizes.spaceXs),
          ShimmerBox(width: 90.w, height: 14.h),
          SizedBox(height: AppSizes.spaceMd),
          ShimmerBox(
            height: AppSizes.buttonHeightSm,
            radius: BorderRadius.circular(AppSizes.radiusSm),
          ),
        ],
      ),
    );
  }
}

class _VideoBone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 248.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(
            height: 158.h,
            radius: BorderRadius.circular(AppSizes.radiusMd),
          ),
          SizedBox(height: AppSizes.spaceMd),
          ShimmerBox(height: 12.h),
          SizedBox(height: AppSizes.spaceXs),
          ShimmerBox(width: 160.w, height: 12.h),
        ],
      ),
    );
  }
}
