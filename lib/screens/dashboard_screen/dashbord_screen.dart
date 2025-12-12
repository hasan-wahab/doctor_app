import 'dart:convert';

import 'package:doctor_app/app_routes/routes_name.dart';
import 'package:doctor_app/app_styles/app_colors.dart';
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
    'Total Spent',
    'Next appointment',
    'Therapy Seesions',
    'Last appointment',
  ];

  LoginModel1? profileData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
              children: [
                SizedBox(height: 66.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.myProfileScreen);
                      },
                      child: Container(
                        height: 39.h,
                        width: 39.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              profileData!.user!.profilePicture.toString(),
                            ),
                          ),
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 2.w,
                          ),
                        ),
                      ),
                    ),

                    CustomText(text: 'Dashboard', fontSize: 24),

                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        CircleAvatar(
                          child: Icon(
                            CupertinoIcons.bell,
                            color: AppColors.secondaryTextColor,
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
                SizedBox(height: 16.h),

                AppTField(
                  hintText: 'Search therapists,payment..',
                  icon: Icon(Icons.search),
                ),
                SizedBox(height: 24.67.h),
                SizedBox(
                  height: 200.h,

                  child: Center(
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        crossAxisCount: 2,
                        mainAxisExtent: 58.h,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        List cardSecondText = [
                          profileData!.patientData!.statistics!.totalVisits
                              .toString(),
                          profileData!.patientData!.statistics!.activePackages
                              .toString(),
                          profileData!.patientData!.statistics!.totalSpent
                              .toString(),
                          profileData!
                              .patientData!
                              .statistics!
                              .nextAppointmentDate
                              .toString(),
                          profileData!
                              .patientData!
                              .statistics!
                              .totalTherapySessions
                              .toString(),
                          profileData!.patientData!.statistics!.lastVisitDate
                              .toString(),
                        ];

                        return Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 100.w,
                                    child: CustomText(text: cardText[index]),
                                  ),
                                  SizedBox(
                                    width: 100.w,
                                    child: CustomText(
                                      text: cardSecondText[index],
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(icons[index]),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 24.67.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: 'Therapist Accounts', fontSize: 20),
                    CustomText(text: 'See all'),
                  ],
                ),
                SizedBox(height: 10.h),

                Container(
                  padding: EdgeInsets.only(
                    top: 11.h,
                    left: 20.w,
                    right: 12.w,
                    bottom: 10.h,
                  ),
                  height: 137.h,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: AppColors.primaryColor),
                    color: AppColors.bgColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 58.h,
                            width: 58.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/profile_image.png',
                                ),
                              ),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 2.w,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Dr.Smith',
                                fontSize: 20,
                                color: AppColors.firstTextBlackColor,
                              ),
                              CustomText(
                                text: 'Physiotherapist',
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 14.h,
                                    color: Colors.yellow,
                                  ),
                                  CustomText(
                                    text: '4.8',
                                    fontSize: 12,
                                    color: AppColors.blackIconColor,
                                  ),
                                ],
                              ),
                              CustomText(
                                text: 'Clinic',
                                color: AppColors.firstTextBlackColor,
                              ),
                            ],
                          ),
                          CustomText(text: '2000 PKR'),
                          SizedBox(height: 5.h),

                          AppButton(
                            onTap: () {},
                            height: 40,
                            text: 'View Account',
                            width: 153,
                            textSize: 13,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 46.h),
                DashboardChartsCustom(),
              ],
            ),
    );
  }

  getCurrentUserDataFromApi() async {
    setState(() {
      isLoading = true;
    });
    final token = await LocalStorage.getUserToken('token');
    final currentUserData = await LocalStorage.getProfileData(token!);
    final currentUserPassword = await LocalStorage.getProfileData('password');

    final jsonData = jsonDecode(currentUserData!);

    String email = jsonData['user']['email'];

    await AuthApiServices.loginApi(
      context,
      email: email,
      password: currentUserPassword.toString(),
      isLoginCall: false,
    );
    final currentUpdateData = await LocalStorage.getProfileData(token);

    final jsonData2 = jsonDecode(currentUpdateData!);

    profileData = LoginModel1.fromJson(jsonData2);
    setState(() {
      isLoading = false;
    });
  }
}
