import 'package:doctor_app/screens/wallet_screen/credit_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_styles/app_colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_t_field.dart';
import '../../widgets/custom_text.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool saveCard = false;
  late String? data;
  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    data = args['name'];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: data != null ? Text(data!) : CircularProgressIndicator(),
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CreditCardWidget(
                width: MediaQuery.sizeOf(context).width,
                height: 210.h,
                cardNumber: '4716 9627 1635 8047',
                cardHolderName: 'Hamza Khan',
                expiryDate: '02/30',
                cvv: '345',
                bankName: 'Easypaisa',
                showLogo: true,
              ),
              SizedBox(height: 17.h),
              CustomText(text: 'Card Holder Name', fontSize: 18),
        
              AppTField(),
              SizedBox(height: 22.h),
              CustomText(text: 'Card Number', fontSize: 18),
              AppTField(),
              SizedBox(height: 22.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Expiry Date', fontSize: 18),
                      AppTField(width: 170.w),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'CVV', fontSize: 18),
                      AppTField(width: 170.w),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 22.h),
              Row(
                spacing: 16.w,
                children: [
                  InkWell(
                    onTap: () {
                      saveCard = !saveCard;
                      setState(() {});
                    },
                    child: Container(
                      height: 33.h,
                      width: 33.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(
                          width: 2.w,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      child: saveCard == true
                          ? Icon(
                              CupertinoIcons.check_mark,
                              color: AppColors.primaryColor,
                            )
                          : Container(),
                    ),
                  ),
                  CustomText(text: 'Save Card'),
                ],
              ),
              SizedBox(height: 57.h),
              AppButton(text: 'Proceed to Payment', onTap: () {}),
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
      ),
    );
  }
}
