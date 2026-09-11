import 'package:doctor_app/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';

import '../../core/app_styles/app_colors.dart';

class DashboardAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String? imageUrl;
  final DateTime? date;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onNotificationTap;
  final bool isLoading;

  const DashboardAppbar({
    super.key,
    required this.userName,
    this.imageUrl,
    this.date,
    this.onAvatarTap,
    this.onNotificationTap,
    this.isLoading = false,
  });

  String get _formattedDate {
    final d = date ?? DateTime.now();
    final mm = d.month.toString().padLeft(2, '0');
    final dd = d.day.toString().padLeft(2, '0');
    return '$mm/$dd/${d.year}';
  }

  @override
  Size get preferredSize => AppAppBar.barSize;

  @override
  Widget build(BuildContext context) {
    return AppAppBar(
      title: 'Hi, ${userName.toUpperCase()}',
      userName: userName,
      imageUrl: imageUrl,
      subtitle: _formattedDate,
      subtitleColor: AppColors.primaryColor,
      onAvatarTap: onAvatarTap,
      isLoading: isLoading,
      actions: [
        AppBarNotificationButton(onTap: onNotificationTap),
      ],
    );
  }
}
