import 'dart:io';

import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../core/app_styles/app_colors.dart';
import '../../../core/app_styles/app_sizes.dart';
import '../../../core/app_styles/app_text_styles.dart';
import '../../../core/functions.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.name,
    this.imageUrl,
    this.token,
    this.file,
    this.badge,
  });

  final String name;
  final String? imageUrl;
  final String? token;
  final File? file;
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    final size = AppSizes.logoSize;
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondaryColor,
              border: Border.all(color: AppColors.primaryColor),
            ),
            child: ClipOval(child: _image()),
          ),
          if (badge != null)
            Positioned(
              right: 0,
              bottom: 0,
              child: badge!,
            ),
        ],
      ),
    );
  }

  Widget _image() {
    if (file != null) {
      return Image.file(file!, fit: BoxFit.cover);
    }
    final url = imageUrl?.trim() ?? '';
    if (url.isEmpty) return _initials();

    return Image.network(
      url,
      fit: BoxFit.cover,
      headers: token == null || token!.isEmpty
          ? const {}
          : {'Authorization': 'Bearer $token'},
      errorBuilder: (_, __, ___) => _initials(),
    );
  }

  Widget _initials() {
    return ColoredBox(
      color: AppColors.secondaryColor,
      child: Center(
        child: CustomText(
          text: getFirstTwoInitials(name),
          style: AppTextStyles.heading3.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

class ProfileAvatarBadge extends StatelessWidget {
  const ProfileAvatarBadge({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryColor,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          height: AppSizes.iconXl,
          width: AppSizes.iconXl,
          child: Icon(
            icon,
            size: AppSizes.iconSm,
            color: AppColors.whiteIconColor,
          ),
        ),
      ),
    );
  }
}

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    super.key,
    required this.name,
    required this.patientId,
    this.imageUrl,
    this.token,
    this.file,
    this.badge,
  });

  final String name;
  final String patientId;
  final String? imageUrl;
  final String? token;
  final File? file;
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bgColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        side: BorderSide(color: AppColors.borderColor),
      ),
      child: Padding(
        padding: AppSizes.cardInsets,
        child: Row(
          children: [
            ProfileAvatar(
              name: name,
              imageUrl: imageUrl,
              token: token,
              file: file,
              badge: badge,
            ),
            SizedBox(width: AppSizes.gapLg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: name,
                    maxLines: 2,
                    style: AppTextStyles.name,
                  ),
                  SizedBox(height: AppSizes.spaceXs),
                  CustomText(
                    text: 'Patient ID: $patientId',
                    style: AppTextStyles.bodySmall,
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

class ProfileGroupCard extends StatelessWidget {
  const ProfileGroupCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bgColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        side: BorderSide(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0)
              Divider(
                height: 1,
                color: AppColors.borderColor,
              ),
            children[i],
          ],
        ],
      ),
    );
  }
}

class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    final tint = iconColor ?? AppColors.primaryColor;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.cardPaddingH,
          vertical: AppSizes.spaceLg,
        ),
        child: Row(
          children: [
            Container(
              height: AppSizes.buttonHeightSm,
              width: AppSizes.buttonHeightSm,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              child: Icon(icon, size: AppSizes.iconMd, color: tint),
            ),
            SizedBox(width: AppSizes.gapMd),
            Expanded(
              child: CustomText(
                text: label,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: labelColor ?? AppColors.firstTextBlackColor,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: AppSizes.iconLg,
              color: AppColors.mutedTextColor,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.cardPaddingH,
        vertical: AppSizes.spaceLg,
      ),
      child: Row(
        children: [
          Container(
            height: AppSizes.buttonHeightSm,
            width: AppSizes.buttonHeightSm,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
            child: Icon(
              icon,
              size: AppSizes.iconMd,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(width: AppSizes.gapMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: label, style: AppTextStyles.label),
                SizedBox(height: AppSizes.spaceXs),
                CustomText(
                  text: value.isEmpty ? '—' : value,
                  maxLines: 2,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
