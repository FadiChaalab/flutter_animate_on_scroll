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

class _CustomAnimatedState extends State<CustomAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  Offset _position = Offset.zero;
  Size _size = const Size(0, 0);
  bool _isAnimated = false;

  @override
  void initState() {
    _animationController = widget.animationController;
    _animation = widget.animation;
    widget.animation.addListener(() {
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
    Future.delayed(widget.delay ?? const Duration(milliseconds: 0), () {
      _animationController.forward(from: 0.0);
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
        return Container(
          key: widget.globalKey,
          child: widget.child,
        );
      },
    );
  }
}
