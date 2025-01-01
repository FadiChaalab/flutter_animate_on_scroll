import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import '../../config/base_animation_config.dart';
import '../../utils/utils.dart';

class RotateInDownLeft extends StatefulWidget {
  /// Provide configuration for the animation
  final BaseAnimationConfig config;

  /// provide degree if need it, by default -45
  final double? degree;

  const RotateInDownLeft({
    super.key,
    required this.config,
    this.degree,
  });

  @override
  State<RotateInDownLeft> createState() => _RotateInDownLeftState();
}

class _RotateInDownLeftState extends State<RotateInDownLeft> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late ScrollableState? _scrollableState;
  Offset _position = Offset.zero;
  Size _size = Size(0, 0);
  bool _isAnimated = false;
  bool _isInView = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.config.duration ?? 300.ms,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.config.curves ?? Curves.decelerate,
      ),
    );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (context.findRenderObject() == null) return;
      RenderBox renderBox = context.findRenderObject() as RenderBox;
      Offset position = renderBox.localToGlobal(Offset.zero);
      _position = position;
      _size = renderBox.size;
      final viewportDimension = _scrollableState?.position.viewportDimension ?? 0;
      final scrollPosition = _scrollableState?.position.pixels ?? 0;
      final widgetTop = _position.dy;
      final widgetBottom = widgetTop + _size.height;
      if (scrollPosition < widgetBottom && (scrollPosition + viewportDimension) > widgetTop) {
        _animate(isInView: true);
        _isInView = true;
      }
    });
  }

  void _animate({bool isScrollingUp = false, bool isInView = false}) {
    if (!mounted) return;
    Future.delayed(widget.config.delay ?? Duration.zero, () {
      if (isScrollingUp && !isInView) {
        _animationController.reverse(from: 1.0);
      } else if (!isScrollingUp && isInView) {
        _animationController.forward(from: 0.0);
      }
      _isAnimated = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollableState = Scrollable.maybeOf(context);
    _scrollableState?.position.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isAnimated && widget.config.repeat == false) return;
    final viewportDimension = _scrollableState?.position.viewportDimension ?? 0;
    final scrollPosition = _scrollableState?.position.pixels ?? 0;
    final widgetTop = _position.dy;
    final widgetBottom = widgetTop + _size.height;

    // check direction of scroll to animate
    bool isScrollingDown = _scrollableState?.position.userScrollDirection == ScrollDirection.reverse;
    bool isScrollingUp = _scrollableState?.position.userScrollDirection == ScrollDirection.forward;
    // Check if the widget is within the viewport
    bool isInView = scrollPosition < widgetBottom && (scrollPosition + viewportDimension) > widgetTop;

    // Handle animation based on visibility and scroll direction
    if (widget.config.useScrollForAnimation == true) {
      // Use scroll value to drive animation
      double progress = ((scrollPosition + viewportDimension - widgetTop) / viewportDimension).clamp(0.0, 1.0);
      _animationController.value = progress;
    } else {
      if (widget.config.repeat == true) {
        if (isInView && !_isInView && isScrollingDown) {
          _animate(isScrollingUp: false, isInView: isInView);
        } else if (isInView && !_isInView && isScrollingUp) {
          _animate(isScrollingUp: true, isInView: isInView);
        }
      } else {
        if (isInView && !_isInView) {
          _animate(isInView: isInView);
        }
      }
    }

    _isInView = isInView;
  }

  @override
  void dispose() {
    _scrollableState?.position.removeListener(_onScroll);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return FadeTransition(
          opacity: _animation,
          child: Transform.rotate(
            angle: widget.degree ?? -45 * toRad * (1 - _animation.value),
            alignment: Alignment.bottomLeft,
            child: widget.config.child,
          ),
        );
      },
    );
  }
}
