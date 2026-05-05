import 'dart:convert';

import 'package:doctor_app/data/models/all_packages_model.dart';

import 'package:doctor_app/screens/all_packages_screen/widgets/all_packages_appbar.dart';
import 'package:doctor_app/screens/home/bloc/home_bloc.dart';
import 'package:doctor_app/screens/home/bloc/home_event.dart';
import 'package:doctor_app/screens/home/bloc/home_state.dart';
import 'package:doctor_app/widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_keys/api_keys.dart';
import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../../data/api_service/api_service.dart';
import '../../data/local_storage/local_storage.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/outline_button.dart';
import '../../widgets/show_msg.dart';
import '../home/home_widget/packages_widget.dart';

class AllPackagesScreen extends StatefulWidget {
  const AllPackagesScreen({super.key});

  @override
  State<AllPackagesScreen> createState() => _AllPackagesScreenState();
}

class _AllPackagesScreenState extends State<AllPackagesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<HomeBloc>().add(HomeLoadEvent());
  }

  bool isLoading = false;
  AllPackagesModel? allPackagesModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoadingState) {
          isLoading = true;
        }
        if (state is HomeMessageState) {
          isLoading = false;
          AppMsg.showSnackBar(context, message: state.message.toString());
        }
        if (state is HomeLoadState) {
          isLoading = false;
          allPackagesModel = state.allPackagesModel;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AllPackagesAppbar(
            onChanged: (value) {
              // var searchQuery = data.where((test) {
              //   final name = test?.name!.toLowerCase();
              //   final result = name.contains(value!.toLowerCase());
              //   return result;
              // });
              // searchResult = searchQuery.toList();
            },
          ),
          body: SafeArea(
            child: isLoading != true && allPackagesModel != null
                ? Padding(
                    padding: EdgeInsets.only(
                      top: 36.h,
                      left: 20.w,
                      right: 20.w,
                    ),
                    child: GridView.builder(
                      itemCount: allPackagesModel!.totalCount,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryColor,

                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                  child: ClipOval(
                                    child: Image.network(
                                      headers: {
                                        'Authorization': 'Bearer sdfsadf',
                                      },
                                      "${ApiKeys.baseUrl}/${allPackagesModel!.packages[index].displayImage}",
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
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
                                CustomText(
                                  maxLines: 4,
                                  text: allPackagesModel!
                                      .packages[index]
                                      .displayName,
                                  // text: searchResult.isEmpty
                                  //     ? packages[index]
                                  //     : searchResult[index].name.toString(),
                                  fontSize: 12,
                                ),
                              ],
                            ),

                            AppOutlineButton(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.loginScreen,
                                );
                              },
                              text: 'Book',
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
