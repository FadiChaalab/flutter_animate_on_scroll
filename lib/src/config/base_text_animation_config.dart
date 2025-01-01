import 'package:flutter/material.dart';

class BaseTextAnimationConfig {
  /// provide text to animate
  final String text;

  /// provide delay duration if need it, by default zero
  final Duration? delay;

  /// provide animation duration if need it, by default 2 seconds
  final Duration? duration;

  /// provide animation curves if need it, by default [Curves.elasticOut]
  final Curve? curves;

  /// provide text style if need it, by default [Theme.of(context).textTheme.bodyMedium]
  final TextStyle? textStyle;

  /// provide text alignment if need it, by default [TextAlign.start]
  final TextAlign? textAlign;

  /// provide overflow if need it, by default [TextOverflow.clip]
  final TextOverflow? overflow;

  /// provide repeated animation for widget, by default false
  final bool? repeat;

  /// provide scroll option to animate widget based on scroll, by default false
  final bool? useScrollForAnimation;

  const BaseTextAnimationConfig({
    required this.text,
    this.delay,
    this.curves,
    this.duration,
    this.textStyle,
    this.textAlign,
    this.overflow,
    this.repeat = false,
    this.useScrollForAnimation = false,
  });
}
