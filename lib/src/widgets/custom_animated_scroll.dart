import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';

import '../helper/visisibility_detector.dart';
import '../utils/utils.dart';

class CustomAnimated extends StatefulWidget {
  /// attach widget to animation child
  final Widget child;

  /// provide delay duration if need it, by default zero
  final Duration? delay;

  /// require [AnimationController] to use your custom controle animation
  final AnimationController animationController;

  /// require [Animation] to use your custom animation
  final Animation animation;

  /// provide curve for animation, by default [Curves.decelerate]
  /// Mainly used for scroll animation to provide smooth animation, when
  /// using scroll for animation [useScrollForAnimation] is true
  final Curve? curves;

  /// provide repeated animation for widget, by default false
  final bool? repeat;

  /// provide scroll option to animate widget based on scroll, by default false
  final bool? useScrollForAnimation;

  const CustomAnimated({
    super.key,
    required this.child,
    this.delay,
    required this.animationController,
    required this.animation,
    this.curves,
    this.repeat = false,
    this.useScrollForAnimation = false,
  });

  @override
  State<CustomAnimated> createState() => _CustomAnimatedState();
}

class _CustomAnimatedState extends State<CustomAnimated>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  /// Animation controller, used to control the animation
  late AnimationController _animationController;

  /// Animation, used to animate the opacity
  late Animation _animation;

  /// Check if the widget is animated
  bool _isAnimated = false;

  /// Check if the widget is in view
  bool _isInView = false;

  Duration _duration = Duration.zero;

  /// Used to maintain the state of the widget, mainly to maintain the widget state when scrolling
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _animationController = widget.animationController;

    // Add status listener to the animation controller
    _animationController.addStatusListener(_handleAnimationStatus);

    // Initialize the animation
    _animation = widget.animation;

    // Set the duration of the animation
    _duration = widget.animationController.duration ?? 300.ms;
  }

  /// Handle the animation status
  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      _isAnimated = false;
    } else if (status == AnimationStatus.completed) {
      _isAnimated = true;
    }
  }

  /// Handle the animation
  void _handleAnimation(VisibilityDetectorInfo info) {
    if (widget.useScrollForAnimation == true) {
      _animateUsingScrollValue(info.visibleFraction);
    } else {
      if (!_isInView && !info.visible) return;

      if (widget.repeat == true) {
        if (info.canReverse && _animationController.status == AnimationStatus.completed) {
          // reverse animation
          // set duration to zero to make it faster
          _animationController.duration = Duration.zero;
          _animationController.reverse(from: 1.0);
        } else if (info.visible && !_isAnimated) {
          _animateWithoutScrollValue(info);
        }
      } else {
        if (info.visible && !_isAnimated) {
          _animateWithoutScrollValue(info);
        }
      }
    }
    _isInView = info.visible;
  }

  void _animateWithoutScrollValue(VisibilityDetectorInfo info) {
    final delay = info.direction == ScrollDirection.reverse ? Duration.zero : widget.delay ?? Duration.zero;

    Future.delayed(delay, () {
      if (mounted && info.visible && !_isAnimated && info.direction != ScrollDirection.forward) {
        _animationController.duration = _duration;
        _animationController.forward(from: 0.0);
      }
    });
  }

  void _animateUsingScrollValue(double viewFraction) {
    if (!mounted) return;

    // Apply curve to the visible fraction
    final curves = widget.curves ?? Curves.decelerate;
    final curvedValue = curves.transform(viewFraction);

    // Use spring simulation for smooth transitions
    final simulation = SpringSimulation(
      SpringDescription.withDampingRatio(
        mass: 0.8,
        stiffness: 300.0,
        ratio: 0.6,
      ),
      _animationController.value,
      curvedValue,
      0,
    );

    _animationController.animateWith(simulation);
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_handleAnimationStatus);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return VisibilityDetector(
          onVisibilityChanged: (info) {
            _handleAnimation(info);
          },
          child: widget.child,
        );
      },
    );
  }
}
