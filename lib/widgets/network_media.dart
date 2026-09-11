import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../core/app_styles/app_colors.dart';
import '../core/app_styles/app_sizes.dart';
import '../core/app_styles/app_text_styles.dart';
import 'app_shimmer.dart';
import 'custom_text.dart';

class MediaRefresh extends InheritedWidget {
  const MediaRefresh({
    super.key,
    required this.token,
    required super.child,
  });

  final int token;

  static int of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MediaRefresh>()?.token ??
        0;
  }

  @override
  bool updateShouldNotify(MediaRefresh oldWidget) => token != oldWidget.token;
}

class NetworkMedia extends StatefulWidget {
  const NetworkMedia({
    super.key,
    this.url,
    this.emptyMessage = 'Image not found',
    this.emptyIcon = Icons.image_outlined,
    this.overlay,
  });

  final String? url;
  final String emptyMessage;
  final IconData emptyIcon;
  final Widget? overlay;

  @override
  State<NetworkMedia> createState() => _NetworkMediaState();
}

class _NetworkMediaState extends State<NetworkMedia> {
  StreamSubscription<List<ConnectivityResult>>? _netSub;
  int _generation = 0;
  int? _refreshToken;
  bool _hadError = false;

  @override
  void initState() {
    super.initState();
    _netSub = Connectivity().onConnectivityChanged.listen((results) {
      final online = results.any((r) => r != ConnectivityResult.none);
      if (online) _retry(onlyIfError: true);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final token = MediaRefresh.of(context);
    if (_refreshToken == null) {
      _refreshToken = token;
      return;
    }
    if (token != _refreshToken) {
      _refreshToken = token;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _retry(onlyIfError: false);
      });
    }
  }

  @override
  void didUpdateWidget(NetworkMedia oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _hadError = false;
      _generation = 0;
    }
  }

  @override
  void dispose() {
    _netSub?.cancel();
    super.dispose();
  }

  void _retry({required bool onlyIfError}) {
    if (onlyIfError && !_hadError) return;
    if (!mounted) return;
    final src = widget.url?.trim() ?? '';
    if (src.isNotEmpty) {
      imageCache.evict(NetworkImage(src));
    }
    setState(() {
      _hadError = false;
      _generation++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final src = widget.url?.trim() ?? '';
    if (src.isEmpty) {
      return MediaEmpty(message: widget.emptyMessage, icon: widget.emptyIcon);
    }

    return Image.network(
      src,
      key: ValueKey('$src-$_generation'),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      gaplessPlayback: true,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        final loaded = wasSynchronouslyLoaded || frame != null;
        final image = widget.overlay == null
            ? child
            : Stack(
                fit: StackFit.expand,
                children: [child, widget.overlay!],
              );

        if (loaded) return image;

        return Stack(
          fit: StackFit.expand,
          children: [
            const MediaShimmer(),
            Opacity(opacity: 0, child: child),
          ],
        );
      },
      errorBuilder: (_, __, ___) {
        _hadError = true;
        return MediaEmpty(
          message: widget.emptyMessage,
          icon: widget.emptyIcon,
        );
      },
    );
  }
}

class MediaShimmer extends StatelessWidget {
  const MediaShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFFE7F2F1),
      child: ShimmerSweep(fillBackground: true),
    );
  }
}

class MediaEmpty extends StatelessWidget {
  const MediaEmpty({
    super.key,
    required this.message,
    this.icon = Icons.image_outlined,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.softGrayColor,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.gapMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: AppSizes.iconLg,
                color: AppColors.mutedTextColor,
              ),
              SizedBox(height: AppSizes.spaceXs),
              CustomText(
                text: message,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.labelTextColor,
                ),
                align: TextAlign.center,
                maxLines: 2,
                textOverflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
