import 'package:doctor_app/widgets/app_app_bar.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/app_routes/routes_name.dart';
import '../core/app_styles/app_colors.dart';
import '../core/app_styles/app_sizes.dart';
import '../core/app_styles/app_text_styles.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, this.isLoading = false});

  final bool isLoading;

  @override
  Size get preferredSize => AppAppBar.barSize;

  @override
  Widget build(BuildContext context) {
    return AppAppBar(
      greeting: 'Hello,',
      title: 'Guest User',
      userName: 'Guest User',
      subtitle: 'Dr. Ali Therapy',
      isLoading: isLoading,
      actions: [
        InkWell(
          onTap: () => context.push(AppRoutes.loginScreen),
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.gapMd,
              vertical: AppSizes.spaceSm,
            ),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(AppSizes.radiusLg),
              border: Border.all(color: AppColors.primaryColor),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: 'Sign In',
                  style: AppTextStyles.chipPrimary.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: AppSizes.gapSm),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: AppSizes.iconSm,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
