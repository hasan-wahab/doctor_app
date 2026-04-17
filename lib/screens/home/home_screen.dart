import 'dart:async';
import 'dart:io';



import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/heding_text.dart';
import 'package:doctor_app/widgets/outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
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

  @override
  void initState() {
    super.initState();
    _pageController1 = PageController(initialPage: currentValue1);
    _pageController2 = PageController(initialPage: currentValue2);

    sliderController(_pageController1, currentValue1);
    sliderController(_pageController2, currentValue2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          SizedBox(height: 15.h),
          FirstSlider(
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
                  Navigator.pushNamed(context, AppRoutes.allPackagesScreen);
                },
                child: CustomText(
                  text: 'View all',
                  color: AppColors.secondaryTextColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 9.h),
          AllPackagesWidget(),
          SizedBox(height: 12.h),
          // FutureBuilder(
          //   future: ApiServices.getCoverPhoto(),
          //   builder: (context, snap) {
          //     var images = snap.data;
          //     return Container(
          //       height: 210.h,
          //       width: 350.w,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(12.r),
          //         image: DecorationImage(
          //           image: snap.data == null
          //               ? images!.data.isEmpty
          //                     ? AssetImage(
          //                         'assets/images/WhatsApp Image 2025-11-19 at 5.05.31 PM (1) 1.png',
          //                       )
          //                     : NetworkImage(images.data.first.toString())
          //               : AssetImage(
          //                   'assets/images/WhatsApp Image 2025-11-19 at 5.05.31 PM (1) 1.png',
          //                 ),
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     );
          //   },
          // ),
          SizedBox(height: 20.h),
          SecondSlider(
            controller: _pageController2,
            currentValue: currentValue2,
          ),
        ],
      ),

      backgroundColor: AppColors.bgColor,
      floatingActionButton: InkWell(
        onTap: () async {
          String number = '+923489446989';
          String message = Uri.encodeComponent("I need help");
          try {
            if (Platform.isAndroid) {
              String androidUrl = 'whatsapp://send?phone=$number&text=$message';
              await launchUrl(Uri.parse(androidUrl));
            } else if (Platform.isIOS) {
              String iosUrl = 'https://wa.me/$number?text=$message';
              await launchUrl(Uri.parse(iosUrl));
            }
          } on Exception catch (e) {
            print(e.toString());
          }
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

  @override
  void dispose() {
    _timer.cancel();
    _pageController1.dispose();
    _pageController2.dispose();
    super.dispose();
  }
}
