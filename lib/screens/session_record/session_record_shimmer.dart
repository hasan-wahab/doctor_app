import 'package:flutter/material.dart';

import '../../core/app_styles/app_sizes.dart';
import '../../widgets/app_shimmer.dart';

class SessionRecordShimmer extends StatelessWidget {
  const SessionRecordShimmer({super.key});

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
                height: AppSizes.buttonHeight * 2,
                radius: BorderRadius.circular(AppSizes.radiusMd),
              ),
              SizedBox(height: AppSizes.spaceXxl),
              ShimmerBox(
                height: AppSizes.buttonHeight * 2,
                radius: BorderRadius.circular(AppSizes.radiusMd),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
