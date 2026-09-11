import 'package:doctor_app/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isLeading;
  final VoidCallback? leadingOnTap;
  final bool isLoading;

  const ProfileAppbar({
    super.key,
    required this.title,
    this.isLeading = false,
    this.leadingOnTap,
    this.isLoading = false,
  });

  @override
  Size get preferredSize => AppAppBar.barSize;

  @override
  Widget build(BuildContext context) {
    return AppAppBar(
      title: title,
      showBack: isLeading,
      onBack: leadingOnTap,
      isLoading: isLoading,
    );
  }
}
