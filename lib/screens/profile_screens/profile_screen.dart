import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_bloc.dart';
import 'package:doctor_app/screens/nave_bar/bloc/nave_bar_event.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_bloc.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_event.dart';
import 'package:doctor_app/screens/profile_screens/bloc/profile_state.dart';
import 'package:doctor_app/screens/profile_screens/widgets/profile_ui.dart';
import 'package:doctor_app/widgets/app_app_bar.dart';
import 'package:doctor_app/widgets/app_empty_state.dart';
import 'package:doctor_app/widgets/app_pull_refresh.dart';
import 'package:doctor_app/widgets/app_shimmer.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../../core/app_styles/app_sizes.dart';
import '../../core/functions.dart';
import '../../data/models/current_patient_model.dart';
import '../auth_screen/login_screen/auth_model/login_model_1.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  Future<void> _openPrivacy() async {
    final url = Uri.parse('https://dralitherapy.com/privacy-policy/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _logout() async {
    final ok = await AppMsg.confirm(
      context,
      title: 'Logout',
      message: 'Are you sure you want to log out?',
      cancelLabel: 'No',
      confirmLabel: 'Yes',
      icon: Icons.logout_rounded,
    );
    if (ok && mounted) {
      context.read<NaveBarBloc>().add(NaveBarLogoutEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          context.read<NaveBarBloc>().add(NaveBarIndexEvent(index: 0));
        }
      },
      child: BlocConsumer<ProfileBloc, ProfileState>(
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
          final firstLoad = isLoading && profileData == null;
          final appBarLoading = isLoading || isRefreshing;
          final patient = currentPatientData?.patient;

          return Scaffold(
            backgroundColor: AppColors.screenBgColor,
            appBar: AppAppBar(
              title: 'Profile',
              showBack: true,
              isLoading: appBarLoading,
              onBack: () {
                context.read<NaveBarBloc>().add(NaveBarIndexEvent(index: 0));
              },
            ),
            body: firstLoad
                ? const AppListShimmer()
                : profileData == null || patient == null
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
                              name: patient.user?.displayName ??
                                  patient.displayName,
                              patientId: profileData!.user?.id.toString() ??
                                  patient.displayId,
                              imageUrl: patient.displayImageUrl,
                              token: profileData!.accessToken,
                            ),
                            SizedBox(height: AppSizes.spaceXxl),
                            ProfileGroupCard(
                              children: [
                                ProfileMenuTile(
                                  icon: Icons.person_outline_rounded,
                                  label: 'My Profile',
                                  onTap: () => context.push(
                                    AppRoutes.myProfileScreen,
                                  ),
                                ),
                                if (showNfcCard)
                                  ProfileMenuTile(
                                    icon: Icons.credit_card_outlined,
                                    label: 'My Card',
                                    onTap: () => context.push(
                                      AppRoutes.myNFCCardScreen,
                                      extra: true,
                                    ),
                                  ),
                                ProfileMenuTile(
                                  icon: Icons.location_on_outlined,
                                  label: 'Location',
                                  onTap: () =>
                                      context.push(AppRoutes.mapScreen),
                                ),
                                ProfileMenuTile(
                                  icon: Icons.policy_outlined,
                                  label: 'Privacy Policy',
                                  onTap: _openPrivacy,
                                ),
                              ],
                            ),
                            SizedBox(height: AppSizes.spaceXxl),
                            ProfileGroupCard(
                              children: [
                                ProfileMenuTile(
                                  icon: Icons.logout_rounded,
                                  label: 'Log Out',
                                  iconColor: AppColors.dueRedColor,
                                  labelColor: AppColors.dueRedColor,
                                  onTap: _logout,
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
      ),
    );
  }
}
