import 'package:doctor_app/core/app_keys/api_keys.dart';
import 'package:doctor_app/data/models/current_patient_model.dart';
import 'package:doctor_app/repos/patient_local_repo/patient_local_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_routes/routes_name.dart';
import '../../../core/app_styles/app_colors.dart';
import '../../../data/api_service/api_service.dart';
import '../../../data/local_storage/local_storage.dart';
import '../../../data/models/all_packages_model.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/heding_text.dart';
import '../../../widgets/outline_button.dart';

class AllPackagesWidget extends StatefulWidget {
  AllPackagesModel packages;
  AllPackagesWidget({super.key, required this.packages});

  @override
  State<AllPackagesWidget> createState() => _AllPackagesWidgetState();
}

class _AllPackagesWidgetState extends State<AllPackagesWidget> {
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
                        child: ClipOval(
                          child: Image.network(
                            headers: {'Authorization': 'Bearer sdfsadf'},
                            "${ApiKeys.baseUrl}/${widget.packages.packages[index].displayImage}",
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, obj, err) {
                              return Icon(
                                Icons.image,
                                color: AppColors.primaryColor,
                              );
                            },
                          ),
                        ),
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
                      Navigator.pushNamed(context, AppRoutes.loginScreen);
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
}
