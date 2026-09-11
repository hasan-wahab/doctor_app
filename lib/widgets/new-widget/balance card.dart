import 'dart:math' as math;

import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../core/app_styles/app_colors.dart';
import '../../core/app_styles/app_sizes.dart';
import '../../core/app_styles/app_text_styles.dart';

class BalanceCard extends StatefulWidget {
  final String currentBalance;
  final String total;
  final String paid;
  final String remaining;
  final String discount;
  final String insurance;
  final bool initiallyHidden;

  const BalanceCard({
    super.key,
    this.currentBalance = '0.0',
    this.total = '0.0',
    this.paid = '0.0',
    this.remaining = '0.0',
    this.discount = '0.0',
    this.insurance = '0.0',
    this.initiallyHidden = true,
  });

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  double percent = 0.0;
  double getTotalPaymentProgress({required total, required paid}) {
    if (total == 0) return 0.0;
    if (paid == 0) return 0.0;
    final progress = paid / total!;

    if (progress.isNaN || progress.isInfinite) return 0.0;

    return progress.clamp(0.0, 100) * 100;
  }

  late bool _hidden;

  void _updatePercent() {
    final total = double.parse(widget.total);
    final paid = double.parse(widget.paid);
    final discount = double.parse(widget.discount);
    final insurance = double.parse(widget.insurance);
    final totalInsuranceAndDiscount = insurance + discount;
    final totalWithDiscount = paid + totalInsuranceAndDiscount;
    percent = getTotalPaymentProgress(total: total, paid: totalWithDiscount);
  }

  @override
  void initState() {
    super.initState();
    _updatePercent();
    _hidden = widget.initiallyHidden;
  }

  @override
  void didUpdateWidget(covariant BalanceCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.total != widget.total ||
        oldWidget.paid != widget.paid ||
        oldWidget.discount != widget.discount ||
        oldWidget.insurance != widget.insurance) {
      _updatePercent();
    }
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.gapMd,
                vertical: AppSizes.spaceLg,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: _buildBalance()),
                  SizedBox(width: AppSizes.gapMd),
                  _buildProgress(percent),
                ],
              ),
            ),
            SizedBox(height: AppSizes.spaceXl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _cell(
                    'TOTAL',
                    widget.total,
                    accent: AppColors.primaryColor,
                  ),
                ),
                SizedBox(width: AppSizes.gapSm),
                Expanded(
                  child: _cell(
                    'PAID',
                    widget.paid,
                    accent: AppColors.success,
                    valueColor: AppColors.success,
                  ),
                ),
                SizedBox(width: AppSizes.gapSm),
                Expanded(
                  child: _cell(
                    'REMAINING',
                    widget.remaining,
                    accent: AppColors.dueRedColor,
                    valueColor: AppColors.dueRedColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.spaceMd),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _cell(
                    'DISCOUNT',
                    widget.discount,
                    accent: AppColors.blueGrayTextColor,
                    valueColor: AppColors.blueGrayTextColor,
                  ),
                ),
                SizedBox(width: AppSizes.gapSm),
                Expanded(
                  child: _cell(
                    'INSURANCE',
                    widget.insurance,
                    accent: AppColors.info,
                    valueColor: AppColors.info,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              size: AppSizes.iconSm,
              color: AppColors.primaryColor,
            ),
            SizedBox(width: AppSizes.gapSm),
            Flexible(
              child: CustomText(
                text: 'CURRENT BALANCE',
                style: AppTextStyles.label.copyWith(
                  letterSpacing: 0.4,
                  color: AppColors.labelTextColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSizes.spaceMd),
        Row(
          children: [
            if (_hidden)
              Row(
                children: List.generate(6, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == 5 ? 0 : AppSizes.spaceXs,
                    ),
                    child: Container(
                      width: AppSizes.spaceSm,
                      height: AppSizes.spaceSm,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),
              )
            else
              Flexible(
                child: CustomText(
                  text: widget.currentBalance,
                  style: AppTextStyles.heading2,
                  maxLines: 1,
                ),
              ),
            SizedBox(width: AppSizes.gapSm),
            GestureDetector(
              onTap: () => setState(() => _hidden = !_hidden),
              child: Container(
                padding: EdgeInsets.all(AppSizes.spaceXs),
                decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _hidden
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: AppSizes.iconSm,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgress(double percent) {
    final ringSize = AppSizes.buttonHeight + AppSizes.spaceSm;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: ringSize,
          height: ringSize,
          child: CustomPaint(
            painter: _ProgressRingPainter(percent: percent / 100),
            child: Center(
              child: CustomText(
                text: '${percent.round()}%',
                style: AppTextStyles.chipPrimary.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: AppSizes.gapMd),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Progress',
              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700),
            ),
            CustomText(
              text: 'Active Cycle',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.labelTextColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _cell(
    String label,
    String value, {
    required Color accent,
    Color? valueColor,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.gapSm,
        vertical: AppSizes.spaceSm,
      ),
      decoration: BoxDecoration(
        color: AppColors.softGrayColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: AppSizes.spaceXs,
                height: AppSizes.spaceXs,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: AppSizes.gapSm),
              Flexible(
                child: CustomText(
                  text: label,
                  style: AppTextStyles.label,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.spaceXs),
          CustomText(
            text: value,
            style: AppTextStyles.name.copyWith(
              color: valueColor ?? AppColors.firstTextBlackColor,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double percent;

  _ProgressRingPainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final stroke = AppSizes.spaceXs;
    final radius = (math.min(size.width, size.height) - stroke) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawCircle(
      center,
      radius - stroke / 2,
      Paint()..color = AppColors.bgColor,
    );

    final bg = Paint()
      ..color = AppColors.borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    final fg = Paint()
      ..color = AppColors.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, -math.pi / 2, math.pi * 2, false, bg);
    canvas.drawArc(rect, -math.pi / 2, math.pi * 2 * percent, false, fg);
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) =>
      oldDelegate.percent != percent;
}
