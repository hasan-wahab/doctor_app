import 'package:doctor_app/app_styles/app_colors.dart'; // Make sure this import is correct
import 'package:doctor_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for fullscreen
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late List<YoutubePlayerController> _yControllers;
  late List<String> _videoIds;
  int _currentIndex = 0;
  bool _isInit = true;

  final List<String> videoUrl = [
    "https://www.youtube.com/watch?v=HhjHYkPQ8F0",
    "https://www.youtube.com/watch?v=nRhYQ3l2Ask",
    "https://www.youtube.com/watch?v=mRD0-GxqHVo",
    "https://www.youtube.com/watch?v=k4y_91Q6d5I",
    "https://www.youtube.com/watch?v=5qap5aO4i9A",
  ];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      if (args != null && args.containsKey("currentIndex")) {
        _currentIndex = args["currentIndex"];
      }
      _videoIds = videoUrl
          .map((url) => YoutubePlayer.convertUrlToId(url) ?? "")
          .toList();
      _yControllers = List.generate(_videoIds.length, (index) {
        return YoutubePlayerController(
          initialVideoId: _videoIds[index],
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
            isLive: false,
            forceHD: false,
            enableCaption: true,
            controlsVisibleAtStart: true,
          ),
        );
      });
      for (int i = 0; i < _yControllers.length; i++) {
        if (i != _currentIndex) {
          _yControllers[i].pause();
        }
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  void _switchVideo(int newIndex) {
    if (newIndex != _currentIndex) {
      _yControllers[_currentIndex].pause();
      setState(() {
        _currentIndex = newIndex;
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _yControllers) {
      controller.dispose();
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isInit) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      },
      player: YoutubePlayer(
        controller: _yControllers[_currentIndex],
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColors.primaryColor,
        progressColors: ProgressBarColors(
          playedColor: AppColors.primaryColor,
          handleColor: AppColors.primaryColor,
        ),
        key: ValueKey(_videoIds[_currentIndex]),
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(title: const Text('Video Playlist'), elevation: 1),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              player,
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomText(
                 text:  'Playlist',
                  fontSize: 18,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: ListView.builder(
                  itemCount: _videoIds.length,
                  itemBuilder: (context, index) {
                    final isSelected = _currentIndex == index;
                    return GestureDetector(
                      onTap: () => _switchVideo(index),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryColor
                                : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.play_circle_filled
                                  : Icons.play_circle_outline,
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : Colors.grey.shade600,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Video ${index + 1}',
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
