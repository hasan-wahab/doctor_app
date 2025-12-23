import 'dart:convert';

import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/app_styles/app_colors.dart';
import 'package:doctor_app/models/current_patient_model.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_api_service/auth_api_services.dart';
import 'package:doctor_app/screens/auth_screen/login_screen/auth_model/login_model_1.dart';
import 'package:doctor_app/screens/book_appoinment_screen/appointment_detail_screen.dart';
import 'package:doctor_app/screens/dashboard_screen/dashboard_chart.dart';
import 'package:doctor_app/widgets/app_t_field.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../local_storage/local_storage.dart';
import '../../widgets/app_button.dart';

class DashbordScreen extends StatefulWidget {
  const DashbordScreen({super.key});

  @override
  State<DashbordScreen> createState() => _DashbordScreenState();
}

class _DashbordScreenState extends State<DashbordScreen> {
  bool isLoading = false;
  bool isObscureBalanceText = true;
  late int totalSession;
  late int usedSession;

  @override
  void initState() {
    getCurrentUserDataFromApi();
    super.initState();
  }

  final List<IconData> icons = [
    Icons.remove_red_eye,
    Icons.payment,
    Icons.warning_amber_outlined,
    Icons.remove_red_eye,
    Icons.payment,
    Icons.warning_amber_outlined,
  ];

  List<String> cardText = [
    'Visits',
    'Active packages',
    'Assessments',
    'Invoice',
    'Sessions',
    'Assistant Manager',
  ];
  List<String> screenNameList = [
    AppRoutes.visitsDetailScreen,
    AppRoutes.packagesDetailScreen,
    AppRoutes.assessmentScreen,
    AppRoutes.invoiceDetailScreen,
    AppRoutes.sessionsDetailScreen,
    AppRoutes.assistantManagerScreen,
  ];
  LoginModel1? profileData;
  CurrentPatientModel? currentPatientData;
  @override
  Widget build(BuildContext context) {
    totalSession = 8;
    usedSession = 5;
    List colorsList = List.generate((usedSession), (index) {
      return usedSession != 0
          ? AppColors.primaryColor
          : AppColors.secondaryColor;
    });
    List colorsList2 = List.generate((totalSession - usedSession), (index) {
      return AppColors.secondaryColor;
    });
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : currentPatientData != null
          ? SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  await getCurrentUserDataFromApi();
                },
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.myProfileScreen,
                                );
                              },
                              child: Container(
                                height: 50.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      profileData!.user!.profilePicture
                                          .toString(),
                                    ),
                                  ),
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                    width: 2.w,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200.w,
                                  child: CustomText(
                                    text:
                                        'Hi, ${profileData!.user!.name.toString()}',
                                    fontSize: 18,
                                  ),
                                ),
                                CustomText(
                                  text:
                                      '0${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}',
                                  fontSize: 12,
                                  color: AppColors.secondaryTextColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.searchScreen,
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: AppColors.secondaryColor,
                            child: Icon(
                              CupertinoIcons.search,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),

                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.secondaryColor,

                              child: Icon(
                                CupertinoIcons.bell,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Container(
                              height: 10.h,
                              width: 10.h,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 24.67.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      height: 80.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            Colors.greenAccent.shade200,
                            AppColors.bgColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColors.whiteIconColor,
                        border: Border.fromBorderSide(
                          BorderSide(color: AppColors.primaryColor),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Balance',
                                fontSize: 16,
                                color: AppColors.textWhiteColor,
                              ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 10,
                                children: [
                                  CustomText(
                                    text: isObscureBalanceText != true
                                        ? 'PKR 3000.00'
                                        : '* * * * * *',
                                    fontSize: 20,
                                    color: AppColors.textWhiteColor,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isObscureBalanceText =
                                            !isObscureBalanceText;
                                      });
                                    },
                                    child: isObscureBalanceText
                                        ? Icon(
                                            Icons.visibility_off,
                                            size: 18.r,
                                            color: AppColors.whiteIconColor,
                                          )
                                        : Icon(
                                            Icons.visibility,
                                            size: 18.r,
                                            color: AppColors.whiteIconColor,
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          AppButton(
                            borderRadius: BorderRadius.circular(8.r),
                            text: 'Recharge wallet',
                            width: 110,
                            isColor: false,
                            height: 34,
                            textSize: 11,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.rechargeScreen,
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10.h),

                    CustomText(text: 'Quick Overview', fontSize: 14),
                    SizedBox(height: 10.h),

                    SizedBox(
                      height: 200.h,

                      child: Center(
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                crossAxisCount: 2,
                                mainAxisExtent: 55.h,
                              ),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            List cardSecondText = [
                              currentPatientData!.patient!.visits!.length
                                  .toString(),
                              currentPatientData!.patient!.packages!.length
                                  .toString(),
                              '',
                              currentPatientData!.recentInvoices!.length
                                  .toString(),
                              currentPatientData!.therapySessions!.length
                                  .toString(),
                              '',
                            ];

                            return InkWell(
                              onTap: () async {
                                Navigator.pushNamed(
                                  context,
                                  screenNameList[index],
                                  arguments: <String, CurrentPatientModel>{
                                    "data": currentPatientData!,
                                  },
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 5.h,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                    width: 1,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          cardSecondText[index] != ''
                                          ? MainAxisAlignment.spaceBetween
                                          : MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 100.w,
                                          child: CustomText(
                                            text: cardText[index],
                                            fontSize: 12,
                                          ),
                                        ),
                                        cardSecondText[index] != ''
                                            ? SizedBox(
                                                width: 100.w,
                                                child: CustomText(
                                                  text: cardSecondText[index],
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                    Icon(icons[index]),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(text: 'Patient overview', fontSize: 14),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    DashboardChartsCustom(),
                    SizedBox(height: 10.h),

                    /// Session Progress
                    CustomText(text: 'Session Progress'),
                    SizedBox(height: 10.h),

                    ...List.generate(
                      currentPatientData!.patient.packages.length,

                      (index) {
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: 10.h
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.h,
                            vertical: 10,
                          ),
                          height: 110.h,
                          width: 360.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              width: 2,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: 'adsfsadf', fontSize: 12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: 'Sessions Progress',
                                    fontSize: 12,
                                    color: AppColors.secondaryTextColor,
                                  ),
                                  CustomText(
                                    text: '$usedSession/$totalSession',
                                    fontSize: 10,
                                  ),
                                ],
                              ),

                              Container(
                                height: 5.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [...colorsList, ...colorsList2],
                                  ),

                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: 'Next Session',
                                    fontSize: 15,
                                  ),
                                  CustomText(
                                    text: currentPatientData!
                                        .therapySessions
                                        .first
                                        .nextSessionDate
                                        .toString(),
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          : Center(child: Text('No Data Found')),
    );
  }

  getCurrentUserDataFromApi() async {
    setState(() {
      isLoading = true;
    });
    final token = await LocalStorage.getUserToken('token');
    final currentUserData = await LocalStorage.getProfileData(token!);

    final jsonData = jsonDecode(currentUserData!);

    profileData = LoginModel1.fromJson(jsonData);

    currentPatientData = await AuthApiServices.getPatientData(
      patientId: profileData!.patientData!.patientInfo!.id.toString(),
      currentUserToken: profileData!.accessToken.toString(),
      context: context,
    );

    setState(() {
      isLoading = false;
    });
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
}
