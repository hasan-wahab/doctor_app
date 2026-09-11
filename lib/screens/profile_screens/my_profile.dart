import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_state.dart';
import 'package:doctor_app/screens/profile_screens/widgets/profile_ui.dart';
import 'package:doctor_app/widgets/app_app_bar.dart';
import 'package:doctor_app/widgets/app_empty_state.dart';
import 'package:doctor_app/widgets/app_pull_refresh.dart';
import 'package:doctor_app/widgets/app_shimmer.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/date_time_foemat.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../../core/app_styles/app_sizes.dart';
import '../../core/app_styles/app_text_styles.dart';
import '../../data/models/current_patient_model.dart';
import '../auth_screen/login_screen/auth_model/login_model_1.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  LoginModel1? profileData;
  CurrentPatientModel? currentPatientData;
  bool isLoading = false;
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(MyProfileEvent());
  }

  Future<void> _onRefresh() async {
    final bloc = context.read<ProfileBloc>();
    final done = bloc.stream.firstWhere(
      (s) => s is MyProfileState || s is ProfileMessageState,
    );
    bloc.add(MyProfileEvent());
    await done;
  }

  void _openUpdate() {
    context.push(AppRoutes.updateProfile);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadingState) {
          if (profileData == null) {
            isLoading = true;
          } else {
            isRefreshing = true;
          }
        } else if (state is MyProfileState) {
          isLoading = false;
          isRefreshing = false;
          profileData = state.profileData;
          currentPatientData = state.currentPatientModel;
        } else if (state is ProfileMessageState) {
          isLoading = false;
          isRefreshing = false;
          AppMsg.showSnackBar(context, message: state.message!);
        }
      },
      builder: (context, state) {
        final firstLoad = isLoading && currentPatientData == null;
        final appBarLoading = isLoading || isRefreshing;
        final patient = currentPatientData?.patient;

        return Scaffold(
          backgroundColor: AppColors.screenBgColor,
          appBar: AppAppBar(
            title: 'My Profile',
            showBack: true,
            isLoading: appBarLoading,
            actions: patient == null
                ? null
                : [
                    IconButton(
                      onPressed: _openUpdate,
                      icon: Icon(
                        Icons.edit_outlined,
                        size: AppSizes.iconMd,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
          ),
          body: firstLoad
              ? const AppListShimmer()
              : patient == null || profileData == null
              ? AppEmptyRefreshView(
                  child: AppEmptyState(
                    title: 'Profile unavailable',
                    subtitle: 'Pull to refresh or try again.',
                    onRetry: () =>
                        context.read<ProfileBloc>().add(MyProfileEvent()),
                  ),
                )
              : Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: AppSizes.contentMaxWidth(context),
                    ),
                    child: AppPullRefresh(
                      enabled: !appBarLoading,
                      onRefresh: _onRefresh,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: AppSizes.pageInsets,
                        children: [
                          ProfileHeaderCard(
                            name: patient.displayName,
                            patientId: patient.displayId,
                            imageUrl: patient.displayImageUrl,
                            token: profileData!.accessToken,
                            badge: ProfileAvatarBadge(
                              icon: Icons.edit_outlined,
                              onTap: _openUpdate,
                            ),
                          ),
                          SizedBox(height: AppSizes.spaceXxl),
                          CustomText(
                            text: 'Personal details',
                            style: AppTextStyles.name,
                          ),
                          SizedBox(height: AppSizes.spaceMd),
                          ProfileGroupCard(
                            children: [
                              ProfileInfoTile(
                                icon: Icons.person_outline_rounded,
                                label: 'Name',
                                value: patient.displayName,
                              ),
                              ProfileInfoTile(
                                icon: Icons.phone_outlined,
                                label: 'Phone',
                                value: patient.displayPhone,
                              ),
                              ProfileInfoTile(
                                icon: patient.gender?.toLowerCase() == 'female'
                                    ? Icons.female_rounded
                                    : Icons.male_rounded,
                                label: 'Gender',
                                value: patient.gender?.toString() ?? '',
                              ),
                              ProfileInfoTile(
                                icon: Icons.calendar_month_outlined,
                                label: 'Date of birth',
                                value: DateAndTimeFormater.dateFormat(
                                  patient.displayBirthDate,
                                ),
                              ),
                              ProfileInfoTile(
                                icon: Icons.cake_outlined,
                                label: 'Age',
                                value: DateAndTimeFormater.calculateAge(
                                  patient.birthDate,
                                ).toString(),
                              ),
                              ProfileInfoTile(
                                icon: Icons.email_outlined,
                                label: 'Email',
                                value: patient.displayEmail,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
