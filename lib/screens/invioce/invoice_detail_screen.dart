import 'package:doctor_app/screens/invioce/widgets/billing_header.dart';
import 'package:doctor_app/screens/invioce/widgets/billing_invoice_card.dart';
import 'package:doctor_app/screens/invioce/widgets/billing_payments_section.dart';
import 'package:doctor_app/screens/invioce/widgets/billing_summary_card.dart';
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
  int totalInvoice = 0;
  List<InvoiceModel> invoiceList = [];
  List<PaymentModel> paymentList = [];

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
          totalInvoice = currentPatientData?.recentInvoices.length ?? 0;
          invoiceList = currentPatientData?.recentInvoices ?? [];
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
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        context.read<ProfileBloc>().add(MyProfileEvent()),
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      children: [
                        SizedBox(height: 20.h),

                        ...List.generate((totalInvoice), (index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: BillingInvoiceCard(
                              invoiceNo: invoiceList[index].id.toString(),
                              date: DateAndTimeFormater.dateFormat(
                                invoiceList[index].createdAt,
                              ),
                              type: invoiceList[index].type ?? '',
                              amount:
                                  invoiceList[index].amount?.toString() ??
                                  '0.0',
                              discount:
                                  invoiceList[index].discountAmount
                                      ?.toString() ??
                                  '0.0',
                              paid:
                                  invoiceList[index].paidAmount?.toString() ??
                                  '0.0',
                              due:
                                  invoiceList[index].remainingAmount
                                      ?.toString() ??
                                  '0.0',
                              payStatus: invoiceList[index].computedStatus
                                  .toString(),
                              payments: List.generate(
                                (invoiceList[index].payments.length),
                                (generator) {
                                  return BillingPaymentItem(
                                    paymentId: invoiceList[index]
                                        .payments[generator]
                                        .displayId,
                                    date: DateAndTimeFormater.dateFormat(
                                      invoiceList[index]
                                          .payments[generator]
                                          .displayCreatedAt,
                                    ),
                                    amount:
                                        invoiceList[index]
                                            .payments[generator]
                                            .amount
                                            ?.toString() ??
                                        '0.0',
                                    method: invoiceList[index]
                                        .payments[generator]
                                        .displayMethod,
                                    type: invoiceList[index]
                                        .payments[generator]
                                        .displayType,
                                  );
                                },
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              )
            : Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
