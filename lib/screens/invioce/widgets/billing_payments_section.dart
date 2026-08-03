import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';

class BillingPaymentsSection extends StatelessWidget {
  final List<BillingPaymentItem> payments;

  const BillingPaymentsSection({
    super.key,
    this.payments = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        if (payments.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.softGrayColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Text(
              'No payments found for this invoice.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.mutedTextColor,
              ),
            ),
          )
        else
          ...List.generate(payments.length, (index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == payments.length - 1 ? 0 : 10.h,
              ),
              child: _PaymentCard(item: payments[index]),
            );
          }),
      ],
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final BillingPaymentItem item;

  const _PaymentCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.softGrayColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          _row('PAYMENT ID', item.paymentId),
          SizedBox(height: 10.h),
          _row('DATE', item.date),
          SizedBox(height: 10.h),
          _row('AMOUNT', item.amount),
          SizedBox(height: 10.h),
          _row('METHOD', item.method),
          SizedBox(height: 10.h),
          _row('TYPE', item.type),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.labelTextColor,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.firstTextBlackColor,
            ),
          ),
        ),
      ],
    );
  }
}

class BillingPaymentItem {
  final String paymentId;
  final String date;
  final String amount;
  final String method;
  final String type;

  const BillingPaymentItem({
    required this.paymentId,
    required this.date,
    required this.amount,
    required this.method,
    required this.type,
  });
}
