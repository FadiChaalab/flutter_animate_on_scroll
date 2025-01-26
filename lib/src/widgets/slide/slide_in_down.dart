import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';

import '../../config/base_animation_config.dart';
import '../../helper/visisibility_detector.dart';
import '../../utils/utils.dart';

class SlideInDown extends StatefulWidget {
  /// Provide configuration for the animation
  final BaseAnimationConfig config;

  /// provide offset if need it
  final double? offset;

  const SlideInDown({
    super.key,
    required this.config,
    this.offset,
  });

  @override
  State<SlideInDown> createState() => _SlideInDownState();
}

class _SlideInDownState extends State<SlideInDown> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  /// Animation controller, used to control the animation
  late AnimationController _animationController;

  /// Animation, used to animate the widget
  late Animation<double> _animation;

  /// Check if the widget is animated
  bool _isAnimated = false;

  /// Check if the widget is in view
  bool _isInView = false;

  /// Used to maintain the state of the widget, mainly to maintain the widget state when scrolling
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: widget.config.duration ?? 300.ms,
    )..addStatusListener(_handleAnimationStatus);

    // Initialize the animation
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.config.curves ?? Curves.decelerate,
      ),
    );
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
    if (widget.config.useScrollForAnimation == true) {
      _animateUsingScrollValue(info.visibleFraction);
    } else {
      if (!_isInView && !info.visible) return;

      if (widget.config.repeat == true) {
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
    final delay = info.direction == ScrollDirection.reverse ? Duration.zero : widget.config.delay ?? Duration.zero;

    Future.delayed(delay, () {
      if (mounted && info.visible && !_isAnimated && info.direction != ScrollDirection.forward) {
        _animationController.duration = widget.config.duration ?? 300.ms;
        _animationController.forward(from: 0.0);
      }
    });
  }

  void _animateUsingScrollValue(double viewFraction) {
    if (!mounted) return;

    // Apply curve to the visible fraction
    final curves = widget.config.curves ?? Curves.decelerate;
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
          child: Visibility(
            visible: _animation.value != 0,
            child: Transform.translate(
              offset: Offset(
                0,
                -(widget.offset ?? context.height) * (1 - _animation.value),
              ),
              child: widget.config.child,
            ),
          ),
        );
      },
    );
  }
}
