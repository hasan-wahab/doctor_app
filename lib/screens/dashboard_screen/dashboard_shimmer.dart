import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_sizes.dart';
import '../../widgets/app_shimmer.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

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
              ShimmerBox(width: 160.w, height: AppSizes.spaceXl),
              SizedBox(height: AppSizes.spaceMd),
              ShimmerBox(
                height: AppSizes.buttonHeight * 3,
                radius: BorderRadius.circular(AppSizes.radiusMd),
              ),
              SizedBox(height: AppSizes.spaceXxl),
              Row(
                children: [
                  ShimmerBox(width: 140.w, height: AppSizes.spaceXl),
                  const Spacer(),
                  ShimmerBox(
                    width: 72.w,
                    height: AppSizes.spaceXl,
                    radius: BorderRadius.circular(AppSizes.radiusLg),
                  ),
                ],
              ),
              SizedBox(height: AppSizes.spaceMd),
              Row(
                children: [
                  Expanded(child: _tileBone()),
                  SizedBox(width: AppSizes.gapMd),
                  Expanded(child: _tileBone()),
                ],
              ),
              SizedBox(height: AppSizes.spaceMd),
              Row(
                children: [
                  Expanded(child: _tileBone()),
                  SizedBox(width: AppSizes.gapMd),
                  Expanded(child: _tileBone()),
                ],
              ),
              SizedBox(height: AppSizes.spaceMd),
              _tileBone(),
              SizedBox(height: AppSizes.spaceXxl),
              ShimmerBox(width: 150.w, height: AppSizes.spaceXl),
              SizedBox(height: AppSizes.spaceMd),
              _progressBone(),
              SizedBox(height: AppSizes.spaceMd),
              _progressBone(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tileBone() {
    return ShimmerBox(
      height: AppSizes.buttonHeight + AppSizes.spaceXl,
      radius: BorderRadius.circular(AppSizes.radiusMd),
    );
  }

  Widget _progressBone() {
    return ShimmerBox(
      height: AppSizes.buttonHeight * 2,
      radius: BorderRadius.circular(AppSizes.radiusMd),
    );
  }
}
