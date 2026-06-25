import 'package:doctor_app/core/app_styles/app_colors.dart';
import 'package:doctor_app/screens/video_palyer/data/app_video_playlist.dart';
import 'package:doctor_app/screens/video_palyer/controller/video_player_screen_controller.dart';
import 'package:doctor_app/screens/video_palyer/widgets/no_internet_overlay.dart';
import 'package:doctor_app/screens/video_palyer/widgets/playlist_tile.dart';
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerScreenController(
      playlist: AppVideoPlaylist.items,
      initialIndex: widget.videoIndex,
    );
    _controller.onInternetRestored = _showInternetRestoredSnackbar;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentVideo();
    });
  }

  void _scrollToCurrentVideo() {
    if (!_playlistScrollController.hasClients) return;
    final index = _controller.currentIndex;
    final offset = (index * 96.0).clamp(
      0.0,
      _playlistScrollController.position.maxScrollExtent,
    );
    _playlistScrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _showInternetRestoredSnackbar() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Internet Restored'),
        backgroundColor: AppColors.primaryColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _handleBack(BuildContext context) async {
    if (!context.mounted) return;
    final orientation = MediaQuery.orientationOf(context);
    if (orientation == Orientation.portrait) {
      Navigator.pop(context);
    } else {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _playlistScrollController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        return YoutubePlayerBuilder(
          onEnterFullScreen: () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
          },
          onExitFullScreen: () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
          },
          player: YoutubePlayer(
            key: ValueKey('yt_player_${_controller.playerGeneration}'),
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
                onPressed: () => _handleBack(context),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.whiteIconColor,
                  size: 24.sp,
                ),
              ),
            ],
            bottomActions: const [
              CurrentPosition(),
              ProgressBar(isExpanded: true),
              RemainingDuration(),
              FullScreenButton(),
            ],
          ),
          builder: (context, player) {
            return Scaffold(
              backgroundColor: AppColors.bgColor,
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildPlayerArea(player),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: CustomText(
                        text: _controller.currentItem.title,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: CustomText(
                        fontSize: 13,
                        color: AppColors.secondaryTextColor,
                        maxLines: 3,
                        text: _controller.currentItem.description,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: CustomText(
                        text: 'Playlist',
                        fontSize: 18,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Expanded(
                      child: ListView.builder(
                        controller: _playlistScrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _controller.playlist.length,
                        itemBuilder: (context, index) {
                          return PlaylistTile(
                            item: _controller.playlist[index],
                            isSelected: _controller.currentIndex == index,
                            onTap: () {
                              _controller.switchVideo(index);
                              _scrollToCurrentVideo();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPlayerArea(Widget player) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          player,
          if (_controller.isOffline)
            NoInternetOverlay(onRetry: _controller.retryConnection),
          if (_controller.hasPlayerError && !_controller.isOffline)
            _buildPlayerErrorOverlay(),
          if (_controller.isPlayerLoading &&
              !_controller.isOffline &&
              !_controller.hasPlayerError)
            const ColoredBox(
              color: Colors.black45,
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            )
          else if (_controller.isBuffering && !_controller.isOffline)
            const IgnorePointer(
              child: ColoredBox(
                color: Colors.black26,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlayerErrorOverlay() {
    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: Colors.white, size: 40.sp),
              SizedBox(height: 8.h),
              CustomText(
                text: _controller.playerError ?? 'Unable to play video.',
                fontSize: 13,
                color: Colors.white,
                align: TextAlign.center,
                maxLines: 3,
              ),
              SizedBox(height: 12.h),
              TextButton.icon(
                onPressed: _controller.retryVideoLoad,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                ),
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
