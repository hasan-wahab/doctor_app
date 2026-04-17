
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
  AllPackagesWidget({super.key});

  @override
  State<AllPackagesWidget> createState() => _AllPackagesWidgetState();
}

class _AllPackagesWidgetState extends State<AllPackagesWidget> {
  String? token;

  @override
  void initState() {
    getTokenValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiServices.getAllPackagesData(context),
      builder: (context, snap) {
        if (snap.hasData) {
          List<AllPackagesModel>? packages = snap.data;
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
                              child: packages![index].image != null
                                  ? ClipOval(
                                      child: Image.network(
                                        packages[index].image.toString(),
                                      ),
                                    )
                                  : Icon(
                                      Icons.image,
                                      size: 30.r,
                                      color: AppColors.primaryColor,
                                    ),
                            ),
                            SizedBox(
                              width: 100.w,
                              child: CustomText(
                                text: packages[index].name.toString(),
                                maxLines: 4,

                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        AppOutlineButton(
                          onTap: () {
                            if (token == null) {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.loginScreen,
                              );
                            }
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
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void getTokenValue() async {
    token = await LocalStorage.getUserToken('token');
  }
}
