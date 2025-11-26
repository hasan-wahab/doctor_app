import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_routes/routes_name.dart';
import '../../app_styles/app_colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_t_field.dart';
import '../../widgets/custom_text.dart';

class CreditCardPaymentScreen extends StatelessWidget {
  const CreditCardPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pay With Credit Card'),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, size: 30.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Container(
              height: 40.5.h,
              width: 246.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/credit_card.png'),
                ),
              ),
            ),
            SizedBox(height: 53.46.h,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              height: 292.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: AppColors.secondaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Card Number', fontSize: 20),
                  SizedBox(height: 5.h),
                  AppTField(hintText: '1234 5678 9012 3456'),
                  SizedBox(height: 18.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: 'Expiry Date', fontSize: 18),
                          SizedBox(height: 5.h),

                          AppTField(width: 137.w,hintText: 'MM / YY',),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: 'CVV', fontSize: 18),
                          SizedBox(height: 5.h),

                          AppTField(width: 137.w,hintText: '123',),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),

                  SizedBox(height: 18.h),
                  AppButton(text: 'Proceed', onTap: () {
                    Navigator.pushNamed(context,AppRoutes.successPaymentScreen);

                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
