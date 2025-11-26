import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/app_t_field.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EasypaisaPaymentScreen extends StatelessWidget {
  const EasypaisaPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
        title: Text('Easypaisa Payment'),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, size: 30.sp),
        ),
      ),
      backgroundColor: AppColors.secondaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            Container(
              height: 40.h,
              width: 210.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/easypaisa.png'),
                ),
              ),
            ),
            SizedBox(height: 50.h),
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
                  CustomText(text: 'Enter Amount', fontSize: 20),
                  SizedBox(height: 5.h),
                  AppTField(hintText: '1000'),
                  SizedBox(height: 18.h),
                  CustomText(text: 'Enter Easypaisa Number', fontSize: 20),
                  SizedBox(height: 5.h),

                  AppTField(hintText: '0398765432'),
                  SizedBox(height: 18.h),
                  AppButton(text: 'Confirm & Pay',onTap: (){
                    Navigator.pushNamed(context,AppRoutes.successPaymentScreen);
                  },),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
