import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';

import '../../config/base_text_animation_config.dart';
import '../../helper/visisibility_detector.dart';
import '../../utils/utils.dart';

class TextTyperWavyAnimation extends StatefulWidget {
  /// Provide configuration for the animation
  final BaseTextAnimationConfig config;

  /// provide offset if need it, by default [30.0]
  final double? offset;

  const TextTyperWavyAnimation({
    super.key,
    required this.config,
    this.offset,
  });

  @override
  State<TextTyperWavyAnimation> createState() => _TextTyperWavyAnimationState();
}

class _TextTyperWavyAnimationState extends State<TextTyperWavyAnimation>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  /// Animation controller, used to control the animation
  late AnimationController _animationController;

  /// List of animations, used to animate the text
  late List<Animation<double>> _animations;

  /// Value notifier, used to notify the text length
  final ValueNotifier<int> _textLength = ValueNotifier(0);

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
      duration: widget.config.duration ?? 2.seconds,
    )..addStatusListener(_handleAnimationStatus);

    // Initialize the animations
    _animations = List.generate(widget.config.text.length, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index / widget.config.text.length,
            1.0,
            curve: widget.config.curves ?? Curves.elasticOut,
          ),
        ),
      );
    });
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
        _animationController.duration = widget.config.duration ?? 2.seconds;
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
    _textLength.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ValueListenableBuilder<int>(
      valueListenable: _textLength,
      builder: (context, textLength, _) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return VisibilityDetector(
              onVisibilityChanged: (info) {
                _handleAnimation(info);
              },
              child: RichText(
                textAlign: widget.config.textAlign ?? TextAlign.start,
                overflow: widget.config.overflow ?? TextOverflow.clip,
                text: TextSpan(
                  style: widget.config.textStyle ?? Theme.of(context).textTheme.bodyMedium,
                  children: List.generate(widget.config.text.length, (index) {
                    return WidgetSpan(
                      child: Transform.translate(
                        offset: Offset(0, -(widget.offset ?? 30.0) * (1 - _animations[index].value)),
                        child: Text(widget.config.text[index]),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
