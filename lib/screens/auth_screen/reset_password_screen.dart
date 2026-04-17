import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/app_t_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, size: 30.sp),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          SizedBox(height: 96 - 66.h),
          Container(
            height: 70.h,
            width: 70.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/main_logo.png'),
              ),
            ),
          ),

          SizedBox(height: 50.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [Text('Forget Password', style: TextStyle(fontSize: 40))],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [Text('Enter your email address to reset your password')],
          ),
          SizedBox(height: 25.h),
          AppTField(hintText: 'Enter your email', ),
          SizedBox(height: 60.h),

          AppButton(text: 'Submit'),
        ],
      ),
    );
  }
}
