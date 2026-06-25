import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctor_app/core/extentions/internect_connectivity.dart';
import 'package:doctor_app/screens/video_palyer/models/video_playlist_item.dart';
import 'package:flutter/foundation.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Handles video playback, playlist switching, connectivity, and loader state.
class VideoPlayerScreenController extends ChangeNotifier {
  VideoPlayerScreenController({
    required List<VideoPlaylistItem> playlist,
    required int initialIndex,
  }) : _playlist = playlist,
       _currentIndex = _clampIndex(initialIndex, playlist.length) {
    _createYoutubeController(_playlist[_currentIndex].videoId);
    _startConnectivityMonitoring();
    _evaluateConnectivity();
  }

  static const Duration _playerLoaderTimeout = Duration(seconds: 6);
  static const Duration _connectivityPollInterval = Duration(seconds: 3);

  static const YoutubePlayerFlags _playerFlags = YoutubePlayerFlags(
    autoPlay: true,
    mute: false,
    isLive: false,
    forceHD: false,
    enableCaption: true,
    controlsVisibleAtStart: true,
  );

  final List<VideoPlaylistItem> _playlist;
  late YoutubePlayerController youtubeController;

  Timer? _playerLoaderTimer;
  Timer? _connectivityPollTimer;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  int _currentIndex;
  int _playerGeneration = 0;
  bool _isPlayerLoading = true;
  bool _isOffline = false;
  String? _playerError;
  Duration _savedPosition = Duration.zero;
  bool _pendingResume = false;
  bool _disposed = false;
  PlayerState _lastPlayerState = PlayerState.unknown;

  VoidCallback? onInternetRestored;

  List<VideoPlaylistItem> get playlist => _playlist;
  int get currentIndex => _currentIndex;
  int get playerGeneration => _playerGeneration;
  VideoPlaylistItem get currentItem => _playlist[_currentIndex];
  bool get isPlayerLoading => _isPlayerLoading;
  bool get isOffline => _isOffline;
  bool get hasPlayerError => _playerError != null;
  String? get playerError => _playerError;
  bool get isBuffering =>
      youtubeController.value.playerState == PlayerState.buffering;

  static int _clampIndex(int index, int length) {
    if (length == 0) return 0;
    return index.clamp(0, length - 1);
  }

  void _createYoutubeController(String videoId) {
    if (!videoId.isValid) {
      _isPlayerLoading = false;
      _playerError = 'Invalid video ID. Please try another video.';
      notifyListeners();
      return;
    }

    youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: _playerFlags,
    );
    youtubeController.addListener(_onPlayerUpdate);
    _startPlayerLoaderTimeout();
  }

  void _recreateYoutubeController(String videoId) {
    if (videoId.isEmpty || videoId.length != 11) {
      _playerError = 'Invalid video ID.';
      _isPlayerLoading = false;
      notifyListeners();
      return;
    }

    youtubeController.removeListener(_onPlayerUpdate);
    youtubeController.dispose();

    _playerGeneration++;
    _createYoutubeController(videoId);
  }

  void _startPlayerLoaderTimeout() {
    _playerLoaderTimer?.cancel();
    _playerLoaderTimer = Timer(_playerLoaderTimeout, () async {
      if (_disposed || !_isPlayerLoading) return;

      _isPlayerLoading = false;
      final hasInternet = await InternetUtils.isInternetAvailable();

      if (!hasInternet) {
        _handleOffline();
        return;
      }

      final value = youtubeController.value;
      if (!value.isReady && !value.hasPlayed) {
        _playerError =
            'Unable to load video. Please check your internet connection.';
      }
      notifyListeners();
    });
  }

  void _onPlayerUpdate() {
    if (_disposed) return;

    final value = youtubeController.value;
    final state = value.playerState;
    var shouldNotify = false;

    if (value.hasError && (value.isReady || value.hasPlayed)) {
      _playerError = _mapPlayerError(value.errorCode);
      _isPlayerLoading = false;
      _playerLoaderTimer?.cancel();
      notifyListeners();
      return;
    }

    final isActive =
        value.isReady ||
        value.hasPlayed ||
        state == PlayerState.playing ||
        state == PlayerState.buffering ||
        state == PlayerState.paused;

    if (_isPlayerLoading && isActive) {
      _playerLoaderTimer?.cancel();
      _isPlayerLoading = false;
      _playerError = null;
      shouldNotify = true;
    }

    if (state != _lastPlayerState) {
      _lastPlayerState = state;
      shouldNotify = true;
    }

    if (shouldNotify) {
      notifyListeners();
    }
  }

  String _mapPlayerError(int errorCode) {
    switch (errorCode) {
      case 2:
        return 'Invalid video ID or video is unavailable.';
      case 100:
        return 'This video is private or has been removed.';
      case 101:
      case 150:
        return 'Playback is not allowed for this video.';
      default:
        return 'Unable to play video. Please try again.';
    }
  }

  void _startConnectivityMonitoring() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((_) {
      _evaluateConnectivity();
    });

    _connectivityPollTimer = Timer.periodic(
      _connectivityPollInterval,
      (_) => _evaluateConnectivity(),
    );
  }

  Future<void> _evaluateConnectivity() async {
    if (_disposed) return;

    final hasInternet = await InternetUtils.isInternetAvailable();

    if (!hasInternet && !_isOffline) {
      _handleOffline();
    } else if (hasInternet && _isOffline) {
      await _handleOnline();
    }
  }

  void _handleOffline() {
    _isPlayerLoading = false;
    _playerLoaderTimer?.cancel();
    _playerError = null;
    _savedPosition = youtubeController.value.position;
    youtubeController.pause();
    _isOffline = true;
    _pendingResume = true;
    notifyListeners();
  }

  Future<void> _handleOnline() async {
    _isOffline = false;
    notifyListeners();

    if (_pendingResume) {
      _pendingResume = false;
      final position = _savedPosition;

      if (position.inSeconds > 0) {
        youtubeController.seekTo(position);
      } else {
        youtubeController.play();
      }
      onInternetRestored?.call();
    }

    notifyListeners();
  }

  /// Switch playlist item — recreates player so the new video actually loads.
  void switchVideo(int index) {
    if (index == _currentIndex ||
        index < 0 ||
        index >= _playlist.length ||
        _isOffline) {
      return;
    }

    final item = _playlist[index];
    if (!item.isValid) {
      _playerError = 'Invalid video ID.';
      notifyListeners();
      return;
    }

    _currentIndex = index;
    _playerError = null;
    _isPlayerLoading = true;
    _lastPlayerState = PlayerState.unknown;
    _recreateYoutubeController(item.videoId);
    notifyListeners();
  }

  Future<void> retryConnection() async {
    final hasInternet = await InternetUtils.isInternetAvailable();
    if (hasInternet) {
      await _handleOnline();
      if (!_isOffline && !youtubeController.value.isPlaying) {
        youtubeController.play();
      }
    } else {
      _isOffline = true;
      notifyListeners();
    }
  }

  void retryVideoLoad() {
    _playerError = null;
    _isPlayerLoading = true;
    _lastPlayerState = PlayerState.unknown;
    _recreateYoutubeController(currentItem.videoId);
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _playerLoaderTimer?.cancel();
    _connectivityPollTimer?.cancel();
    _connectivitySubscription?.cancel();
    youtubeController.removeListener(_onPlayerUpdate);
    youtubeController.dispose();
    super.dispose();
  }
}

extension on String {
  bool get isValid => isNotEmpty && length == 11;
}
