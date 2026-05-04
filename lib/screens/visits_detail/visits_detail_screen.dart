import 'package:doctor_app/data/models/all_visits_model.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/screens/visits_detail/bloc/visit_detail_bloc.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_styles/app_colors.dart';
import '../../data/models/current_patient_model.dart';
import '../../widgets/row_text.dart';
import '../../widgets/show_msg.dart';
import '../profile_screens/bloc/profile_bloc.dart';
import '../profile_screens/bloc/profile_state.dart';
import 'bloc/visit_detail_event.dart';
import 'bloc/visit_detail_state.dart';

class VisitsDetailScreen extends StatefulWidget {
  const VisitsDetailScreen({super.key});

  @override
  State<VisitsDetailScreen> createState() => _VisitsDetailScreenState();
}

class _VisitsDetailScreenState extends State<VisitsDetailScreen> {
  AllVisitsModel? allVisitsModel;
  bool isLoading = false;

  @override
  void initState() {
    context.read<VisitDetailBloc>().add(VisitDetailApiAndLocalEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VisitDetailBloc, VisitDetailState>(
      listener: (context, state) {
        if (state is VisitDetailLoadingState) {
          isLoading = true;
        }
        if (state is VisitDetailMessageState) {
          isLoading = false;
          AppMsg.showErrorMsg(context, msg: state.message.toString());
        }
        if (state is AllVisitDatilsListState) {
          isLoading = false;
          allVisitsModel = state.model;
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async => context.read<VisitDetailBloc>().add(
            VisitDetailJustFromServerEvent(),
          ),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.bgColor,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              centerTitle: true,
              title: Text('My visit'),
              automaticallyImplyLeading: false,
            ),
            backgroundColor: AppColors.bgColor,
            body: isLoading == false && allVisitsModel != null
                ? allVisitsModel!.visits.isNotEmpty
                      ? ListView(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                          children: [
                            CustomText(
                              text: 'Visit History',
                              fontSize: 20,
                              color: AppColors.primaryColor,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: List.generate(
                                allVisitsModel!.visits.length,
                                (index) {
                                  final currentPatient = allVisitsModel!.visits;
                                  return Container(
                                    margin: EdgeInsets.only(top: 10.h),
                                    height: 178.h,
                                    width: 360.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),

                                    child: Card(
                                      margin: EdgeInsets.zero,
                                      color: AppColors.secondaryColor,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 12.h,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RowText(
                                              firstText: 'Date',
                                              secondText:
                                                  DateAndTimeFormater.dateFormat(
                                                    currentPatient[index]
                                                        .displayDate,
                                                  ),
                                            ),
                                            RowText(
                                              firstText: 'Type',
                                              buttonText: currentPatient[index]
                                                  .displayType
                                                  .toString(),
                                            ),
                                            RowText(
                                              firstText: 'Doctor',
                                              secondText: currentPatient[index]
                                                  .displayDoctor,
                                            ),
                                            RowText(
                                              firstText: 'Stage',
                                              secondText: currentPatient[index]
                                                  .displayStage,
                                            ),
                                            RowText(
                                              firstText: 'Amount',
                                              secondText: currentPatient[index]
                                                  .displayConsultationFee,
                                            ),
                                            RowText(
                                              firstText: 'Status',
                                              secondText: currentPatient[index]
                                                  .displayStatus,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : Center(child: Text('No data'))
                : Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
