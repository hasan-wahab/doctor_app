import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentOptionScreen extends StatefulWidget {
  const PaymentOptionScreen({super.key});

  @override
  State<PaymentOptionScreen> createState() => _PaymentOptionScreenState();
}

class _PaymentOptionScreenState extends State<PaymentOptionScreen> {
  bool isWallet = false;
  bool isEasypaisa = false;
  bool isBankTransfer = false;
  bool isDebitCard = false;
  bool isColor = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Payment Options'),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, size: 30.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              height: 181.h,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 10,
                    color: Colors.grey.shade300,
                    offset: Offset(0, 5),
                  ),
                ],
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Row(
                    spacing: 10.w,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 72.h,
                        width: 72.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/profile_image.png',
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(height: 5.h),
                          CustomText(text: 'Dr.Smith', fontSize: 28),
                          CustomText(text: 'Physiotherapist'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  CustomText(
                    text: 'Tue, Oct23 10:00-10:30 AM ',
                    fontSize: 18,
                    color: AppColors.secondaryTextColor,
                  ),
                  CustomText(text: 'PKR 2,100 ', fontSize: 18),
                ],
              ),
            ),
            SizedBox(height: 37.h),
            CustomText(text: 'Choose Payment Method', fontSize: 20),
            SizedBox(height: 10.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 10,
                    color: Colors.grey.shade300,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ListTile(
                onTap: () {
                  setState(() {
                    isDebitCard = false;
                    isBankTransfer = false;
                    isEasypaisa = false;
                    isWallet = !isWallet;
                  });
                  if (isWallet == true) {
                    setState(() {
                      isColor = true;
                    });
                  } else {
                    setState(() {
                      isColor = false;
                    });
                  }
                },
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.wallet_rounded, size: 50.sp),
                title: CustomText(text: 'Wallet'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Pay using wallet Balance',
                      fontSize: 12,
                      color: AppColors.secondaryTextColor,
                    ),
                    CustomText(
                      text: 'Current Balance: PKR 3000',
                      fontSize: 12,
                      color: AppColors.secondaryTextColor,
                    ),
                  ],
                ),
                trailing: Container(
                  height: 20.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    border: Border.all(color: AppColors.primaryColor, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 10.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          color: isWallet == true
                              ? AppColors.primaryColor
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 10,
                    color: Colors.grey.shade300,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ListTile(
                onTap: () {
                  setState(() {
                    isDebitCard = false;
                    isBankTransfer = false;
                    isEasypaisa = !isEasypaisa;
                    isWallet = false;
                  });
                  if (isEasypaisa == true) {
                    setState(() {
                      isColor = true;
                    });
                  } else {
                    setState(() {
                      isColor = false;
                    });
                  }
                },
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.credit_card, size: 50.sp),
                title: CustomText(text: 'Easypaisa / JazzCash'),
                subtitle: CustomText(
                  text: 'Instant mobile wallet payment',
                  fontSize: 12,
                  color: AppColors.secondaryTextColor,
                ),
                trailing: Container(
                  height: 20.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    border: Border.all(color: AppColors.primaryColor, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 10.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          color: isEasypaisa == true
                              ? AppColors.primaryColor
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 10,
                    color: Colors.grey.shade300,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ListTile(
                onTap: () {
                  setState(() {
                    isBankTransfer = !isBankTransfer;
                    isDebitCard = false;
                    isEasypaisa = false;
                    isWallet = false;
                  });
                  if (isBankTransfer == true) {
                    setState(() {
                      isColor = true;
                    });
                  } else {
                    setState(() {
                      isColor = false;
                    });
                  }
                },
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.home_outlined, size: 50.sp),
                title: CustomText(text: 'Bank Transfer'),
                subtitle: CustomText(
                  text: 'Send payment from your bank Account',
                  fontSize: 12,
                  color: AppColors.secondaryTextColor,
                ),
                trailing: Container(
                  height: 20.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    border: Border.all(color: AppColors.primaryColor, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 10.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          color: isBankTransfer == true
                              ? AppColors.primaryColor
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 10,
                    color: Colors.grey.shade300,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ListTile(
                onTap: () {
                  setState(() {
                    isDebitCard = !isDebitCard;
                    isBankTransfer = false;
                    isEasypaisa = false;
                    isWallet = false;
                  });
                  if (isDebitCard == true) {
                    setState(() {
                      isColor = true;
                    });
                  } else {
                    setState(() {
                      isColor = false;
                    });
                  }
                },
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.credit_card, size: 50.sp),
                title: CustomText(text: 'Debit/ Credit Card'),
                subtitle: CustomText(
                  text: 'Pay securely via Visa Or MasterCard',
                  fontSize: 12,
                  color: AppColors.secondaryTextColor,
                ),
                trailing: Container(
                  height: 20.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    border: Border.all(color: AppColors.primaryColor, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 10.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          color: isDebitCard == true
                              ? AppColors.primaryColor
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Total: PKR 21,00', fontSize: 20),
                AppButton(
                  text: 'Proceed to pay',
                  width: 165,
                  isColor: isColor,
                  onTap: () {
                    if (isWallet == true) {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.walletPaymentScreen,
                      );
                    } else if (isEasypaisa == true) {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.easyPaisaPaymentScreen,
                      );
                    } else if (isBankTransfer == true) {
                      Navigator.pushNamed(context, AppRoutes.bankPaymentScreen);
                    } else if (isDebitCard == true) {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.creditCardPaymentScreen,
                      );
                    } else {}
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
