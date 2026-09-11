import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app_styles/app_colors.dart';
import '../core/app_styles/app_sizes.dart';
import '../core/app_styles/app_text_styles.dart';

class AppLoadingDialog {
  AppLoadingDialog._();

  static Future<void> show(
    BuildContext context, {
    String message = 'Please wait...',
    String? subtitle,
  }) {
    FocusManager.instance.primaryFocus?.unfocus();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: AppLoadingOverlay(message: message, subtitle: subtitle),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    final navigator = Navigator.of(context, rootNavigator: true);
    if (navigator.canPop()) {
      navigator.pop();
    }
  }
}

class AppLoadingOverlay extends StatefulWidget {
  const AppLoadingOverlay({super.key, required this.message, this.subtitle});

  final String message;
  final String? subtitle;

  @override
  State<AppLoadingOverlay> createState() => _AppLoadingOverlayState();
}

class _AppLoadingOverlayState extends State<AppLoadingOverlay>
    with SingleTickerProviderStateMixin {
  static const _primaryDark = Color(0xFF068F80);
  static const _hangAfter = Duration(seconds: 12);

  late final AnimationController _controller;
  Timer? _hangTimer;
  bool _isSlow = false;

  @override
  void initState() {
    super.initState();
    FocusManager.instance.primaryFocus?.unfocus();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _hangTimer = Timer(_hangAfter, _onPossibleHang);
  }

  void _onPossibleHang() {
    if (!mounted) return;
    if (kDebugMode) {
      debugPrint(
        'AppLoadingOverlay hang: ${widget.message} ${widget.subtitle ?? ''}',
      );
    }
    setState(() => _isSlow = true);
  }

  @override
  void dispose() {
    _hangTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detail = _isSlow
        ? 'Taking longer than usual. Check Debug Console.'
        : (widget.subtitle ?? 'Please wait');

    return AbsorbPointer(
      child: Material(
        type: MaterialType.transparency,
        child: ColoredBox(
          color: AppColors.primaryColor.withValues(alpha: 0.22),
          child: Center(
            child: Container(
              width: 220.w,
              padding: EdgeInsets.fromLTRB(
                22.w,
                AppSizes.spaceSection,
                22.w,
                AppSizes.pagePaddingBottom,
              ),
              decoration: BoxDecoration(
                color: AppColors.bgColor.withValues(alpha: 0.96),
                borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                border: Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.22),
                    blurRadius: 28.r,
                    offset: Offset(0, 10.h),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 68.w,
                    height: 68.w,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: _DualRingPainter(
                            progress: _controller.value,
                            primary: AppColors.primaryColor,
                            primaryDark: _primaryDark,
                          ),
                          child: child,
                        );
                      },
                      child: Center(
                        child: Container(
                          width: 18.w,
                          height: 18.w,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.spaceXxl),
                  Text(
                    widget.message,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.firstTextBlackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: AppSizes.spaceXs),
                  Text(
                    detail,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.mutedTextColor,
                    ),
                  ),
                  SizedBox(height: AppSizes.spaceXl),
                  _PulseDots(controller: _controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DualRingPainter extends CustomPainter {
  _DualRingPainter({
    required this.progress,
    required this.primary,
    required this.primaryDark,
  });

  final double progress;
  final Color primary;
  final Color primaryDark;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2 - 2.w;
    final innerRadius = size.width / 2 - 12.w;

    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.w
      ..color = primary.withValues(alpha: 0.12)
      ..strokeCap = StrokeCap.round;

    final outerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2.w
      ..color = primary
      ..strokeCap = StrokeCap.round;

    final innerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6.w
      ..color = primaryDark
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, outerRadius, trackPaint);
    canvas.drawCircle(center, innerRadius, trackPaint);

    final outerStart = progress * math.pi * 2;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: outerRadius),
      outerStart,
      math.pi * 1.15,
      false,
      outerPaint,
    );

    final innerStart = -progress * math.pi * 2 + math.pi / 2;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: innerRadius),
      innerStart,
      math.pi * 0.9,
      false,
      innerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _DualRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.primary != primary ||
        oldDelegate.primaryDark != primaryDark;
  }
}

class _PulseDots extends StatelessWidget {
  const _PulseDots({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            final wave = (controller.value + (index * 0.22)) % 1.0;
            final scale = 0.55 + (math.sin(wave * math.pi) * 0.45);
            final opacity = 0.35 + (math.sin(wave * math.pi) * 0.65);

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.5.w),
              child: Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity.clamp(0.0, 1.0),
                  child: Container(
                    width: 7.w,
                    height: 7.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
