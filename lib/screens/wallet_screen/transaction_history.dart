import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_styles/app_colors.dart';
import '../../widgets/custom_text.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Transaction History'),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, size: 30.sp),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                height: 45.h,
                width: 45.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Icon(
                  Icons.list_alt,
                  color: AppColors.primaryColor,
                  size: 30.sp,
                ),
              ),
              title: CustomText(text: 'Appointment Payment', fontSize: 16),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: '10 Oct 2025',
                    fontSize: 10,
                    color: AppColors.secondaryTextColor,
                  ),
                  CustomText(
                    text: 'Easypaisa',
                    fontSize: 10,
                    color: AppColors.secondaryTextColor,
                  ),
                ],
              ),

              trailing: Column(
                spacing: 5.h,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 20.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: CustomText(
                      text: 'Success',
                      color: AppColors.textWhiteColor,
                    ),
                  ),
                  CustomText(text: '-PKR1000', fontSize: 12),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
