import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctor_app/core/extentions/internect_connectivity.dart';
import 'package:doctor_app/screens/home/bloc/home_bloc.dart';
import 'package:doctor_app/screens/home/bloc/home_event.dart';
import 'package:doctor_app/screens/home/bloc/home_state.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_routes/routes_name.dart';
import '../../core/app_styles/app_colors.dart';
import '../../core/app_styles/app_sizes.dart';
import '../../core/app_styles/app_text_styles.dart';
import '../../widgets/app_pull_refresh.dart';
import '../../widgets/home_appbar.dart';
import '../../widgets/network_media.dart';
import 'home_widget/home_shimmer.dart';
import 'home_widget/packages_widget.dart';
import 'home_widget/second_slider.dart';
import 'home_widget/slider_widget.dart';

const _clinics = [
  (title: 'Clinic 1 Near IDC F8', number: '+92334 8199990'),
  (title: 'Clinic 2 PMC Plaza F8', number: '+923086776666'),
  (title: 'Clinic 3 Neuro Stroke PMC F8', number: '+92331 8181681'),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription<List<ConnectivityResult>>? _netSub;
  bool _hasInternet = false;
  int _mediaRefreshToken = 0;
  bool _refreshing = false;

  @override
  void initState() {
    super.initState();
    final homeBloc = context.read<HomeBloc>();
    if (homeBloc.state is! HomeLoadState) {
      homeBloc.add(HomeLoadEvent());
    }
    _checkInternet();
    _netSub = Connectivity().onConnectivityChanged.listen((_) {
      _checkInternet();
    });
  }

  @override
  void dispose() {
    _netSub?.cancel();
    super.dispose();
  }

  Future<void> _checkInternet() async {
    final value = await InternetUtils.isInternetAvailable();
    if (mounted && value != _hasInternet) {
      setState(() => _hasInternet = value);
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      _refreshing = true;
      _mediaRefreshToken++;
    });
    final bloc = context.read<HomeBloc>();
    final done = bloc.stream.firstWhere(
      (state) => state is HomeLoadState || state is HomeMessageState,
    );
    bloc.add(HomeLoadEvent(forceRefresh: true));
    await _checkInternet();
    await done;
    if (mounted) {
      setState(() => _refreshing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeMessageState) {
          AppMsg.showSnackBar(context, message: state.message.toString());
        }
      },
      builder: (context, state) {
        final firstLoad = state is! HomeLoadState && state is! HomeMessageState;
        return Scaffold(
          backgroundColor: AppColors.screenBgColor,
          appBar: HomeAppBar(isLoading: firstLoad || _refreshing),
          body: AppPullRefresh(
            enabled: !firstLoad && !_refreshing,
            onRefresh: _onRefresh,
            child: firstLoad ? const HomeShimmer() : _body(state),
          ),
          floatingActionButton: firstLoad ? null : _chatButton(),
        );
      },
    );
  }

  Widget _body(HomeState state) {
    if (state is HomeLoadState &&
        state.allPackagesModel != null &&
        state.sliderModel != null) {
      final images = state.sliderModel!.expand((s) => s.images).toList();
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppSizes.contentMaxWidth(context),
          ),
          child: MediaRefresh(
            token: _mediaRefreshToken,
            child: ListView(
              clipBehavior: Clip.none,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: AppSizes.pagePaddingTop,
                bottom: AppSizes.pagePaddingBottom,
              ),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.pagePaddingH,
                  ),
                  child: FirstSlider(images: images),
                ),
                SizedBox(height: AppSizes.spaceXxl),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.pagePaddingH,
                  ),
                  child: _header(
                    'Therapy Session Packages',
                    'View all',
                    () => context.push(
                      AppRoutes.allPackagesScreen,
                      extra: _hasInternet,
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.spaceMd),
                AllPackagesWidget(packages: state.allPackagesModel!),
                SizedBox(height: AppSizes.spaceXxl),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.pagePaddingH,
                  ),
                  child: _header(
                    'Doctor Insights & Stories',
                    'Watch all',
                    () => _openVideos(),
                  ),
                ),
                SizedBox(height: AppSizes.spaceMd),
                SecondSlider(),
              ],
            ),
          ),
        ),
      );
    }

    final message = state is HomeMessageState ? state.message : null;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.35),
        Center(
          child: Column(
            children: [
              CustomText(
                text: message == 'No internet connection!'
                    ? message!
                    : 'No data',
                style: AppTextStyles.body,
              ),
              SizedBox(height: AppSizes.spaceMd),
              IconButton(
                onPressed: () => context.read<HomeBloc>().add(HomeLoadEvent()),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _header(String title, String action, VoidCallback onTap) {
    return Row(
      children: [
        Expanded(
          child: CustomText(
            text: title,
            style: AppTextStyles.name,
            maxLines: 1,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: action,
                style: AppTextStyles.chipPrimary.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: AppSizes.iconSm,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _chatButton() {
    return GestureDetector(
      onTap: _showClinics,
      child: Container(
        height: AppSizes.buttonHeight,
        width: AppSizes.buttonHeight,
        padding: EdgeInsets.all(AppSizes.spaceSm),
        decoration: BoxDecoration(
          color: AppColors.bgColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.firstTextBlackColor.withValues(alpha: 0.12),
              blurRadius: AppSizes.spaceXl,
              offset: Offset(0, AppSizes.spaceXs),
            ),
          ],
        ),
        child: Image.asset(
          'assets/images/what_app_image.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Future<void> _openVideos() async {
    if (await InternetUtils.isInternetAvailable()) {
      if (mounted) context.push(AppRoutes.videoPlayerScreen, extra: 0);
    } else if (mounted) {
      AppMsg.warning(
        context,
        'Looks like you are offline. Please check your connection and try again.',
      );
    }
  }

  void _showClinics() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.bgColor,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusMd),
        ),
      ),
      builder: (context) => _WhatsAppClinicsSheet(
        clinics: _clinics,
        onSelect: (number) async {
          context.pop();
          await _openWhatsApp(number);
        },
      ),
    );
  }

  Future<void> _openWhatsApp(String number) async {
    final text = Uri.encodeComponent('I need help');
    try {
      if (Platform.isAndroid) {
        await launchUrl(Uri.parse('whatsapp://send?phone=$number&text=$text'));
      } else if (Platform.isIOS) {
        await launchUrl(Uri.parse('https://wa.me/$number?text=$text'));
      }
    } on Exception {
      // Keep previous behavior: ignore launch failures.
    }
  }
}

class _WhatsAppClinicsSheet extends StatelessWidget {
  const _WhatsAppClinicsSheet({required this.clinics, required this.onSelect});

  final List<({String title, String number})> clinics;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppSizes.contentMaxWidth(context),
          ),
          child: Padding(
            padding: AppSizes.pageInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: AppSizes.logoSize,
                  height: AppSizes.spaceXs,
                  decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                ),
                SizedBox(height: AppSizes.spaceXl),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Chat on WhatsApp',
                            style: AppTextStyles.name,
                          ),
                          SizedBox(height: AppSizes.spaceXs),
                          CustomText(
                            text: 'Select a clinic to start a conversation',
                            style: AppTextStyles.bodySmall.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.labelTextColor,
                            ),
                            maxLines: 2,
                            textOverflow: TextOverflow.visible,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => context.pop(),
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      child: Padding(
                        padding: EdgeInsets.all(AppSizes.spaceXs),
                        child: Icon(
                          Icons.close_rounded,
                          size: AppSizes.iconMd,
                          color: AppColors.labelTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.spaceXxl),
                for (var i = 0; i < clinics.length; i++) ...[
                  if (i > 0) SizedBox(height: AppSizes.spaceMd),
                  _ClinicTile(
                    title: clinics[i].title,
                    number: clinics[i].number,
                    onTap: () => onSelect(clinics[i].number),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ClinicTile extends StatelessWidget {
  const _ClinicTile({
    required this.title,
    required this.number,
    required this.onTap,
  });

  final String title;
  final String number;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.sectionBgColor,
      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.gapLg,
            vertical: AppSizes.spaceXl,
          ),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/what_app_image.png',
                  height: AppSizes.buttonHeightSm,
                  width: AppSizes.buttonHeightSm,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: AppSizes.gapMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      textOverflow: TextOverflow.visible,
                    ),
                    SizedBox(height: AppSizes.spaceXs),
                    CustomText(
                      text: number,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.labelTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppSizes.gapSm),
              Icon(
                Icons.chevron_right_rounded,
                size: AppSizes.iconLg,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
