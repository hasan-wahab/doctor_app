import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/app_t_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_styles/app_colors.dart';
import '../../models/current_patient_model.dart';
import '../../widgets/custom_text.dart';

class InvoiceDetailScreen extends StatefulWidget {
  const InvoiceDetailScreen({super.key});

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  CurrentPatientModel? currentPatientData;
  var isExpanded;

  @override
  void didChangeDependencies() {
    Map<String, CurrentPatientModel> data =
        ModalRoute.of(context)?.settings.arguments
            as Map<String, CurrentPatientModel>;
    if (data != null) {
      currentPatientData = data['data'];
    }
    isExpanded = List.generate(currentPatientData!.recentInvoices.length, (
      index,
    ) {
      return false;
    });
    super.didChangeDependencies();
  }

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
        centerTitle: true,
        title: Text('Invoice'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        children: [
          CustomText(
            text: 'Billing History',
            fontSize: 20,
            color: AppColors.primaryColor,
          ),
          SizedBox(height: 17.h),
          AppTField(
            hintText: 'Search here',
            icon: Icon(Icons.search),
            isIconsLeft: true,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(currentPatientData!.recentInvoices.length, (
              index,
            ) {
              var invoice = currentPatientData!.recentInvoices[index];
              return Container(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
                margin: EdgeInsets.only(top: 10.h),
                width: 360.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.primaryColor, width: 2),
                ),

                child: Column(
                  spacing: 10.h,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _text(
                      firstText: 'Invoice #',
                      secondText: invoice.id.toString(),
                    ),

                    _text(
                      firstText: 'Date',
                      secondText: invoice.createdAt.toString(),
                    ),
                    _text(firstText: 'Type', buttonText: invoice.type),
                    _text(
                      firstText: 'Total amount',
                      secondText: invoice.amount,
                    ),
                    _text(firstText: 'Status', buttonText: invoice.status),

                    isExpanded[index] == true
                        ? Column(
                            children: [
                              Divider(color: AppColors.primaryColor),
                              _text(
                                firstText: 'Partial payments',
                                secondText: '',
                              ),
                              ...List.generate(invoice.payments.length, (
                                index,
                              ) {
                                return _text(
                                  firstText: '${index + 1}',
                                  secondText: invoice.payments[index].amount,
                                );
                              }),
                              Divider(color: AppColors.primaryColor),
                            ],
                          )
                        : Container(),

                    SizedBox(height: 5.h),
                    invoice.status != 'paid'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppButton(
                                onTap: () {
                                  setState(() {
                                    isExpanded[index] = !isExpanded[index];
                                  });
                                },
                                text: isExpanded[index] == true
                                    ? 'see less'
                                    : 'see more',
                                width: 100,
                                height: 20,
                                isColor: false,
                                textSize: 12,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(height: 2.h),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _text({
    required String firstText,
    String? secondText,
    String? buttonText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomText(text: firstText, color: AppColors.primaryColor),
        ),
        Expanded(
          child: secondText != null
              ? CustomText(text: secondText, align: TextAlign.start)
              : Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 1.h,
                      ),
                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: CustomText(
                        text: buttonText!,
                        color: AppColors.textWhiteColor,
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
