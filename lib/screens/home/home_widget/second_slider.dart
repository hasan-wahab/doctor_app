import 'package:doctor_app/core/extentions/internect_connectivity.dart';
import 'package:doctor_app/screens/video_palyer/data/app_video_playlist.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_routes/routes_name.dart';
import '../../../core/app_styles/app_colors.dart';

class SecondSlider extends StatefulWidget {
  int currentValue;
  PageController controller = PageController();
  bool hasInternet;
  SecondSlider({
    super.key,
    required this.controller,
    required this.currentValue,
    this.hasInternet = false,
  });

  @override
  State<SecondSlider> createState() => _SecondSliderState();
}

class _SecondSliderState extends State<SecondSlider> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final videos = AppVideoPlaylist.items;

    return InkWell(
      onTap: () async {
        isLoading = true;
        setState(() {});
        if (await InternetUtils.isInternetAvailable()) {
          if (!context.mounted) return;
          context.push(AppRoutes.videoPlayerScreen, extra: widget.currentValue);
          isLoading = false;
          setState(() {});
        } else {
          if (!context.mounted) return;
          AppMsg.showSnackBar(context, message: 'No Internet Connection !');
          isLoading = false;
          setState(() {});
        }
      },
      child: SizedBox(
        height: 188.h,
        child: PageView(
          onPageChanged: (value) async {
            widget.currentValue = value;
            setState(() {});
          },
          controller: widget.controller,
          scrollDirection: Axis.horizontal,
          children: List.generate(videos.length, (index) {
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(13.sp),
                  height: 188.h,
                  width: 346.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                  child: !isLoading
                      ? widget.hasInternet
                            ? Container(
                                alignment: Alignment.center,
                                height: 120.h,
                                width: 319.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      AppVideoPlaylist.thumbnailAt(index),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Align(
                                alignment: Alignment.topCenter,
                                child: CustomText(
                                  align: TextAlign.center,
                                  text:
                                      'No Internet connection!\nVideo Not Found!',
                                ),
                              )
                      : SizedBox(),
                ),
                Align(
                  alignment: Alignment.center,
                  child: isLoading
                      ? CircularProgressIndicator()
                      : widget.hasInternet
                      ? Icon(
                          Icons.play_circle_fill,
                          size: 50,
                          color: AppColors.secondaryColor,
                        )
                      : InkWell(
                          onTap: () async {
                            isLoading = true;
                            setState(() {});
                            if (await InternetUtils.isInternetAvailable()) {
                              if (!context.mounted) return;
                              context.push(
                                AppRoutes.videoPlayerScreen,
                                extra: widget.currentValue,
                              );
                              widget.hasInternet = true;
                              isLoading = false;
                              setState(() {});
                            } else {
                              if (!context.mounted) return;
                              AppMsg.showSnackBar(
                                context,
                                message: 'No Internet Connection !',
                              );
                              isLoading = false;
                              setState(() {});
                            }
                          },
                          child: Icon(Icons.refresh),
                        ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
