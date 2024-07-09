import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import '../../utils/utils.dart';

class TextTyperAnimation extends StatefulWidget {
  /// provide text to animate
  final String text;

  /// provide delay duration if need it, by default zero
  final Duration? delay;

  /// provide animation duration if need it, by default 2 seconds
  final Duration? duration;

  /// provide animation curves if need it, by default [Curves.decelerate]
  final Curve? curves;

  /// require [GlobalKey] to get widget position and size
  final GlobalKey globalKey;

  /// provide text style if need it, by default [Theme.of(context).textTheme.bodyMedium]
  final TextStyle? textStyle;

  /// provide text alignment if need it, by default [TextAlign.start]
  final TextAlign? textAlign;

  /// provide overflow if need it, by default [TextOverflow.clip]
  final TextOverflow? overflow;

  /// provide repeated animation for widget, by default false
  final bool? repeat;

  /// provide fade option to fade the text that is not visible, by default false
  final bool? fade;

  /// provide opacity value to fade the text that is not visible, by default 0.5
  final double? opacity;

  const TextTyperAnimation({
    super.key,
    required this.text,
    this.delay,
    this.curves,
    this.duration,
    required this.globalKey,
    this.textStyle,
    this.textAlign,
    this.overflow,
    this.repeat = false,
    this.fade = false,
    this.opacity = 0.5,
  });

  @override
  State<TextTyperAnimation> createState() => _TextTyperAnimationState();
}

class _TextTyperAnimationState extends State<TextTyperAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _animation;
  final ValueNotifier<Offset> _position = ValueNotifier(Offset.zero);
  final ValueNotifier<Size> _size = ValueNotifier(const Size(0, 0));
  final ValueNotifier<bool> _isAnimated = ValueNotifier(false);
  final ValueNotifier<int> _textLength = ValueNotifier(0);
  bool _isInView = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration ?? 2.seconds,
    );

    _animation = StepTween(begin: 0, end: widget.text.length).animate(_animationController)
      ..addListener(() {
        _textLength.value = _animation.value;
      });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.globalKey.currentContext == null) return;
      RenderBox renderBox = widget.globalKey.currentContext!.findRenderObject() as RenderBox;
      Offset position = renderBox.localToGlobal(Offset.zero);
      _position.value = position;
      _size.value = renderBox.size;
      if (MediaQuery.of(context).size.height > _position.value.dy) {
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
    _textLength.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        String visibleText = widget.text.substring(0, _textLength.value);
        String remainingText = widget.text.substring(_textLength.value);
        return Container(
          key: widget.globalKey,
          child: widget.fade == false
              ? Text(
                  visibleText,
                  style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
                  textAlign: widget.textAlign ?? TextAlign.start,
                  overflow: widget.overflow ?? TextOverflow.clip,
                )
              : RichText(
                  textAlign: widget.textAlign ?? TextAlign.start,
                  overflow: widget.overflow ?? TextOverflow.clip,
                  text: TextSpan(
                    style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(text: visibleText), // Fully visible text
                      TextSpan(
                        text: remainingText,
                        style: TextStyle(
                          color: (widget.textStyle?.color ?? Colors.black).withOpacity(widget.opacity ?? 0.5),
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
