import 'package:flutter/material.dart';

import '../core/app_styles/app_colors.dart';
import '../core/app_styles/app_sizes.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        const Positioned.fill(
          child: IgnorePointer(child: ShimmerSweep()),
        ),
      ],
    );
  }
}

class ShimmerSweep extends StatefulWidget {
  const ShimmerSweep({super.key, this.fillBackground = false});

  final bool fillBackground;

  @override
  State<ShimmerSweep> createState() => _ShimmerSweepState();
}

class _ShimmerSweepState extends State<ShimmerSweep>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            if (!width.isFinite || width <= 0) {
              return const SizedBox.expand();
            }

            final band = width * 0.55;
            final dx = -band + ((width + band) * _controller.value);

            return ClipRect(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (widget.fillBackground)
                    ColoredBox(color: AppColors.secondaryColor),
                  Transform.translate(
                    offset: Offset(dx, 0),
                    child: Container(
                      width: band,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0),
                            Colors.white.withValues(alpha: 0.75),
                            Colors.white.withValues(alpha: 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    this.width,
    this.height,
    this.radius,
  });

  final double? width;
  final double? height;
  final BorderRadius? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: radius ?? BorderRadius.circular(AppSizes.radiusSm),
      ),
    );
  }
}

/// First-load placeholder for list / detail screens.
class AppListShimmer extends StatelessWidget {
  const AppListShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: AppSizes.contentMaxWidth(context),
        ),
        child: AppShimmer(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: AppSizes.pageInsets,
            children: [
              for (var i = 0; i < itemCount; i++) ...[
                if (i > 0) SizedBox(height: AppSizes.spaceXxl),
                ShimmerBox(
                  height: AppSizes.buttonHeight * 2,
                  radius: BorderRadius.circular(AppSizes.radiusMd),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
