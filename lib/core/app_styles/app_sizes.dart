import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  AppSizes._();

  static const double tabletMinShortestSide = 600;

  /// Phone Figma / ScreenUtil base.
  static const Size phoneDesignSize = Size(390, 844);

  /// iPad Pro 11" portrait — tablet ScreenUtil base.
  static const Size tabletPortraitDesignSize = Size(834, 1194);

  /// iPad Pro 11" landscape — tablet ScreenUtil base.
  static const Size tabletLandscapeDesignSize = Size(1194, 834);

  /// Call before / without BuildContext (e.g. ScreenUtilInit designSize).
  static bool get isTabletDevice {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final size = view.physicalSize / view.devicePixelRatio;
    return size.shortestSide >= tabletMinShortestSide;
  }

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).shortestSide >= tabletMinShortestSide;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.orientationOf(context) == Orientation.landscape;

  /// Phone stays 390×844. Tablet switches 834×1194 / 1194×834 on rotate.
  static Size screenUtilDesignSize({required bool landscape}) {
    if (!isTabletDevice) return phoneDesignSize;
    return landscape ? tabletLandscapeDesignSize : tabletPortraitDesignSize;
  }

  static double contentMaxWidth(BuildContext context) {
    if (!isTablet(context)) return double.infinity;
    return isLandscape(context) ? 1000 : 720;
  }

  static double get iconSm => 20.sp;
  static double get iconMd => 22.sp;
  static double get iconLg => 24.sp;
  static double get iconXl => 30.sp;

  static double get pagePaddingH => 16.w;
  static double get pagePaddingTop => 12.h;
  static double get pagePaddingBottom => 24.h;

  static double get authPaddingH => 24.w;
  static double get authPaddingV => 24.h;

  static double get spaceXs => 6.h;
  static double get spaceSm => 8.h;
  static double get spaceMd => 10.h;
  static double get spaceLg => 12.h;
  static double get spaceXl => 16.h;
  static double get spaceXxl => 22.h;
  static double get spaceSection => 28.h;

  static double get gapSm => 8.w;
  static double get gapMd => 12.w;
  static double get gapLg => 16.w;

  static double get radiusSm => 12.r;
  static double get radiusMd => 18.r;
  static double get radiusLg => 20.r;

  static double get buttonHeight => 50.h;
  static double get buttonHeightSm => 40.h;

  static double get cardPaddingH => 18.w;
  static double get cardPaddingTop => 20.h;
  static double get cardPaddingBottom => 18.h;

  static double get fieldPaddingH => 14.w;
  static double get fieldPaddingV => 14.h;

  static double get logoSize => 96.w;

  static EdgeInsets get pageInsets => EdgeInsets.fromLTRB(
        pagePaddingH,
        pagePaddingTop,
        pagePaddingH,
        pagePaddingBottom,
      );

  static EdgeInsets get authInsets => EdgeInsets.symmetric(
        horizontal: authPaddingH,
        vertical: authPaddingV,
      );

  static EdgeInsets get cardInsets => EdgeInsets.fromLTRB(
        cardPaddingH,
        cardPaddingTop,
        cardPaddingH,
        cardPaddingBottom,
      );
}
