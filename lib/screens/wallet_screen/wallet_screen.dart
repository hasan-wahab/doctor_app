import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_text.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, size: 30.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              CustomText(text: 'Wallet Balance', fontSize: 24),
              SizedBox(height: 16.h),
              Container(
                height: 137.h,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'PKR 3000.00',
                      fontSize: 32,
                      color: AppColors.textWhiteColor,
                    ),
                    CustomText(
                      text: 'Available Balance',
                      fontSize: 16,
                      color: AppColors.textWhiteColor,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              AppButton(
                text: 'Recharge Wallet',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.rechargeScreen);
                },
              ),
              SizedBox(height: 10.h),

              AppButton(
                text: 'Transaction History',
                isColor: false,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.transactionHistoryScreen,
                  );
                },
              ),
              SizedBox(height: 27.h),

              CustomText(text: 'Transaction History', fontSize: 20),
              SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        height: 35.h,
                        width: 35.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Icon(
                          Icons.list_alt,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      title: CustomText(
                        text: 'Appointment Payment',
                        fontSize: 16,
                      ),
                      subtitle: CustomText(
                        text: '10 Oct 2025',
                        fontSize: 10,
                        color: AppColors.secondaryTextColor,
                      ),
                      trailing: CustomText(text: '-PKR1000', fontSize: 12),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        height: 35.h,
                        width: 35.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Icon(
                          Icons.list_alt,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      title: CustomText(
                        text: 'Appointment Payment',
                        fontSize: 16,
                      ),
                      subtitle: CustomText(
                        text: '10 Oct 2025',
                        fontSize: 10,
                        color: AppColors.secondaryTextColor,
                      ),
                      trailing: CustomText(text: '-PKR1000', fontSize: 12),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        height: 35.h,
                        width: 35.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Icon(
                          Icons.list_alt,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      title: CustomText(text: 'Wallet Recharge', fontSize: 16),
                      subtitle: CustomText(
                        text: '10 Oct 2025',
                        fontSize: 10,
                        color: AppColors.secondaryTextColor,
                      ),
                      trailing: CustomText(text: '+ PKR1000', fontSize: 12),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        height: 35.h,
                        width: 35.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Icon(
                          Icons.list_alt,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      title: CustomText(
                        text: 'Appointment Payment',
                        fontSize: 16,
                      ),
                      subtitle: CustomText(
                        text: '10 Oct 2025',
                        fontSize: 10,
                        color: AppColors.secondaryTextColor,
                      ),
                      trailing: CustomText(text: '-PKR1000', fontSize: 12),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        height: 35.h,
                        width: 35.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Icon(
                          Icons.list_alt,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      title: CustomText(
                        text: 'Appointment Payment',
                        fontSize: 16,
                      ),
                      subtitle: CustomText(
                        text: '10 Oct 2025',
                        fontSize: 10,
                        color: AppColors.secondaryTextColor,
                      ),
                      trailing: CustomText(text: '-PKR1000', fontSize: 12),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        height: 35.h,
                        width: 35.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Icon(
                          Icons.list_alt,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      title: CustomText(
                        text: 'Appointment Payment',
                        fontSize: 16,
                      ),
                      subtitle: CustomText(
                        text: '10 Oct 2025',
                        fontSize: 10,
                        color: AppColors.secondaryTextColor,
                      ),
                      trailing: CustomText(text: '-PKR1000', fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
