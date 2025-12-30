import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_styles/app_colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_t_field.dart';
import '../../widgets/custom_text.dart';

class BankTransferScreen extends StatefulWidget {
  const BankTransferScreen({super.key});

  @override
  State<BankTransferScreen> createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends State<BankTransferScreen> {
  String? selectedBank;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pay With Bank'),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/bank.png'),
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
                  CustomText(text: 'Enter account number', fontSize: 20),
                  SizedBox(height: 5.h),
                  AppTField(hintText: '1000'),
                  SizedBox(height: 18.h),
                  CustomText(text: 'Select Bank', fontSize: 20),
                  SizedBox(height: 5.h),

                  Container(
                    alignment: Alignment.center,
                    height: 62.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: DropdownButton<String>(
                      hint: Text('Select Bank'),
                      value: selectedBank,
                      menuMaxHeight: 100,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(12.r),
                      underline: Container(),
                      items: [
                        DropdownMenuItem(
                          value: 'Allied',
                          child: Text('Allied'),
                        ),
                        DropdownMenuItem(value: 'UBL', child: Text('UBL')),
                        DropdownMenuItem(
                          value: 'Sada Pay',
                          child: Text('Sada Pay'),
                        ),
                      ],
                      onChanged: (value) {
                        selectedBank = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(height: 18.h),
                  AppButton(
                    text: 'Proceed',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.successPaymentScreen,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
