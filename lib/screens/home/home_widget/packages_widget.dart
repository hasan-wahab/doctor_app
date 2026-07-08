import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/repos/patient_local_repo/patient_local_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_routes/routes_name.dart';
import '../../../core/app_styles/app_colors.dart';
import '../../../core/extentions/internect_connectivity.dart';
import '../../../data/api_service/api_service.dart';
import '../../../data/local_storage/local_storage.dart';
import '../../../data/models/all_packages_model.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/heding_text.dart';
import '../../../widgets/outline_button.dart';
import '../../../widgets/show_msg.dart';

class AllPackagesWidget extends StatefulWidget {
  AllPackagesModel packages;
  bool hasInternet;
  AllPackagesWidget({
    super.key,
    required this.packages,
    this.hasInternet = false,
  });

  @override
  State<AllPackagesWidget> createState() => _AllPackagesWidgetState();
}

class _AllPackagesWidgetState extends State<AllPackagesWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      width: 351.w,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 15.w,
          children: [
            ...List.generate((4), (index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 100.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          color: AppColors.secondaryColor,
                        ),
                        child: !isLoading
                            ? widget.hasInternet
                                  ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10.r,
                            ),
                            border: Border.all(
                              color: AppColors.primaryColor,
                            ),
                          ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10.r),
                                        child: Image.network(
                                          fit: BoxFit.cover,
                                          "${ApiKeys.allPackegesImagesUrl}/${widget.packages.packages[index].displayImage}",
                                          loadingBuilder:
                                              (context, child, loading) {
                                                if (loading != null) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                return child;
                                              },
                                          errorBuilder: (context, obj, err) {
                                            return Center(
                                              child: CustomText(
                                                text: 'Image not\nfound!',
                                                color: AppColors
                                                    .secondaryTextColor,
                                                align: TextAlign.center,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                  )
                                  : Center(
                                      child: CustomText(
                                        align: TextAlign.center,
                                        maxLines: 3,
                                        text: 'No Internet\nImage not found!',
                                      ),
                                    )
                            : Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        width: 100.w,
                        child: CustomText(
                          text: widget.packages.packages[index].displayName,

                          maxLines: 4,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  AppOutlineButton(
                    onTap: () {
                      AppMsg.showErrorMsg(
                        context,
                        msg:
                            'Please sign in first to book this therapy package.',
                        msgTitle: 'Confirmation',
                        actionText: 'Cancel',
                        actionText2: 'Login',
                        action: () => context.pop(context),
                        action2: () {
                          context.pop(context);
                          context.push(AppRoutes.loginScreen);
                        },
                      );
                    },
                    text: 'Book',
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  void internetChecking() async {
    isLoading = true;
    setState(() {});
    if (await InternetUtils.isInternetAvailable()) {
      if (!context.mounted) return;
      isLoading = false;
      setState(() {});
    } else {
      if (!mounted) return;
      AppMsg.showSnackBar(context, message: 'No Internet Connection !');
      isLoading = false;
      setState(() {});
    }
  }
}
