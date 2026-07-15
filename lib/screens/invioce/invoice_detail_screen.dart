import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_state.dart'
    show ProfileState, ProfileLoadingState, MyProfileState, ProfileMessageState;
import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/app_t_field.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
import '../../data/models/current_patient_model.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/row_text.dart';
import '../../widgets/show_msg.dart';
import '../profile_screens/bloc/profile_state.dart' show ProfileState;

class InvoiceDetailScreen extends StatefulWidget {
  const InvoiceDetailScreen({super.key});

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  CurrentPatientModel? currentPatientData;
  var isExpanded;
  double remainingPayments = 0;
  bool isLoading = false;

  @override
  void initState() {
    context.read<ProfileBloc>().add(MyProfileEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadingState) {
          isLoading = true;
        } else if (state is MyProfileState) {
          isLoading = false;

          currentPatientData = state.currentPatientModel;
          isExpanded = List.generate(
            currentPatientData!.recentInvoices.length,
            (index) {
              return false;
            },
          );
        } else if (state is ProfileMessageState) {
          isLoading = false;

          AppMsg.showErrorMsg(context, msg: state.message.toString());
        }
      },
      builder: (context, state) {
        return isLoading != true
            ? Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.bgColor,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                  centerTitle: true,
                  title: Text('Invoice'),
                  automaticallyImplyLeading: false,
                ),
                backgroundColor: AppColors.bgColor,
                body: SafeArea(
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    children: [
                      CustomText(
                        text: 'Billing History',
                        fontSize: 20,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(height: 17.h),

                      currentPatientData != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: List.generate(currentPatientData!.recentInvoices.length, (
                                index,
                              ) {
                                String invoiceCardNumber = (index + 1)
                                    .toString();
                                var invoice =
                                    currentPatientData!.recentInvoices[index];
                                return Card(
                                  margin: EdgeInsets.only(top: 15.h),
                                  color: AppColors.secondaryColor,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: 15.w,
                                      right: 15.w,
                                      top: 20.h,
                                    ),

                                    width: 360.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      //  border: Border.all(color: AppColors.primaryColor, width: 2),
                                    ),

                                    child: Column(
                                      spacing: 10.h,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RowText(
                                          firstText: 'Invoice #',
                                          secondText: invoiceCardNumber,
                                        ),
                                        RowText(
                                          firstText: 'Invoice Id',
                                          secondText: invoice.displayId,
                                        ),

                                        RowText(
                                          firstText: 'Create At',
                                          secondText:
                                              DateAndTimeFormater.dateFormat(
                                                invoice.createdAt.toString(),
                                              ),
                                        ),
                                        RowText(
                                          firstText: 'Update At',
                                          secondText:
                                              DateAndTimeFormater.dateFormat(
                                                invoice.createdAt.toString(),
                                              ),
                                        ),
                                        RowText(
                                          firstText: 'Type',
                                          buttonText: invoice.type,
                                        ),
                                        RowText(
                                          firstText: 'Total amount',
                                          secondText: invoice.amount!
                                              .toString(),
                                        ),
                                        RowText(
                                          firstText: 'Status',
                                          buttonText: invoice.status,
                                        ),
                                        RowText(
                                          firstText: 'Discount Amount',
                                          buttonText:
                                              invoice.displayDiscountAmount,
                                        ),

                                        isExpanded[index] == true
                                            ? Column(
                                                children: [
                                                  Divider(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: CustomText(
                                                          text: 'Paid Payments',
                                                          color: AppColors
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: CustomText(
                                                          text:
                                                              'Remaining Payments',
                                                          color: AppColors
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ...List.generate(
                                                              invoice
                                                                  .payments
                                                                  .length,
                                                              (index) {
                                                                return CustomText(
                                                                  text: double.parse(
                                                                    invoice
                                                                        .payments[index]
                                                                        .amount
                                                                        .toString(),
                                                                  ).toInt().toString(),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CustomText(
                                                              text: remainingPayments
                                                                  .toInt()
                                                                  .toString(),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  Divider(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                ],
                                              )
                                            : Container(),

                                        SizedBox(height: 5.h),
                                        invoice.status != 'paid'
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  AppButton(
                                                    onTap: () {
                                                      setState(() {
                                                        isExpanded[index] =
                                                            !isExpanded[index];
                                                      });
                                                    },
                                                    text:
                                                        isExpanded[index] ==
                                                            true
                                                        ? 'see less'
                                                        : 'see more',
                                                    width: 100,
                                                    height: 20,
                                                    isColor: false,
                                                    textSize: 12,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          5,
                                                        ),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                        SizedBox(height: 2.h),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            )
                          : Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              )
            : Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
