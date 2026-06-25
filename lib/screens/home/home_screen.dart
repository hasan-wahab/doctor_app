import 'dart:async';
import 'dart:io';

import 'package:doctor_app/screens/home/bloc/home_bloc.dart';
import 'package:doctor_app/screens/home/bloc/home_event.dart';
import 'package:doctor_app/screens/home/bloc/home_state.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/heding_text.dart';
import 'package:doctor_app/widgets/outline_button.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../../data/models/all_packages_model.dart';
import '../../data/models/slider_model.dart';
import '../../widgets/home_appbar.dart';
import 'home_widget/packages_widget.dart';
import 'home_widget/second_slider.dart';
import 'home_widget/slider_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController1;
  late PageController _pageController2;
  int currentValue1 = 0;
  int currentValue2 = 0;
  late Timer _timer;
  AllPackagesModel? allPackagesModel;
  SliderModel? sliderModel;
  bool isLoading = false;
  String? message;

  @override
  void initState() {
    context.read<HomeBloc>().add(HomeLoadEvent());
    _pageController1 = PageController(initialPage: currentValue1);
    _pageController2 = PageController(initialPage: currentValue2);
    sliderController(_pageController1, currentValue1);
    sliderController(_pageController2, currentValue2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoadingState) {
          isLoading = true;
        }
        if (state is HomeMessageState) {
          isLoading = false;
          message = state.message;
          print(state.message?.isEmpty);
          AppMsg.showSnackBar(context, message: state.message.toString());
        }
        if (state is HomeLoadState) {
          isLoading = false;
          allPackagesModel = state.allPackagesModel;
          sliderModel = state.sliderModel;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: HomeAppBar(),
          body:
              isLoading != true &&
                  allPackagesModel != null &&
                  sliderModel != null
              ? ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  children: [
                    SizedBox(height: 15.h),
                    FirstSlider(
                      sliderModel: sliderModel,
                      currentValue: currentValue1,
                      controller: _pageController1,
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeadingText(text: 'Therapy Session Packages'),
                        InkWell(
                          onTap: () {
                            context.push(AppRoutes.allPackagesScreen);
                          },
                          child: CustomText(
                            text: 'View all',
                            color: AppColors.secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 9.h),
                    AllPackagesWidget(packages: allPackagesModel!),
                    SizedBox(height: 12.h),

                    SizedBox(height: 20.h),
                    SecondSlider(
                      controller: _pageController2,
                      currentValue: currentValue2,
                    ),
                  ],
                )
              : isLoading
              ? Center(child: CircularProgressIndicator())
              : SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    spacing: 10.h,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: message == 'No internet connection!'
                            ? message!
                            : 'No data',
                      ),
                      InkWell(
                        onTap: () =>
                            context.read<HomeBloc>().add(HomeLoadEvent()),
                        child: Icon(Icons.refresh),
                      ),
                    ],
                  ),
                ),

          backgroundColor: AppColors.bgColor,
          floatingActionButton: InkWell(
            onTap: () async {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => Material(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.r),
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height / 2.5,
                      width: MediaQuery.sizeOf(context).width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.r),
                            child: Row(
                              children: [
                                CustomText(
                                  text: 'Please Select WhatsApp',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () => context.pop(context),
                                  child: Icon(
                                    Icons.close,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h),

                          Divider(),
                          SizedBox(height: 10.h),

                          InkWell(
                            onTap: () => _launchWhatsApp(
                              message: "I need help",
                              number: "+92334 8199990",
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.r),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 40.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/what_app_image.png',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  CustomText(
                                    text: 'Clinic 1 Near IDC F8',
                                    style: TextStyle(
                                      color: AppColors.firstTextBlackColor,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 18.r,
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          InkWell(
                            onTap: () => _launchWhatsApp(
                              message: "I need help",
                              number: "+923086776666",
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.r),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 40.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/what_app_image.png',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  CustomText(
                                    text: 'Clinic 2 PMC Plaza F8',
                                    style: TextStyle(
                                      color: AppColors.firstTextBlackColor,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 18.r,
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          InkWell(
                            onTap: () => _launchWhatsApp(
                              message: "I need help",
                              number: "+92331 8181681",
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.r),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 40.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/what_app_image.png',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  CustomText(
                                    text: 'Clinic 3 Neuro Stroke PMC F8',
                                    style: TextStyle(
                                      color: AppColors.firstTextBlackColor,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 18.r,
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Container(
              height: 68.h,
              width: 68.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/what_app_image.png'),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }

  void sliderController(PageController controller, int currentValue) {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      if (controller.hasClients) {
        setState(() {
          if (currentValue < 3) {
            currentValue++;
          } else {
            currentValue = 0;
          }
        });
        controller.animateToPage(
          currentValue,
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeIn,
        );
      }
    });
  }

  void _launchWhatsApp({
    required String message,
    required String number,
  }) async {
    var newMessage = Uri.encodeComponent(message);
    try {
      if (Platform.isAndroid) {
        String androidUrl = 'whatsapp://send?phone=$number&text=$newMessage';
        await launchUrl(Uri.parse(androidUrl));
      } else if (Platform.isIOS) {
        String iosUrl = 'https://wa.me/$number?text=$newMessage';
        await launchUrl(Uri.parse(iosUrl));
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController1.dispose();
    _pageController2.dispose();
    super.dispose();
  }
}
