import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import '../../utils/utils.dart';

class RotateOut extends StatefulWidget {
  /// attach widget to animation child
  final Widget child;

  /// provide delay duration if need it, by default zero
  final Duration? delay;

  /// provide animation duration if need it, by default 300 milliseconds
  final Duration? duration;

  /// provide animation curves if need it, by default [Curves.decelerate]
  final Curve? curves;

  /// require [GlobalKey] to get widget position and size
  final GlobalKey globalKey;

  /// provide degree if need it, by default 200
  final double? degree;

  /// provide repeated animation for widget, by default false
  final bool? repeat;

  const RotateOut({
    super.key,
    required this.child,
    this.delay,
    this.curves,
    this.duration,
    required this.globalKey,
    this.degree,
    this.repeat = false,
  });

  @override
  State<RotateOut> createState() => _RotateOutState();
}

class _RotateOutState extends State<RotateOut> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final ValueNotifier<Offset> _position = ValueNotifier(Offset.zero);
  final ValueNotifier<Size> _size = ValueNotifier(const Size(0, 0));
  final ValueNotifier<bool> _isAnimated = ValueNotifier(false);
  bool _isInView = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration ?? 300.ms,
    );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curves ?? Curves.decelerate,
      ),
    );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.globalKey.currentContext == null) return;
      RenderBox renderBox = widget.globalKey.currentContext!.findRenderObject() as RenderBox;
      Offset position = renderBox.localToGlobal(Offset.zero);
      _position.value = position;
      _size.value = renderBox.size;
      if (context.height > _position.value.dy) {
        _animate(isInView: true);
        _isInView = true;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScrollableState? scrollableState = Scrollable.of(context);
      scrollableState.position.addListener(_onScroll);
    });
  }

  void _animate({bool isScrollingUp = false, bool isInView = false}) {
    if (!mounted) return;
    Future.delayed(widget.delay ?? Duration.zero, () {
      if (isScrollingUp && !isInView) {
        _animationController.reverse(from: 1.0);
      } else if (!isScrollingUp && isInView) {
        _animationController.forward(from: 0.0);
      }
      _isAnimated.value = true;
    });
  }

  void _onScroll() {
    if (_isAnimated.value && widget.repeat == false) return;
    ScrollableState? scrollableState = Scrollable.of(context);
    final viewportDimension = scrollableState.position.viewportDimension;
    final scrollPosition = scrollableState.position.pixels;
    final widgetTop = _position.value.dy;
    final widgetBottom = widgetTop + _size.value.height;

    // check direction of scroll to animate
    bool isScrollingDown = scrollableState.position.userScrollDirection == ScrollDirection.reverse;
    bool isScrollingUp = scrollableState.position.userScrollDirection == ScrollDirection.forward;
    // Check if the widget is within the viewport
    bool isInView = scrollPosition < widgetBottom && (scrollPosition + viewportDimension) > widgetTop;

    // Handle animation based on visibility and scroll direction
    if (widget.repeat!) {
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

    _isInView = isInView;
  }

  @override
  void dispose() {
    ScrollableState? scrollableState = Scrollable.of(context);
    scrollableState.position.removeListener(_onScroll);
    _animationController.dispose();
    _position.dispose();
    _size.dispose();
    _isAnimated.dispose();
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
            angle: widget.degree ?? 200 * toRad * (1 - _animation.value),
            alignment: Alignment.center,
            child: Container(
              key: widget.globalKey,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
