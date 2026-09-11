import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_keys/api_keys.dart';
import '../../../core/app_routes/routes_name.dart';
import '../../../core/app_styles/app_colors.dart';
import '../../../core/app_styles/app_sizes.dart';
import '../../../core/app_styles/app_text_styles.dart';
import '../../../data/models/all_packages_model.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/network_media.dart';
import '../../../widgets/show_msg.dart';

class AllPackagesWidget extends StatelessWidget {
  const AllPackagesWidget({
    super.key,
    required this.packages,
  });

  final AllPackagesModel packages;

  @override
  Widget build(BuildContext context) {
    final items = packages.packages;
    if (items.isEmpty) {
      return SizedBox(
        height: AppSizes.logoSize,
        child: Center(
          child: CustomText(
            text: 'No packages',
            style: AppTextStyles.body,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.pagePaddingH),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) SizedBox(width: AppSizes.gapMd),
            PackageCard(
              package: items[i],
              width: 250.w,
            ),
          ],
        ],
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  const PackageCard({
    super.key,
    required this.package,
    this.width,
  });

  final PackageItemModel package;
  final double? width;

  String _price(String price) {
    final value = double.tryParse(price);
    if (value == null) return 'Rs. $price';
    final digits = value.toStringAsFixed(0);
    final withCommas = digits.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
    return 'Rs. $withCommas';
  }

  String? _fromName(String name, String pattern) {
    if (name.isEmpty) return null;
    return RegExp(pattern, caseSensitive: false).firstMatch(name)?.group(1);
  }

  String _cleanName(String name) {
    var text = name;
    final square = text.indexOf('[');
    if (square >= 0) text = text.substring(0, square);
    final paren = text.indexOf('(');
    if (paren >= 0) text = text.substring(0, paren);
    text = text.replaceAll(RegExp(r'[()[\]{},.]'), '');
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  Future<void> _book(BuildContext context) async {
    final ok = await AppMsg.confirm(
      context,
      title: 'Sign in required',
      message: 'Please sign in first to book this therapy package.',
      cancelLabel: 'Cancel',
      confirmLabel: 'Login',
      icon: Icons.lock_outline_rounded,
    );
    if (ok && context.mounted) {
      context.push(AppRoutes.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = package.name ?? '';
    final days = _fromName(name, r'(\d+)\s*days?');
    final sessions = _fromName(name, r'(\d+)\s*sessions?');
    final title = _cleanName(name);
    final imageHeight = 132.h;

    Widget card = DecoratedBox(
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: imageHeight,
                  width: width ?? double.infinity,
                  child: NetworkMedia(
                    url: package.hasImage
                        ? '${ApiKeys.allPackegesImagesUrl}/${package.displayImage}'
                        : null,
                    emptyMessage: 'Image not found',
                  ),
                ),
                if (days != null)
                  Positioned(
                    top: AppSizes.spaceMd,
                    left: AppSizes.spaceMd,
                    child: _chip('$days Days'),
                  ),
              ],
            ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSizes.gapMd,
              AppSizes.spaceMd,
              AppSizes.gapMd,
              AppSizes.gapMd,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  style: AppTextStyles.name,
                  textOverflow: TextOverflow.visible,
                ),
                if (sessions != null) ...[
                  SizedBox(height: AppSizes.spaceXs),
                  CustomText(
                    text: '$sessions Sessions Free',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.labelTextColor,
                    ),
                    textOverflow: TextOverflow.visible,
                  ),
                ],
                SizedBox(height: AppSizes.spaceXs),
                CustomText(
                  text: _price(package.displayPrice),
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                  textOverflow: TextOverflow.visible,
                ),
                SizedBox(height: AppSizes.spaceMd),
                AppButton(
                  text: 'Book Package',
                  height: 40,
                  textSize: 14,
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  onTap: () => _book(context),
                ),
              ],
            ),
          ),
        ],
        ),
      ),
    );

    if (width == null) return card;
    return SizedBox(width: width, child: card);
  }

  Widget _chip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spaceMd,
        vertical: AppSizes.spaceXs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: CustomText(
        text: text,
        style: AppTextStyles.chipPrimary.copyWith(
          color: AppColors.textWhiteColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
