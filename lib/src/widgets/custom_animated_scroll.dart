import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../utils/utils.dart';

class CustomAnimated extends StatefulWidget {
  final Widget child;
  final Duration? delay;
  final AnimationController animationController;
  final Animation animation;
  final GlobalKey globalKey;
  const CustomAnimated({
    super.key,
    required this.child,
    this.delay,
    required this.animationController,
    required this.animation,
    required this.globalKey,
  });

  @override
  State<CustomAnimated> createState() => _CustomAnimatedState();
}

class _CustomAnimatedState extends State<CustomAnimated> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  Offset _position = Offset.zero;
  Size _size = const Size(0, 0);
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();

    _animationController = widget.animationController;

    _animation = widget.animation;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.globalKey.currentContext == null) return;
      RenderBox renderBox = widget.globalKey.currentContext!.findRenderObject() as RenderBox;
      Offset position = renderBox.localToGlobal(Offset.zero);
      setState(() {
        _position = position;
        _size = renderBox.size;
      });
      if (context.height > _position.dy) {
        _animate();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScrollableState? scrollableState = Scrollable.of(context);
      scrollableState.position.addListener(_onScroll);
    });
  }

  void _animate() {
    if (!mounted) return;
    Future.delayed(widget.delay ?? Duration.zero, () {
      _animationController.forward(from: 0.0);
      setState(() {
        _isAnimated = true;
      });
    });
  }

  void _onScroll() {
    if (_isAnimated) return;
    ScrollableState? scrollableState = Scrollable.of(context);
    final viewportDimension = scrollableState.position.viewportDimension;
    final scrollPosition = scrollableState.position.pixels;
    final widgetTop = _position.dy;
    final widgetBottom = widgetTop + _size.height;

    // Check if the widget is within the viewport
    if (scrollPosition < widgetBottom && (scrollPosition + viewportDimension) > widgetTop) {
      _animate();
    }
  }

  @override
  void dispose() {
    ScrollableState? scrollableState = Scrollable.of(context);
    scrollableState.position.removeListener(_onScroll);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          key: widget.globalKey,
          child: widget.child,
        );
      },
    );
  }
}
