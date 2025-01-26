import 'package:flutter/material.dart';
import 'dart:math' as math;

extension BuildContextExtensions on BuildContext {
  /// get screen height using context directly
  double get height => MediaQuery.sizeOf(this).height;

  /// get screen width using context directly
  double get width => MediaQuery.sizeOf(this).width;
}

extension NumDurationExtensions on num {
  /// get microseconds using num directly
  Duration get microseconds => Duration(microseconds: round());

  /// get milliseconds using num directly
  Duration get milliseconds => Duration(microseconds: (this * 1000).round());
  Duration get ms => milliseconds;

  /// get seconds using num directly
  Duration get seconds => Duration(microseconds: (this * 1000 * 1000).round());

  /// get minutes using num directly
  Duration get minutes => Duration(microseconds: (this * 1000 * 1000 * 60).round());

  /// get hours using num directly
  Duration get hours => Duration(microseconds: (this * 1000 * 1000 * 60 * 60).round());

  /// get days using num directly
  Duration get days => Duration(microseconds: (this * 1000 * 1000 * 60 * 60 * 24).round());
}

/// Shorthand to convert degrees to Radians. (multiply degrees with this value)
const double toRad = math.pi / 180.0;

/// Shorthand to convert radians to Degrees. (multiply radians with this value)
const double toDeg = 180.0 / math.pi;

double getScrollbarHeight(ScrollableState? scrollableState) {
  final scrollMetrics = scrollableState?.position;
  if (scrollMetrics == null) return 0.0;

  // Get viewport height (visible area)
  final viewportHeight = scrollMetrics.viewportDimension;

  // Get total scrollable content height
  final contentHeight = scrollMetrics.maxScrollExtent + viewportHeight;

  // Calculate scrollbar height as a proportion
  final scrollbarHeight = (viewportHeight / contentHeight) * viewportHeight;

  // Ensure minimum height for visibility
  return math.max(scrollbarHeight, 40.0);
}
