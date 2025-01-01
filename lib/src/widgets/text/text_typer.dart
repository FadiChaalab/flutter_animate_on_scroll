import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import '../../config/base_text_animation_config.dart';
import '../../utils/utils.dart';

class TextTyperAnimation extends StatefulWidget {
  /// Provide configuration for the animation
  final BaseTextAnimationConfig config;

  /// provide fade option to fade the text that is not visible, by default false
  final bool? fade;

  /// provide opacity value to fade the text that is not visible, by default 0.5
  final double? opacity;

  const TextTyperAnimation({
    super.key,
    required this.config,
    this.fade = false,
    this.opacity = 0.5,
  });

  @override
  State<TextTyperAnimation> createState() => _TextTyperAnimationState();
}

class _TextTyperAnimationState extends State<TextTyperAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _animation;
  late ScrollableState? _scrollableState;
  Offset _position = Offset.zero;
  Size _size = Size(0, 0);
  bool _isAnimated = false;
  final ValueNotifier<int> _textLength = ValueNotifier(0);
  bool _isInView = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.config.duration ?? 2.seconds,
    );

    _animation = StepTween(begin: 0, end: widget.config.text.length).animate(_animationController)
      ..addListener(() {
        _textLength.value = _animation.value;
      });

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
    _textLength.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        String visibleText = widget.config.text.substring(0, _textLength.value);
        String remainingText = widget.config.text.substring(_textLength.value);
        return Container(
          child: widget.fade == false
              ? Text(
                  visibleText,
                  style: widget.config.textStyle ?? Theme.of(context).textTheme.bodyMedium,
                  textAlign: widget.config.textAlign ?? TextAlign.start,
                  overflow: widget.config.overflow ?? TextOverflow.clip,
                )
              : RichText(
                  textAlign: widget.config.textAlign ?? TextAlign.start,
                  overflow: widget.config.overflow ?? TextOverflow.clip,
                  text: TextSpan(
                    style: widget.config.textStyle ?? Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(text: visibleText), // Fully visible text
                      TextSpan(
                        text: remainingText,
                        style: TextStyle(
                          color:
                              (widget.config.textStyle?.color ?? Colors.black).withValues(alpha: widget.opacity ?? 0.5),
                        ),
                      ), // Half transparent text
                    ],
                  ),
                ),
        );
      },
    );
  }
}
