import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';

/// Pain Details — grid card (list fields wrap for extra items)
class PainIntensityCard extends StatelessWidget {
  final String painIntensity;
  final List<String> painTiming;
  final List<String> typeOfPain;
  final String painPattern;
  final String duration;
  const PainIntensityCard({
    super.key,
    required this.painIntensity,
    required this.painTiming,
    required this.typeOfPain,
    required this.painPattern,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    // Sample API data — Type of Pain / Pain Timing can grow

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.bgColor,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.borderColor),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 14.h),
                child: Column(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final gap = 8.w;
                        // Phone → 2 cols, wider → 4 cols
                        final cols = constraints.maxWidth >= 520 ? 4 : 2;
                        final tileW =
                            (constraints.maxWidth - gap * (cols - 1)) / cols;

                        return Wrap(
                          spacing: gap,
                          runSpacing: gap,
                          children: [
                            SizedBox(
                              width: tileW,
                              child: _vasTile(painIntensity.toString()),
                            ),
                            SizedBox(
                              width: tileW,
                              child: _listTile('TYPE OF PAIN', typeOfPain),
                            ),
                            SizedBox(
                              width: tileW,
                              child: _textTile(
                                'PAIN PATTERN',
                                _capitalize(painPattern),
                              ),
                            ),
                            SizedBox(
                              width: tileW,
                              child: _listTile(
                                'WHEN IS IT WORST? (TIMING)',
                                painTiming,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 8.h),
                    _durationTile(duration),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.secondaryColor, AppColors.bgColor],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            'PAIN DETAILS',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryColor,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tileShell({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: child,
    );
  }

  Widget _tileLabel(String label, {Color? color}) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 9.sp,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.labelTextColor,
        letterSpacing: 0.2,
        height: 1.2,
      ),
    );
  }

  Widget _vasTile(String vas) {
    return _tileShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tileLabel('PAIN INTENSITY (VAS 0-10)'),
          SizedBox(height: 8.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: vas,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryColor,
                  ),
                ),
                TextSpan(
                  text: ' / 10',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mutedTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _textTile(String label, String value) {
    return _tileShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tileLabel(label),
          SizedBox(height: 8.h),
          Text(
            value.isEmpty ? '—' : value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.firstTextBlackColor,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }

  /// List values → chips that wrap when more items arrive
  Widget _listTile(String label, List<String> items) {
    return _tileShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tileLabel(label),
          SizedBox(height: 8.h),
          if (items.isEmpty)
            Text(
              '—',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.mutedTextColor,
              ),
            )
          else
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: items.map(_miniChip).toList(),
            ),
        ],
      ),
    );
  }

  Widget _miniChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.softGrayColor,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.firstTextBlackColor,
        ),
      ),
    );
  }

  Widget _durationTile(String duration) {
    return _tileShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tileLabel(
            'HOW LONG HAVE YOU HAD THIS? (DURATION)',
            color: AppColors.primaryColor,
          ),
          SizedBox(height: 8.h),
          Text(
            duration.isEmpty ? '—' : duration,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.firstTextBlackColor,
            ),
          ),
        ],
      ),
    );
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }
}
