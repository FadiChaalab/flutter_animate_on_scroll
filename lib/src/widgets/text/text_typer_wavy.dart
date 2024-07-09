import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import '../../utils/utils.dart';

class TextTyperWavyAnimation extends StatefulWidget {
  /// provide text to animate
  final String text;

  /// provide delay duration if need it, by default zero
  final Duration? delay;

  /// provide animation duration if need it, by default 2 seconds
  final Duration? duration;

  /// provide animation curves if need it, by default [Curves.elasticOut]
  final Curve? curves;

  /// require [GlobalKey] to get widget position and size
  final GlobalKey globalKey;

  /// provide text style if need it, by default [Theme.of(context).textTheme.bodyMedium]
  final TextStyle? textStyle;

  /// provide text alignment if need it, by default [TextAlign.start]
  final TextAlign? textAlign;

  /// provide overflow if need it, by default [TextOverflow.clip]
  final TextOverflow? overflow;

  /// provide offset if need it, by default [30.0]
  final double? offset;

  /// provide repeated animation for widget, by default false
  final bool? repeat;

  const TextTyperWavyAnimation({
    super.key,
    required this.text,
    this.delay,
    this.curves,
    this.duration,
    required this.globalKey,
    this.textStyle,
    this.textAlign,
    this.overflow,
    this.offset,
    this.repeat = false,
  });

  @override
  State<TextTyperWavyAnimation> createState() => _TextTyperWavyAnimationState();
}

class _TextTyperWavyAnimationState extends State<TextTyperWavyAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _animations;
  final ValueNotifier<int> _textLength = ValueNotifier(0);
  final ValueNotifier<Offset> _position = ValueNotifier(Offset.zero);
  final ValueNotifier<Size> _size = ValueNotifier(const Size(0, 0));
  final ValueNotifier<bool> _isAnimated = ValueNotifier(false);
  bool _isInView = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration ?? 2.seconds,
    );

    _animations = List.generate(widget.text.length, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index / widget.text.length,
            1.0,
            curve: widget.curves ?? Curves.elasticOut,
          ),
        ),
      );
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

    bool isScrollingDown = scrollableState.position.userScrollDirection == ScrollDirection.reverse;
    bool isScrollingUp = scrollableState.position.userScrollDirection == ScrollDirection.forward;
    bool isInView = scrollPosition < widgetBottom && (scrollPosition + viewportDimension) > widgetTop;

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
    return ValueListenableBuilder<int>(
      valueListenable: _textLength,
      builder: (context, textLength, _) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return RichText(
              key: widget.globalKey,
              textAlign: widget.textAlign ?? TextAlign.start,
              overflow: widget.overflow ?? TextOverflow.clip,
              text: TextSpan(
                style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
                children: List.generate(widget.text.length, (index) {
                  return WidgetSpan(
                    child: Transform.translate(
                      offset: Offset(0, -(widget.offset ?? 30.0) * (1 - _animations[index].value)),
                      child: Text(widget.text[index]),
                    ),
                  );
                }),
              ),
            );
          },
        );
      },
    );
  }
}
