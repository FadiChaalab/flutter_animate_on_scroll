import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../utils/utils.dart';

class FadeOutUp extends StatefulWidget {
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

  /// provide offset if need it, by default 50
  final double? offset;

  const FadeOutUp({
    super.key,
    required this.child,
    this.delay,
    this.curves,
    this.duration,
    required this.globalKey,
    this.offset,
  });

  @override
  State<FadeOutUp> createState() => _FadeOutUpState();
}

class _FadeOutUpState extends State<FadeOutUp>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  Offset _position = Offset.zero;
  Size _size = const Size(0, 0);
  bool _isAnimated = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration ?? 300.ms,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: widget.curves ?? Curves.decelerate),
    )..addListener(() {
        setState(() {});
      });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.globalKey.currentContext == null) return;
      RenderBox renderBox =
          widget.globalKey.currentContext?.findRenderObject() as RenderBox;
      Offset position = renderBox.localToGlobal(Offset.zero);
      setState(() {
        _position = position;
        _size = renderBox.size;
      });
      if (context.height > _position.dy) {
        _animate();
      }
    });

    context.scrollController.addListener(_onScroll);
    super.initState();
  }

  _animate() {
    if (!mounted) return;
    Future.delayed(widget.delay ?? 0.ms, () {
      _animationController.forward(from: 1.0);
      setState(() {
        _isAnimated = true;
      });
    });
  }

  _onScroll() {
    if (_isAnimated) return;
    if (context.scrollController.offset >
        _position.dy - (_size.height * visibility) - (context.height / 2)) {
      _animate();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    context.scrollController.removeListener(_onScroll);
    context.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (widget.offset ?? 50) * (1 - _animation.value)),
          child: FadeTransition(
            opacity: _animation,
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
