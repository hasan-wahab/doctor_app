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
  final List<String> videoImageId = [
    'x3sKVlYFj5w',
    'ho3Wpg1gPAQ',
    'NuAFBlMGTwI',
    '1Z6Iu0JcIhI',
  ];
  final List<String> videoUrl = [
    "https://youtu.be/x3sKVlYFj5w",
    "https://youtu.be/ho3Wpg1gPAQ",
    "https://youtu.be/NuAFBlMGTwI",
    "https://youtu.be/1Z6Iu0JcIhI",
  ];
  List<String> videoTitle = [
    'Back pain',
    'Neck Pain',
    'Sciatica Pain',
    'Physical Therapy',
  ];
  List<String> videoDescription = [
    'Back pain treatment and cervical pain treatment At F-8 Islamabad 03082033 332 ',
    'Neck Pain Treatment| Back pain Treatment| Treatment of Morning stiffness',
    'Sciatica Pain Treatment|Treatment of Pain Radiating to legs | Disc Bulge Treatment',
    'Dr Kainat and her Mother Got sessions from Dr Ali Therapy and recommend Physical Therapy',
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
        aspectRatio: 16 / 9,
        controller: _yControllers[_currentIndex],
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColors.primaryColor,
        progressColors: ProgressBarColors(
          playedColor: AppColors.primaryColor,
          handleColor: AppColors.primaryColor,
        ),
        key: ValueKey(_videoIds[_currentIndex]),
        topActions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.whiteIconColor,
              size: 30,
            ),
          ),
        ],
      ),
      builder: (context, player) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                player,
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomText(
                    text: videoTitle[_currentIndex],
                    fontSize: 16,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width - 140.w,
                    child: CustomText(
                      fontSize: 13,
                      color: AppColors.secondaryTextColor,
                      maxLines: 2,
                      text: videoDescription[_currentIndex],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomText(
                    text: 'Playlist',
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
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          height: 100.h,
                          width: MediaQuery.sizeOf(context).width.w,
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.secondaryColor : null,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : Colors.grey,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 80.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://img.youtube.com/vi/${videoImageId[index]}/0.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: videoTitle[index],
                                    fontSize: 16,
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width -
                                        140.w,
                                    child: CustomText(
                                      fontSize: 13,
                                      color: AppColors.secondaryTextColor,
                                      maxLines: 2,
                                      text: videoDescription[index],
                                    ),
                                  ),
                                ],
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
          ),
        );
      },
    );
  }
}
