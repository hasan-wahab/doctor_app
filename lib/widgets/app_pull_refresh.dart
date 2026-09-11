import 'package:flutter/material.dart';

class AppBarLoadingNotification extends Notification {
  const AppBarLoadingNotification(this.isLoading);

  final bool isLoading;
}

class AppPullRefresh extends StatefulWidget {
  const AppPullRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
    this.enabled = true,
    this.pullThreshold = 70,
  });

  final Future<void> Function() onRefresh;
  final Widget child;
  final bool enabled;
  final double pullThreshold;

  @override
  State<AppPullRefresh> createState() => _AppPullRefreshState();
}

class _AppPullRefreshState extends State<AppPullRefresh> {
  double _pullDistance = 0;
  bool _isRefreshing = false;

  Future<void> _startRefresh() async {
    if (_isRefreshing || !widget.enabled) return;

    setState(() {
      _isRefreshing = true;
      _pullDistance = 0;
    });
    AppBarLoadingNotification(true).dispatch(context);

    try {
      await widget.onRefresh();
    } finally {
      if (mounted) {
        AppBarLoadingNotification(false).dispatch(context);
        setState(() => _isRefreshing = false);
      }
    }
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (!widget.enabled || _isRefreshing) return false;

    if (notification is OverscrollNotification) {
      final atTop = notification.metrics.pixels <= 0;
      final pullingDown = notification.overscroll < 0;
      if (atTop && pullingDown) {
        _pullDistance += -notification.overscroll;
        if (_pullDistance >= widget.pullThreshold) {
          _startRefresh();
        }
      }
      return false;
    }

    if (notification is ScrollUpdateNotification) {
      final delta = notification.scrollDelta ?? 0;
      if (notification.metrics.pixels <= 0 && delta < 0) {
        _pullDistance += -delta;
        if (_pullDistance >= widget.pullThreshold) {
          _startRefresh();
        }
      } else if (notification.metrics.pixels > 0) {
        _pullDistance = 0;
      }
    }
    if (notification is ScrollEndNotification) {
      _pullDistance = 0;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: widget.child,
    );
  }
}
