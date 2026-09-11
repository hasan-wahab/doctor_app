import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_styles/app_colors.dart';
import '../../core/app_styles/app_sizes.dart';
import '../../core/app_styles/app_text_styles.dart';
import '../../data/models/all_packages_model.dart';
import '../../widgets/app_app_bar.dart';
import '../../widgets/app_pull_refresh.dart';
import '../../widgets/app_shimmer.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/show_msg.dart';
import '../home/bloc/home_bloc.dart';
import '../home/bloc/home_event.dart';
import '../home/bloc/home_state.dart';
import '../home/home_widget/packages_widget.dart';

class AllPackagesScreen extends StatefulWidget {
  const AllPackagesScreen({super.key, this.hasInternet = false});

  final bool hasInternet;

  @override
  State<AllPackagesScreen> createState() => _AllPackagesScreenState();
}

class _AllPackagesScreenState extends State<AllPackagesScreen> {
  AllPackagesModel? _packages;
  bool _refreshing = false;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeLoadEvent());
  }

  Future<void> _onRefresh() async {
    final bloc = context.read<HomeBloc>();
    final done = bloc.stream.firstWhere(
      (state) => state is HomeLoadState || state is HomeMessageState,
    );
    bloc.add(HomeLoadEvent(forceRefresh: true));
    await done;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoadingState) {
          _refreshing = _packages != null;
        } else {
          _refreshing = false;
        }
        if (state is HomeMessageState) {
          AppMsg.showSnackBar(context, message: state.message.toString());
        }
        if (state is HomeLoadState) {
          _packages = state.allPackagesModel;
        }
      },
      builder: (context, state) {
        final firstLoad = _packages == null && state is HomeLoadingState;
        final appBarLoading = firstLoad || _refreshing;

        return Scaffold(
          backgroundColor: AppColors.screenBgColor,
          appBar: AppAppBar(
            title: 'All packages',
            showBack: true,
            isLoading: appBarLoading,
          ),
          body: firstLoad
              ? const AppListShimmer()
              : AppPullRefresh(
                  enabled: !appBarLoading,
                  onRefresh: _onRefresh,
                  child: _body(state),
                ),
        );
      },
    );
  }

  Widget _body(HomeState state) {
    final items = _packages?.packages;
    if (items != null) {
      if (items.isEmpty) {
        return ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: AppSizes.pageInsets,
          children: [
            SizedBox(height: AppSizes.buttonHeight * 3),
            Center(
              child: CustomText(
                text: 'No packages',
                style: AppTextStyles.body,
              ),
            ),
          ],
        );
      }

      final columns = AppSizes.isTablet(context) ? 3 : 2;
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppSizes.contentMaxWidth(context),
          ),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: AppSizes.pageInsets,
            children: [
              for (var i = 0; i < items.length; i += columns) ...[
                if (i > 0) SizedBox(height: AppSizes.gapMd),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var j = 0; j < columns; j++) ...[
                      if (j > 0) SizedBox(width: AppSizes.gapMd),
                      Expanded(
                        child: i + j < items.length
                            ? PackageCard(package: items[i + j])
                            : const SizedBox(),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      );
    }

    final message = state is HomeMessageState ? state.message : null;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: AppSizes.pageInsets,
      children: [
        SizedBox(height: AppSizes.buttonHeight * 3),
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
}
