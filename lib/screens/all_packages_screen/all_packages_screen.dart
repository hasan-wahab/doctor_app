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
  bool hasInternet;
  AllPackagesScreen({super.key, this.hasInternet = false});

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
  String? message;
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
          message = state.message.toString();
          AppMsg.showSnackBar(context, message: state.message.toString());
        }
        if (state is HomeLoadState) {
          isLoading = false;
          allPackagesModel = state.allPackagesModel;
          print(allPackagesModel!.packages.map((e) => e.displayImage));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: AppBar(
            backgroundColor: AppColors.bgColor,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new),
            ),
            foregroundColor: AppColors.primaryColor,
            centerTitle: true,
            title: Text('All packages'),
            automaticallyImplyLeading: false,
          ),
          body: isLoading != true && allPackagesModel != null
              ? SafeArea(
                  child: Padding(
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
                                  child: !isLoading
                                      ? widget.hasInternet
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        10.r,
                                                      ),
                                                  border: Border.all(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        10.sp,
                                                      ),
                                                  child: Image.network(
                                                    fit: BoxFit.cover,
                                                    "${ApiKeys.allPackegesImagesUrl}/${allPackagesModel?.packages[index].displayImage}",
                                                    loadingBuilder:
                                                        (
                                                          context,
                                                          child,
                                                          loading,
                                                        ) {
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
                                                          text:
                                                              'Image not\nfound!',
                                                          color: AppColors
                                                              .secondaryTextColor,
                                                          align:
                                                              TextAlign.center,
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
                                                  text:
                                                      'No Internet\nImage not found!',
                                                ),
                                              )
                                      : Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                ),
                                CustomText(
                                  maxLines: 4,
                                  text: allPackagesModel!
                                      .packages[index]
                                      .displayName,
                                  fontSize: 12,
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
                                  action: () => Navigator.pop(context),
                                  action2: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.loginScreen,
                                    );
                                  },
                                );
                              },
                              text: 'Book',
                            ),
                          ],
                        );
                      },
                    ),
                  ),
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
        );
      },
    );
  }
}
