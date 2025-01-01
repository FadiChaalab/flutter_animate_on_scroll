import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import '../../config/base_text_animation_config.dart';
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

class _TextTyperWavyAnimationState extends State<TextTyperWavyAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _animations;
  late ScrollableState? _scrollableState;
  final ValueNotifier<int> _textLength = ValueNotifier(0);
  Offset _position = Offset.zero;
  Size _size = Size(0, 0);
  bool _isAnimated = false;
  bool _isInView = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.config.duration ?? 2.seconds,
    );

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

    bool isScrollingDown = _scrollableState?.position.userScrollDirection == ScrollDirection.reverse;
    bool isScrollingUp = _scrollableState?.position.userScrollDirection == ScrollDirection.forward;
    bool isInView = scrollPosition < widgetBottom && (scrollPosition + viewportDimension) > widgetTop;

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
    return ValueListenableBuilder<int>(
      valueListenable: _textLength,
      builder: (context, textLength, _) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return RichText(
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
            );
          },
        );
      },
    );
  }
}
