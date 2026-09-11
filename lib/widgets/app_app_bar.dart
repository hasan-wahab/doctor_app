import 'package:doctor_app/core/functions.dart';
import 'package:doctor_app/widgets/app_app_bar_underline.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../core/app_styles/app_colors.dart';
import '../core/app_styles/app_sizes.dart';
import '../core/app_styles/app_text_styles.dart';

/// Shared app bar for the whole patient app.
///
/// Leading is either:
/// - back icon ([showBack] = true), or
/// - profile image / initials ([userName] / [imageUrl]).
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title = '',
    this.greeting,
    this.subtitle,
    this.subtitleIcon,
    this.subtitleColor,
    this.showBack = false,
    this.onBack,
    this.imageUrl,
    this.userName,
    this.onAvatarTap,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.isLoading = false,
  });

  /// Page title, or the name when [greeting] is set.
  final String title;
  final String? greeting;
  final String? subtitle;
  final IconData? subtitleIcon;
  final Color? subtitleColor;
  final bool showBack;
  final VoidCallback? onBack;
  final String? imageUrl;
  final String? userName;
  final VoidCallback? onAvatarTap;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isLoading;

  static Size get barSize => Size.fromHeight(
        AppSizes.buttonHeight +
            AppSizes.spaceSm +
            AppSizes.spaceMd +
            AppAppBarUnderline.height,
      );

  @override
  Size get preferredSize => barSize;

  bool get _showAvatar => !showBack && (userName != null || imageUrl != null);

  Color get _fg => foregroundColor ?? AppColors.firstTextBlackColor;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColors.screenBgColor;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: ColoredBox(
        color: bg,
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSizes.pagePaddingH,
                  AppSizes.spaceSm,
                  AppSizes.pagePaddingH,
                  AppSizes.spaceMd,
                ),
                child: SizedBox(
                  height: AppSizes.buttonHeight,
                  child: Row(
                    children: [
                      if (showBack) ...[
                        _BackButton(onBack: onBack),
                        SizedBox(width: AppSizes.gapMd),
                      ] else if (_showAvatar) ...[
                        _ProfileLeading(
                          imageUrl: imageUrl,
                          name: userName ?? title,
                          onTap: onAvatarTap,
                        ),
                        SizedBox(width: AppSizes.gapMd),
                      ],
                      Expanded(child: _title()),
                      if (actions != null && actions!.isNotEmpty) ...[
                        SizedBox(width: AppSizes.gapSm),
                        ...actions!,
                      ] else if (showBack)
                        SizedBox(width: AppSizes.buttonHeightSm),
                    ],
                  ),
                ),
              ),
              AppAppBarUnderline.forState(isLoading: isLoading),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    final hasGreeting = greeting != null && greeting!.trim().isNotEmpty;
    final alignedCenter = showBack && !hasGreeting && subtitle == null;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          alignedCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        if (hasGreeting)
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$greeting ',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.labelTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: title,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w700,
                    color: _fg,
                  ),
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        else
          CustomText(
            text: title,
            style: showBack
                ? AppTextStyles.appBarTitle.copyWith(color: _fg)
                : AppTextStyles.name.copyWith(color: _fg),
            maxLines: 1,
            align: alignedCenter ? TextAlign.center : TextAlign.start,
          ),
        if (subtitle != null && subtitle!.isNotEmpty) ...[
          SizedBox(height: AppSizes.spaceXs),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (subtitleIcon != null) ...[
                Icon(
                  subtitleIcon,
                  size: AppSizes.iconSm,
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: AppSizes.gapSm),
              ],
              Flexible(
                child: CustomText(
                  text: subtitle!,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w500,
                    color: subtitleColor ??
                        (subtitleIcon != null
                            ? AppColors.primaryColor
                            : AppColors.labelTextColor),
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBack ??
          () {
            if (context.canPop()) {
              context.pop();
            } else {
              Navigator.maybePop(context);
            }
          },
      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      child: SizedBox(
        height: AppSizes.buttonHeight,
        width: AppSizes.buttonHeightSm,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: AppSizes.iconMd,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

class _ProfileLeading extends StatelessWidget {
  const _ProfileLeading({
    required this.imageUrl,
    required this.name,
    this.onTap,
  });

  final String? imageUrl;
  final String name;
  final VoidCallback? onTap;

  bool get _hasImage {
    final url = imageUrl?.trim() ?? '';
    if (url.isEmpty || url == 'No data') return false;
    return url.startsWith('http');
  }

  @override
  Widget build(BuildContext context) {
    final size = AppSizes.buttonHeight;
    final child = Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.bgColor,
        border: Border.all(color: AppColors.primaryColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: _hasImage
          ? Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              width: size,
              height: size,
              errorBuilder: (_, __, ___) => _Initials(name: name),
            )
          : _Initials(name: name),
    );

    if (onTap == null) return child;
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: child,
    );
  }
}

class _Initials extends StatelessWidget {
  const _Initials({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final initials = getFirstTwoInitials(name);
    return CustomText(
      text: initials.isEmpty ? 'U' : initials,
      style: AppTextStyles.name.copyWith(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class AppBarNotificationButton extends StatelessWidget {
  const AppBarNotificationButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppBarCircleIconButton(
      icon: Icons.notifications_none_rounded,
      onTap: onTap,
    );
  }
}

class AppBarRefreshButton extends StatelessWidget {
  const AppBarRefreshButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppBarCircleIconButton(
      icon: Icons.refresh_rounded,
      onTap: onTap,
    );
  }
}

class AppBarCircleIconButton extends StatelessWidget {
  const AppBarCircleIconButton({super.key, required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bgColor,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          height: AppSizes.buttonHeightSm,
          width: AppSizes.buttonHeightSm,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Icon(
            icon,
            size: AppSizes.iconMd,
            color: AppColors.firstTextBlackColor,
          ),
        ),
      ),
    );
  }
}
