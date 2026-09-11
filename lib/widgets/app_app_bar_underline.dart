import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app_styles/app_colors.dart';

class AppAppBarUnderline {
  AppAppBarUnderline._();

  static double get height => 1.5.h;

  static double get preferredExtra => height;

  static const List<Color> _rainbow = [
    Color(0xFFE53935),
    Color(0xFFFB8C00),
    Color(0xFFFDD835),
    Color(0xFF43A047),
    Color(0xFF1E88E5),
    Color(0xFF3949AB),
    Color(0xFF8E24AA),
  ];

  static PreferredSizeWidget forState({required bool isLoading}) =>
      _AppBarUnderlineWidget(isLoading: isLoading);
}

class _AppBarUnderlineWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const _AppBarUnderlineWidget({required this.isLoading});

  final bool isLoading;

  @override
  Size get preferredSize => Size.fromHeight(AppAppBarUnderline.height);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: AppAppBarUnderline.height,
        child: LinearProgressIndicator(
          minHeight: AppAppBarUnderline.height,
          color: AppColors.primaryColor,
          backgroundColor: AppColors.secondaryColor,
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: AppAppBarUnderline.height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: AppAppBarUnderline._rainbow,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.18),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
}
