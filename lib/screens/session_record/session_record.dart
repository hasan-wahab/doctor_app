import 'dart:convert';

import 'package:doctor_app/screens/auth_screen/login_screen/auth_api_service/auth_api_services.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:doctor_app/screens/nave_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_routes/routes_name.dart';
import '../../app_styles/app_colors.dart';
import '../../local_storage/local_storage.dart';
import '../../models/current_patient_model.dart';
import '../../widgets/app_button.dart';
import '../../widgets/custom_text.dart';

class SessionRecord extends StatefulWidget {
  const SessionRecord({super.key});

  @override
  State<SessionRecord> createState() => _SessionRecordState();
}

class _SessionRecordState extends State<SessionRecord> {
  bool isLoading = false;
  CurrentPatientModel? currentPatientData;
  bool isVisitDetail = false;

  @override
  void initState() {
    super.initState();
    getPatientData();
  }

  @override
  Widget build(BuildContext context) {
    /// loader
    if (isLoading || currentPatientData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final visits = List.from(currentPatientData!.patient!.visits);

    visits.sort((a, b) => a.visitAt.compareTo(b.visitAt));

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => NaveBar(currentIndex: 0)),
            (Route<dynamic> route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: isVisitDetail == true
                ? () {
                    setState(() {
                      isVisitDetail = false;
                    });
                  }
                : () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.naveBar,
                      (Route<dynamic> route) => false,
                    );
                  },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          centerTitle: true,
          title: Text(
            isVisitDetail == true ? 'Total visits' : 'Session Records',
          ),
          automaticallyImplyLeading: false,
        ),
        body: visits.isNotEmpty
            ? isVisitDetail == true
                  // Visit Records
                  ? RefreshIndicator(
                      onRefresh: () async => getPatientData(),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            children: [
                              SizedBox(height: 23.h),

                              ...List.generate(visits.length, (index) {
                                final visit = visits[index];

                                return Container(
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                    top: 11.h,
                                    left: 20.w,
                                    right: 12.w,
                                    bottom: 10.h,
                                  ),
                                  height: 120.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: AppColors.primaryColor,
                                    ),
                                    color: AppColors.bgColor,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Column(
                                    children: [
                                      /// TOP ROW
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text:
                                                    visit
                                                            .therapist
                                                            ?.name
                                                            .isNotEmpty ==
                                                        true
                                                    ? visit.therapist!.name
                                                    : 'no data',
                                                fontSize: 20,
                                                color: AppColors
                                                    .firstTextBlackColor,
                                              ),
                                              const CustomText(
                                                text: 'Physiotherapist',
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 20.r,
                                                color: Colors.amber,
                                              ),
                                              const CustomText(text: '4.5'),
                                            ],
                                          ),
                                        ],
                                      ),

                                      const Spacer(),

                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: visit.visitAt.toString(),
                                                fontSize: 15,
                                                color: AppColors
                                                    .secondaryTextColor,
                                              ),
                                              CustomText(
                                                text:
                                                    visit.type ??
                                                    'Cognitive Therapy',
                                                fontSize: 15,
                                                color: AppColors
                                                    .secondaryTextColor,
                                              ),
                                            ],
                                          ),
                                          AppButton(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            onTap: () => Navigator.pushNamed(
                                              context,
                                              AppRoutes.notesScreen,
                                            ),
                                            height: 33,
                                            text: 'Visit Details',
                                            width: 96,
                                            textSize: 13,
                                            isColor: false,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async => getPatientData(),
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: visits.length > 5
                              ? MediaQuery.sizeOf(context).height - 150
                              : null,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              children: [
                                SizedBox(height: 23.h),
                                ...List.generate(1, (index) {
                                  final visit = visits[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 10.h),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                      top: 11.h,
                                      left: 20.w,
                                      right: 12.w,
                                      bottom: 10.h,
                                    ),
                                    height: 120.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: AppColors.primaryColor,
                                      ),
                                      color: AppColors.bgColor,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Column(
                                      children: [
                                        /// TOP ROW
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text:
                                                      visit
                                                              .therapist
                                                              ?.name
                                                              .isNotEmpty ==
                                                          true
                                                      ? visit.therapist!.name
                                                      : 'no data',
                                                  fontSize: 20,
                                                  color: AppColors
                                                      .firstTextBlackColor,
                                                ),
                                                const CustomText(
                                                  text: 'Physiotherapist',
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  size: 20.r,
                                                  color: Colors.amber,
                                                ),
                                                const CustomText(text: '4.5'),
                                              ],
                                            ),
                                          ],
                                        ),

                                        const Spacer(),

                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: visit.visitAt
                                                      .toString(),
                                                  fontSize: 15,
                                                  color: AppColors
                                                      .secondaryTextColor,
                                                ),
                                                CustomText(
                                                  text:
                                                      visit.type ??
                                                      'Cognitive Therapy',
                                                  fontSize: 15,
                                                  color: AppColors
                                                      .secondaryTextColor,
                                                ),
                                              ],
                                            ),
                                            AppButton(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              onTap: () {
                                                setState(() {
                                                  isVisitDetail = true;
                                                });
                                              },
                                              height: 33,
                                              text: 'Consultation',
                                              width: 96,
                                              textSize: 13,
                                              isColor: false,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
            : Center(child: Text('No data')),
      ),
    );
  }

  /// 🔥 API CALL
  Future<void> getPatientData() async {
    setState(() => isLoading = true);

    final currentUserToken = await LocalStorage.getUserToken('token');
    final currentUserData = await LocalStorage.getUserToken(currentUserToken!);

    final jsonData = jsonDecode(currentUserData!);
    LoginModel1 data = LoginModel1.fromJson(jsonData);

    final patientId = data.patientData!.patientInfo!.id;

    currentPatientData = await AuthApiServices.getPatientData(
      patientId: patientId.toString(),
      currentUserToken: currentUserToken,
      context: context,
    );

    setState(() => isLoading = false);
  }
}
