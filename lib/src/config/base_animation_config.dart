import 'package:flutter/material.dart';

class BaseAnimationConfig {
  /// attach widget to animation child
  final Widget child;

  /// provide delay duration if need it, by default zero
  final Duration? delay;

  /// provide animation duration if need it, by default 300 milliseconds
  final Duration? duration;

  /// provide animation curves if need it, by default [Curves.decelerate]
  final Curve? curves;

  /// provide repeated animation for widget, by default false
  final bool? repeat;

  /// provide scroll option to animate widget based on scroll, by default false
  final bool? useScrollForAnimation;

  const BaseAnimationConfig({
    required this.child,
    this.delay,
    this.curves,
    this.duration,
    this.repeat = false,
    this.useScrollForAnimation = false,
  });
}
