import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';

class DashboardAppbar extends StatelessWidget {
  final String userName;
  final String? imageUrl;
  final DateTime? date;
  final VoidCallback? onAvatarTap;

  const DashboardAppbar({
    super.key,
    required this.userName,
    this.imageUrl,
    this.date,
    this.onAvatarTap,
  });

  String get _initials {
    final parts = userName
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return 'U';
    if (parts.length == 1) {
      final word = parts.first;
      return word.length >= 2
          ? word.substring(0, 2).toUpperCase()
          : word[0].toUpperCase();
    }
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  String get _formattedDate {
    final d = date ?? DateTime.now();
    final mm = d.month.toString().padLeft(2, '0');
    final dd = d.day.toString().padLeft(2, '0');
    return '$mm/$dd/${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: onAvatarTap,
              child: _AvatarCircle(imageUrl: imageUrl, initials: _initials),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, ${userName.toUpperCase()}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.firstTextBlackColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _formattedDate,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.firstTextBlackColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  final String? imageUrl;
  final String initials;

  const _AvatarCircle({required this.imageUrl, required this.initials});

  @override
  Widget build(BuildContext context) {
    final size = 52.w;

    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: imageUrl == null || imageUrl!.trim().isEmpty
            ? _InitialsFallback(initials: initials)
            : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                width: size,
                height: size,
                errorBuilder: (_, __, ___) =>
                    _InitialsFallback(initials: initials),
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: AppColors.primaryColor,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 18.w,
                      height: 18.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.textWhiteColor,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _InitialsFallback extends StatelessWidget {
  final String initials;

  const _InitialsFallback({required this.initials});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.textWhiteColor,
        ),
      ),
    );
  }
}
