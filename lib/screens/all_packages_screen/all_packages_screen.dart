import 'dart:convert';



import 'package:doctor_app/data/models/all_packages_model.dart';

import 'package:doctor_app/screens/all_packages_screen/package_model.dart';
import 'package:doctor_app/screens/all_packages_screen/widgets/all_packages_appbar.dart';
import 'package:doctor_app/widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../../data/api_service/api_service.dart';
import '../../data/local_storage/local_storage.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/outline_button.dart';
import '../home/home_widget/packages_widget.dart';

class AllPackagesScreen extends StatefulWidget {
  const AllPackagesScreen({super.key});

  @override
  State<AllPackagesScreen> createState() => _AllPackagesScreenState();
}

class _AllPackagesScreenState extends State<AllPackagesScreen> {
  List<AllPackagesModel> packages = [];
  List<AllPackagesModel> searchResult = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiServices.getAllPackagesData(context),
      builder: (context, snap) {
        if (snap.hasData) {
          var data = snap.data!;
          packages = snap.data!;
          return Scaffold(
            appBar: AllPackagesAppbar(
              onChanged: (value) {
                // var searchQuery = data.where((test) {
                //   final name = test?.name!.toLowerCase();
                //   final result = name.contains(value!.toLowerCase());
                //   return result;
                // });
               // searchResult = searchQuery.toList();
                setState(() {});
              },
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 36.h, left: 20.w, right: 20.w),
              child: GridView.builder(
                itemCount: searchResult.isEmpty
                    ? packages.length
                    : searchResult.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 210.h,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.w,
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 100.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor,

                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: packages[index].image != null
                                ? ClipOval(
                                    child: Image.network(
                                      packages[index].image != null
                                          ? packages[index].image.toString()
                                          : searchResult[index].image
                                                .toString(),
                                    ),
                                  )
                                : Icon(
                                    Icons.image,
                                    size: 30.r,
                                    color: AppColors.primaryColor,
                                  ),
                          ),
                          CustomText(
                            maxLines: 4,
                            text: searchResult.isEmpty
                                ? packages[index].name.toString()
                                : searchResult[index].name.toString(),
                            fontSize: 12,
                          ),
                        ],
                      ),

                      AppOutlineButton(
                        onTap: () async {
                          final user = await LocalStorage.getUserToken('token');
                          if (user == null) {
                            if (context.mounted) {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.loginScreen,
                              );
                            }
                          }
                        },
                        text: 'Book',
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
