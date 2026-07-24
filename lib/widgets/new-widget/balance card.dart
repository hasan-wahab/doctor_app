import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';

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

  @override
  void initState() {
    super.initState();
    final total = double.parse(widget.total);
    final paid = double.parse(widget.paid);
    final discount = double.parse(widget.discount);
    final insurance = double.parse(widget.insurance);
    final totalInsuranceAndDiscount = insurance + discount;
    final totalWithDiscount = paid + totalInsuranceAndDiscount;
    percent = getTotalPaymentProgress(total: total, paid: totalWithDiscount);
    _hidden = widget.initiallyHidden;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: AppColors.secondaryColor,
      child: SizedBox(
        width: double.infinity,
        //clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildBalance()),
                  SizedBox(width: 8.w),
                  _buildProgress(percent.toDouble()),
                ],
              ),
              SizedBox(height: 14.h),
              Divider(height: 1.h, color: AppColors.borderColor),
              SizedBox(height: 14.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _cell('Total', widget.total),
                        SizedBox(height: 12.h),
                        _cell(
                          'Discount',
                          widget.discount,
                          valueColor: AppColors.blueGrayTextColor,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _cell(
                          'Paid',
                          widget.paid,
                          valueColor: AppColors.primaryColor,
                        ),
                        SizedBox(height: 12.h),
                        _cell('Insurance', widget.insurance),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _cell(
                      'Remaining',
                      widget.remaining,
                      valueColor: AppColors.dueRedColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CURRENT BALANCE',
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.labelTextColor,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Text(
              _hidden ? '******' : widget.currentBalance,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.firstTextBlackColor,
                letterSpacing: _hidden ? 2 : 0,
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () => setState(() => _hidden = !_hidden),
              child: Icon(
                _hidden
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20.sp,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgress(double percent) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56.w,
          height: 56.w,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColors.softGrayColor,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: CustomPaint(
            painter: _ProgressRingPainter(percent: percent / 100),
            child: Center(
              child: Text(
                '${percent.round()}%',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.firstTextBlackColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          'Progress',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.firstTextBlackColor,
          ),
        ),
      ],
    );
  }

  Widget _cell(String label, String value, {Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
            color: valueColor ?? AppColors.firstTextBlackColor,
          ),
        ),
      ],
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double percent;

  _ProgressRingPainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const stroke = 4.5;
    final radius = (math.min(size.width, size.height) - stroke) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

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
