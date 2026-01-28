import 'dart:convert';

import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../api_service/api_service.dart';
import '../../local_storage/local_storage.dart';
import '../../models/current_patient_model.dart';
import '../auth_screen/login_screen/auth_model/login_model_1.dart';

class SessionNotes extends StatefulWidget {
  const SessionNotes({super.key});

  @override
  State<SessionNotes> createState() => _SessionNotesState();
}

class _SessionNotesState extends State<SessionNotes> {
  bool isLoading = false;
  CurrentPatientModel? currentPatientData;
  bool isVisitDetail = false;
  Map<String, int>? index;

  @override
  void didChangeDependencies() {
    getPatientData();
    index = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || currentPatientData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final visits = List.from(currentPatientData!.patient!.visits);
    final therapySessions = List.from(currentPatientData!.therapySessions);

    visits.sort((a, b) => a.visitAt.compareTo(b.visitAt));

    return Scaffold(

      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text('Visit detail'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          spacing: visits[index!['index'] ?? 0].consultantAssessment != null
              ? 20.h
              : 0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            visits[index!['index'] ?? 0].historyTaker != null
                ? InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.assessmentScreen,
                        arguments: {"consultant": visits[index!['index'] ?? 0]},
                      );
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: AppColors.secondaryColor,
                        child: Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'History Tracker',
                                color: AppColors.primaryColor,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 14.r,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            visits[index!['index'] ?? 0].consultantAssessment != null
                ? InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.assistantManagerScreen,
                        arguments: {
                          "amAssessments": visits[index!['index'] ?? 0],
                        },
                      );
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: AppColors.secondaryColor,
                        child: Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'Assistant Manager Assessment',
                                color: AppColors.primaryColor,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 14.r,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            visits[index!['index'] ?? 0].consultantAssessment != null
                ? InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.assessmentScreen,
                        arguments: {"consultant": visits[index!['index'] ?? 0]},
                      );
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: AppColors.secondaryColor,
                        child: Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'Consultant Assessment',
                                color: AppColors.primaryColor,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 14.r,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),

            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.sessionsDetailScreen,
                  arguments: {
                    "therapySession": therapySessions[index!['index'] ?? 0],
                  },
                );
              },
              child: SizedBox(
                width: double.infinity,
                height: 55.h,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: AppColors.secondaryColor,
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Therapy Session',
                          color: AppColors.primaryColor,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 14.r,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _text({
    required String firstText,
    String? secondText,
    String? buttonText,
  }) {
    return Column(
      spacing: 5.h,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: firstText),
        secondText != null
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
      ],
    );
  }

  Future<void> getPatientData() async {
    setState(() => isLoading = true);

    final currentUserToken = await LocalStorage.getUserToken('token');
    final currentUserData = await LocalStorage.getUserToken(currentUserToken!);

    final jsonData = jsonDecode(currentUserData!);
    LoginModel1 data = LoginModel1.fromJson(jsonData);

    final patientId = data.patientData!.patientInfo!.id;

    currentPatientData = await ApiServices.getPatientData(
      patientId: patientId.toString(),
      currentUserToken: currentUserToken,
      context: context,
    );

    setState(() => isLoading = false);
  }
}
