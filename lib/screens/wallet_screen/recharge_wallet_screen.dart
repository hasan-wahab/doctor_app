import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/app_t_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_text.dart';

class RechargeWalletScreen extends StatefulWidget {
  const RechargeWalletScreen({super.key});

  @override
  State<RechargeWalletScreen> createState() => _RechargeWalletScreenState();
}

class _RechargeWalletScreenState extends State<RechargeWalletScreen> {
  bool creditCard = false;
  bool bankTransfer = false;
  bool easyPaisa = false;
  bool jazCash = false;
  bool credit = false;
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            CustomText(text: 'Recharge Wallet', fontSize: 24),
            SizedBox(height: 45.h),
            CustomText(text: 'Enter amount', fontSize: 18),
            AppTField(),
            SizedBox(height: 41.h),
            CustomText(text: 'Select Payment Method', fontSize: 20),
            SizedBox(height: 38.h),
            InkWell(
              onTap: () {
                setState(() {
                  creditCard = !creditCard;
                  jazCash = false;
                  easyPaisa = false;
                  bankTransfer = false;
                });
              },
              child: Row(
                spacing: 16.w,
                children: [
                  Container(
                    height: 44.h,
                    width: 44.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.w,
                        color: AppColors.primaryColor,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            color: creditCard == true
                                ? AppColors.primaryColor
                                : null,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomText(text: 'Credit/Debit Card'),
                ],
              ),
            ),

            SizedBox(height: 24.h),
            InkWell(
              onTap: () {
                setState(() {
                  easyPaisa = !easyPaisa;
                  jazCash = false;
                  creditCard = false;
                  bankTransfer = false;
                });
              },
              child: Row(
                spacing: 16.w,
                children: [
                  Container(
                    height: 44.h,
                    width: 44.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.w,
                        color: AppColors.primaryColor,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            color: easyPaisa == true
                                ? AppColors.primaryColor
                                : null,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomText(text: 'Easypaisa'),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            InkWell(
              onTap: () {
                setState(() {
                  bankTransfer = !bankTransfer;
                  jazCash = false;
                  creditCard = false;
                  easyPaisa = false;
                });
              },
              child: Row(
                spacing: 16.w,
                children: [
                  Container(
                    height: 44.h,
                    width: 44.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.w,
                        color: AppColors.primaryColor,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            color: bankTransfer == true
                                ? AppColors.primaryColor
                                : null,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomText(text: 'Bank Transfer'),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            InkWell(
              onTap: () {
                setState(() {
                  jazCash = !jazCash;
                  creditCard = false;
                  easyPaisa = false;
                  bankTransfer = false;
                });
              },
              child: Row(
                spacing: 16.w,
                children: [
                  Container(
                    height: 44.h,
                    width: 44.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.w,
                        color: AppColors.primaryColor,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            color: jazCash == true
                                ? AppColors.primaryColor
                                : null,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomText(text: 'JazzCash'),
                ],
              ),
            ),
            SizedBox(height: 50.h),

            AppButton(
              text: 'Proceed to Payment',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.paymentMethodeScreen,
                  arguments: {'name': 'Credit/Debit Card'},
                );
              },
            ),
            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: 'Secure payment powered by XYZ Getway',
                  fontSize: 10,
                  color: AppColors.secondaryTextColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
