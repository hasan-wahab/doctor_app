import 'package:doctor_app/screens/video_palyer/models/video_playlist_item.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Single source for all app videos — used on home slider and video player.
class AppVideoPlaylist {
  AppVideoPlaylist._();

  static const List<VideoPlaylistItem> items = [
    VideoPlaylistItem(
      videoId: 'x3sKVlYFj5w',
      title: 'Back pain',
      description:
          'Back pain treatment and cervical pain treatment At F-8 Islamabad 03082033 332',
    ),
    VideoPlaylistItem(
      videoId: 'ho3Wpg1gPAQ',
      title: 'Neck Pain',
      description:
          'Neck Pain Treatment| Back pain Treatment| Treatment of Morning stiffness',
    ),
    VideoPlaylistItem(
      videoId: 'NuAFBlMGTwI',
      title: 'Sciatica Pain',
      description:
          'Sciatica Pain Treatment|Treatment of Pain Radiating to legs | Disc Bulge Treatment',
    ),
    VideoPlaylistItem(
      videoId: '1Z6Iu0JcIhI',
      title: 'Physical Therapy',
      description:
          'Dr Kainat and her Mother Got sessions from Dr Ali Therapy and recommend Physical Therapy',
    ),
  ];

  static String videoIdAt(int index) {
    if (index < 0 || index >= items.length) return '';
    return items[index].videoId;
  }

  static String thumbnailAt(int index) {
    final id = videoIdAt(index);
    if (id.isEmpty) return '';
    return 'https://img.youtube.com/vi/$id/0.jpg';
  }

  static String? videoIdFromUrl(String url) {
    return YoutubePlayer.convertUrlToId(url);
  }
}
