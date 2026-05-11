import 'package:doctor_app/core/app_styles/app_colors.dart';
import 'package:doctor_app/widgets/app_button.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('Location'),
        centerTitle: true,
        backgroundColor: AppColors.bgColor,
      ),
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            spacing: 20.h,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                maxLines: 3,
                text: 'Tap on the map marker to open in Google Maps',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),

              Card(
                child: InkWell(
                  onTap: openMap,
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.8,
                    child: Image.asset(
                      'assets/images/map.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              AppButton(onTap: openMap, text: 'Open in Google Maps'),
            ],
          ),
        ),
      ),
    );
  }

  void openMap() async {
    final String url =
        'https://www.google.com/maps/place/Dr+Ali+Therapy+Pvt+Ltd+ISO+certified+-best+chiropractor+Physiotherapist+in+Islamabad/data=!4m2!3m1!1s0x0:0x287e188a6765e906?sa=X&ved=1t:2428&ictx=111';
    if (await urlLauncher.canLaunchUrl(Uri.parse(url))) {
      await urlLauncher.launchUrl(Uri.parse(url));
    }
  }
}
