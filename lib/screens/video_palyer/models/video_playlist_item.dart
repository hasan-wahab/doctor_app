class VideoPlaylistItem {
  final String videoId;
  final String title;
  final String description;

  const VideoPlaylistItem({
    required this.videoId,
    required this.title,
    required this.description,
  });

  String get thumbnailUrl => 'https://img.youtube.com/vi/$videoId/0.jpg';

  bool get isValid => videoId.isNotEmpty;
}
