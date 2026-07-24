import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_styles/app_colors.dart';
import 'billing_payments_section.dart';

class BillingInvoiceCard extends StatefulWidget {
  final String invoiceNo;
  final String date;
  final String type;
  final String amount;
  final String discount;
  final String paid;
  final String due;
  final String payStatus;
  final List<BillingPaymentItem> payments;

  const BillingInvoiceCard({
    super.key,
    required this.invoiceNo,
    required this.date,
    required this.type,
    required this.amount,
    required this.discount,
    required this.paid,
    required this.due,
    required this.payStatus,
    this.payments = const [],
  });

  @override
  State<BillingInvoiceCard> createState() => _BillingInvoiceCardState();
}

class _BillingInvoiceCardState extends State<BillingInvoiceCard> {
  bool _showPayments = false;

  bool get _isPackage => widget.type.toUpperCase() == 'PACKAGE';

  bool get _dueIsZero {
    final digits = widget.due.replaceAll(RegExp(r'[^0-9.]'), '');
    return digits.isEmpty || double.tryParse(digits) == 0;
  }

  bool get _isPaid =>
      widget.payStatus.toLowerCase() == 'paid' ||
      widget.payStatus.toUpperCase() == 'PAID';

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: AppColors.secondaryColor,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.invoiceNo,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.firstTextBlackColor,
                    ),
                  ),
                ),
                _typeBadge(),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              widget.date,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.mutedTextColor,
              ),
            ),
            SizedBox(height: 12.h),
            Divider(height: 1.h, color: AppColors.borderColor),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(child: _metric('AMOUNT', widget.amount)),
                Expanded(child: _metric('DISCOUNT', widget.discount)),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: _metric(
                    'PAID',
                    widget.paid,
                    valueColor: AppColors.primaryColor,
                  ),
                ),
                Expanded(
                  child: _metric(
                    'DUE',
                    widget.due,
                    valueColor: _dueIsZero
                        ? AppColors.firstTextBlackColor
                        : AppColors.dueRedColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(height: 1.h, color: AppColors.borderColor),
            SizedBox(height: 12.h),
            Row(
              children: [
                _statusBadge(),
                const Spacer(),
                GestureDetector(
                  onTap: () => setState(() => _showPayments = !_showPayments),
                  child: Row(
                    children: [
                      Text(
                        'View Payments',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Icon(
                        _showPayments
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 18.sp,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_showPayments)
              BillingPaymentsSection(
                payments: widget.payments.isEmpty ? const [] : widget.payments,
              ),
          ],
        ),
      ),
    );
  }

  Widget _typeBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: _isPackage
            ? AppColors.secondaryColor
            : AppColors.consultationBadgeBg,
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Text(
        widget.type.toUpperCase(),
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: _isPackage
              ? AppColors.primaryColor
              : AppColors.consultationBadgeText,
        ),
      ),
    );
  }

  Widget _statusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: _isPaid ? AppColors.secondaryColor : AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _isPaid ? Icons.check_circle : Icons.info_outline,
            size: 14.sp,
            color: _isPaid ? AppColors.primaryColor : AppColors.textWhiteColor,
          ),
          SizedBox(width: 4.w),
          Text(
            widget.payStatus,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: _isPaid
                  ? AppColors.primaryColor
                  : AppColors.textWhiteColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _metric(String label, String value, {Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.labelTextColor,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
            color: valueColor ?? AppColors.firstTextBlackColor,
          ),
        ),
      ],
    );
  }
}
