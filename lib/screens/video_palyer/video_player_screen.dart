import 'package:doctor_app/core/app_styles/app_colors.dart';
import 'package:doctor_app/core/app_styles/app_sizes.dart';
import 'package:doctor_app/core/app_styles/app_text_styles.dart';
import 'package:doctor_app/screens/video_palyer/controller/video_player_screen_controller.dart';
import 'package:doctor_app/screens/video_palyer/data/app_video_playlist.dart';
import 'package:doctor_app/screens/video_palyer/widgets/no_internet_overlay.dart';
import 'package:doctor_app/screens/video_palyer/widgets/playlist_tile.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:doctor_app/widgets/network_media.dart';
import 'package:doctor_app/widgets/show_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final int videoIndex;

  const VideoPlayerScreen({super.key, this.videoIndex = 0});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final VideoPlayerScreenController _controller;
  final ScrollController _playlistScrollController = ScrollController();
  late final List<GlobalKey> _tileKeys;
  bool _immersive = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerScreenController(
      playlist: AppVideoPlaylist.items,
      initialIndex: widget.videoIndex,
    );
    _tileKeys = List.generate(
      AppVideoPlaylist.items.length,
      (_) => GlobalKey(),
    );
    _controller.onInternetRestored = _showInternetRestoredSnackbar;
    SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentVideo();
    });
  }

  void _scrollToCurrentVideo() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final index = _controller.currentIndex;
      if (index < 0 || index >= _tileKeys.length) return;
      final ctx = _tileKeys[index].currentContext;
      if (ctx == null) return;
      Scrollable.ensureVisible(
        ctx,
        alignment: 0.12,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    });
  }

  void _showInternetRestoredSnackbar() {
    if (!mounted) return;
    AppMsg.success(context, 'Internet restored. Playback can continue.');
  }

  Future<void> _setImmersive(bool value) async {
    if (_immersive == value) return;
    setState(() => _immersive = value);
    if (value) {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      await SystemChrome.setPreferredOrientations(const [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      await SystemChrome.setPreferredOrientations(const [
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }

  Future<void> _handleBack() async {
    if (_immersive) {
      await _setImmersive(false);
      return;
    }
    if (mounted) context.pop();
  }

  @override
  void dispose() {
    _controller.dispose();
    _playlistScrollController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations(const [DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final tablet = AppSizes.isTablet(context);
        final landscape = AppSizes.isLandscape(context);
        final player = _youtubePlayer();

        return PopScope(
          canPop: !_immersive,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) return;
            _handleBack();
          },
          child: Scaffold(
            backgroundColor: _immersive || landscape
                ? AppColors.firstTextBlackColor
                : AppColors.screenBgColor,
            body: _immersive
                ? _buildImmersive(player)
                : landscape
                ? _buildSplit(player, tablet: tablet)
                : _buildStacked(player),
          ),
        );
      },
    );
  }

  Widget _youtubePlayer() {
    return YoutubePlayer(
      key: ValueKey(_controller.playerGeneration),
      aspectRatio: 16 / 9,
      controller: _controller.youtubeController,
      showVideoProgressIndicator: true,
      progressIndicatorColor: AppColors.primaryColor,
      progressColors: ProgressBarColors(
        playedColor: AppColors.primaryColor,
        handleColor: AppColors.primaryColor,
        bufferedColor: AppColors.primaryColor.withValues(alpha: 0.3),
      ),
      topActions: [
        IconButton(
          onPressed: _handleBack,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.whiteIconColor,
            size: AppSizes.iconLg,
          ),
        ),
      ],
      bottomActions: [
        const CurrentPosition(),
        const ProgressBar(isExpanded: true),
        const RemainingDuration(),
        IconButton(
          onPressed: () => _setImmersive(!_immersive),
          icon: Icon(
            _immersive
                ? Icons.fullscreen_exit_rounded
                : Icons.fullscreen_rounded,
            color: AppColors.whiteIconColor,
            size: AppSizes.iconLg,
          ),
        ),
      ],
    );
  }

  Widget _buildStacked(Widget player) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ColoredBox(
          color: AppColors.firstTextBlackColor,
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [_buildHeader(light: false), _buildPlayerFrame(player)],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: AppSizes.contentMaxWidth(context),
              ),
              child: _buildPlaylistPanel(showMeta: true, dense: false),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSplit(Widget player, {required bool tablet}) {
    final playlist = ColoredBox(
      color: AppColors.screenBgColor,
      child: SafeArea(
        left: false,
        child: _buildPlaylistPanel(showMeta: false, dense: !tablet),
      ),
    );

    final playerPane = ColoredBox(
      color: AppColors.firstTextBlackColor,
      child: SafeArea(
        right: false,
        child: Column(
          children: [
            _buildHeader(light: false),
            Expanded(child: _fittedPlayer(player)),
            _buildNowPlayingMeta(dark: true, compact: true),
          ],
        ),
      ),
    );

    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: tablet ? 5 : 3, child: playerPane),
        Expanded(flex: tablet ? 3 : 2, child: playlist),
      ],
    );

    if (!tablet) return row;

    return ColoredBox(
      color: AppColors.screenBgColor,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppSizes.contentMaxWidth(context),
          ),
          child: row,
        ),
      ),
    );
  }

  Widget _buildImmersive(Widget player) {
    return ColoredBox(
      color: AppColors.firstTextBlackColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _fittedPlayer(player),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(AppSizes.gapMd),
                child: Material(
                  color: AppColors.firstTextBlackColor.withValues(alpha: 0.45),
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: _handleBack,
                    child: Padding(
                      padding: EdgeInsets.all(AppSizes.spaceMd),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: AppSizes.iconMd,
                        color: AppColors.textWhiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader({required bool light}) {
    final color = light
        ? AppColors.firstTextBlackColor
        : AppColors.textWhiteColor;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSizes.pagePaddingH,
        AppSizes.spaceSm,
        AppSizes.pagePaddingH,
        AppSizes.spaceSm,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: _handleBack,
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            child: Padding(
              padding: EdgeInsets.all(AppSizes.spaceXs),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: AppSizes.iconMd,
                color: color,
              ),
            ),
          ),
          SizedBox(width: AppSizes.gapSm),
          Expanded(
            child: CustomText(
              text: 'Doctor Insights',
              style: AppTextStyles.appBarTitle.copyWith(color: color),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fittedPlayer(Widget player) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth;
        final maxH = constraints.maxHeight;
        if (maxW <= 0 || maxH <= 0) return const SizedBox.shrink();
        final widthFromHeight = maxH * 16 / 9;
        final width = widthFromHeight <= maxW ? widthFromHeight : maxW;
        final height = width * 9 / 16;
        return Center(
          child: SizedBox(
            width: width,
            height: height,
            child: _buildPlayerFrame(player, expand: true),
          ),
        );
      },
    );
  }

  Widget _buildPlayerFrame(Widget player, {bool expand = false}) {
    final stack = Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        Hero(
          tag: AppVideoPlaylist.heroTag(widget.videoIndex),
          child: Material(
            color: AppColors.firstTextBlackColor,
            child: NetworkMedia(
              url: _controller.currentItem.thumbnailUrl,
              emptyMessage: 'Video unavailable',
              emptyIcon: Icons.videocam_off_outlined,
            ),
          ),
        ),
        player,
        if (_controller.isOffline)
          NoInternetOverlay(onRetry: _controller.retryConnection),
        if (_controller.hasPlayerError && !_controller.isOffline)
          _buildPlayerErrorOverlay(),
        if (_controller.isPlayerLoading &&
            !_controller.isOffline &&
            !_controller.hasPlayerError)
          ColoredBox(
            color: AppColors.firstTextBlackColor.withValues(alpha: 0.28),
            child: Center(
              child: SizedBox(
                height: AppSizes.iconXl,
                width: AppSizes.iconXl,
                child: CircularProgressIndicator(
                  color: AppColors.textWhiteColor,
                ),
              ),
            ),
          )
        else if (_controller.isBuffering && !_controller.isOffline)
          IgnorePointer(
            child: ColoredBox(
              color: AppColors.firstTextBlackColor.withValues(alpha: 0.2),
              child: Center(
                child: SizedBox(
                  height: AppSizes.iconXl,
                  width: AppSizes.iconXl,
                  child: CircularProgressIndicator(
                    color: AppColors.textWhiteColor,
                  ),
                ),
              ),
            ),
          ),
      ],
    );

    if (expand) return stack;
    return AspectRatio(aspectRatio: 16 / 9, child: stack);
  }

  Widget _buildNowPlayingMeta({required bool dark, required bool compact}) {
    final item = _controller.currentItem;
    final titleColor = dark
        ? AppColors.textWhiteColor
        : AppColors.firstTextBlackColor;
    final descColor = dark
        ? AppColors.textWhiteColor.withValues(alpha: 0.72)
        : AppColors.labelTextColor;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSizes.pagePaddingH,
        compact ? AppSizes.spaceSm : AppSizes.spaceXl,
        AppSizes.pagePaddingH,
        compact ? AppSizes.spaceMd : 0,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: Column(
          key: ValueKey(_controller.currentIndex),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: item.title,
              style: AppTextStyles.name.copyWith(color: titleColor),
              maxLines: compact ? 1 : 2,
              textOverflow: TextOverflow.ellipsis,
            ),
            if (!compact) ...[
              SizedBox(height: AppSizes.spaceSm),
              CustomText(
                text: item.description,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w500,
                  color: descColor,
                ),
                maxLines: 3,
                textOverflow: TextOverflow.visible,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPlaylistPanel({required bool showMeta, required bool dense}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showMeta) _buildNowPlayingMeta(dark: false, compact: false),
        if (showMeta) SizedBox(height: AppSizes.spaceXxl),
        Padding(
          padding: EdgeInsets.fromLTRB(
            AppSizes.pagePaddingH,
            showMeta ? 0 : AppSizes.spaceXl,
            AppSizes.pagePaddingH,
            0,
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomText(text: 'Up next', style: AppTextStyles.name),
              ),
              CustomText(
                text: '${_controller.playlist.length} videos',
                style: AppTextStyles.label.copyWith(
                  color: AppColors.labelTextColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSizes.spaceMd),
        Expanded(
          child: ListView.builder(
            controller: _playlistScrollController,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              AppSizes.pagePaddingH,
              0,
              AppSizes.pagePaddingH,
              AppSizes.pagePaddingBottom,
            ),
            itemCount: _controller.playlist.length,
            itemBuilder: (context, index) {
              return KeyedSubtree(
                key: _tileKeys[index],
                child: PlaylistTile(
                  item: _controller.playlist[index],
                  isSelected: _controller.currentIndex == index,
                  dense: dense,
                  onTap: () {
                    _controller.switchVideo(index);
                    _scrollToCurrentVideo();
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerErrorOverlay() {
    return ColoredBox(
      color: AppColors.firstTextBlackColor.withValues(alpha: 0.78),
      child: Padding(
        padding: AppSizes.authInsets,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: AppColors.textWhiteColor,
              size: AppSizes.iconXl,
            ),
            SizedBox(height: AppSizes.spaceXl),
            CustomText(
              text: _controller.playerError ?? 'Unable to play this video.',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textWhiteColor,
              ),
              align: TextAlign.center,
              maxLines: 3,
              textOverflow: TextOverflow.visible,
            ),
            SizedBox(height: AppSizes.spaceXxl),
            SizedBox(
              height: AppSizes.buttonHeightSm,
              child: ElevatedButton.icon(
                onPressed: _controller.retryVideoLoad,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.textWhiteColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                ),
                icon: Icon(Icons.refresh_rounded, size: AppSizes.iconSm),
                label: Text('Try again', style: AppTextStyles.button),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
