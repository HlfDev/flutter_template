import 'package:flutter/widgets.dart';

class AppBreakpoints {
  AppBreakpoints._();

  static const double kMobileBreakpoint = 600.0;
  static const double kTabletBreakpoint = 840.0;

  static double widthOf(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  static bool isMobile(BuildContext context) =>
      widthOf(context) < kMobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final width = widthOf(context);
    return width >= kMobileBreakpoint && width < kTabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      widthOf(context) >= kTabletBreakpoint;
}
