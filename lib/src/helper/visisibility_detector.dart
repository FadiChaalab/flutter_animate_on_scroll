import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A widget that detects when it is visible within a [Scrollable] widget.
///
/// This widget is useful for triggering animations when a widget becomes visible
/// on the screen.
///
/// The [onVisibilityChanged] callback is called whenever the visibility of the
/// widget changes. The callback provides a [VisibilityDetectorInfo] object that
/// contains information about the visibility of the widget.
class VisibilityDetector extends StatefulWidget {
  /// The widget that is being observed for visibility changes.
  final Widget child;

  /// A callback that is called whenever the visibility of the widget changes.
  final VisibilityDetectorInfoCallback? onVisibilityChanged;

  const VisibilityDetector({super.key, required this.child, this.onVisibilityChanged});

  @override
  State<VisibilityDetector> createState() => _VisibilityDetectorState();
}

class _VisibilityDetectorState extends State<VisibilityDetector> {
  final _key = GlobalKey(); // a key to access the widget's render box
  ScrollPosition? _scrollPosition; // the scroll position of the parent Scrollable widget
  double _lastOffset = 0; // last scroll offset, used to determine scroll direction
  bool _wasVisible = false; // whether the widget was visible on the last frame
  double _visibleFraction = 0; // the fraction of the widget that is visible on the screen

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // attach the scroll listener when the widget is first built
    _attachScrollListener();
  }

  /// Attach a scroll listener to the parent Scrollable widget.
  ///
  /// This method is called whenever the widget is built or the scroll position
  /// changes.
  void _attachScrollListener() {
    final newPosition = Scrollable.maybeOf(context)?.position;
    if (newPosition == _scrollPosition) return;

    _scrollPosition?.removeListener(_checkVisibility);
    _scrollPosition = newPosition;
    _scrollPosition?.addListener(_checkVisibility);
    _checkVisibility();
  }

  /// Check the visibility of the widget.
  void _checkVisibility() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _scrollPosition == null) return;

      // get the render box of the widget and the parent Scrollable widget
      // to calculate the visibility of the widget
      final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
      final scrollable = Scrollable.maybeOf(context);
      final scrollableBox = scrollable?.context.findRenderObject() as RenderBox?;

      if (renderBox == null || scrollableBox == null) return;

      final viewportHeight = _scrollPosition?.viewportDimension ?? 0;
      final scrollOffset = _scrollPosition?.pixels ?? 0;

      final widgetTop = renderBox.localToGlobal(Offset.zero, ancestor: scrollableBox).dy;
      final widgetBottom = widgetTop + renderBox.size.height;

      // check if the widget is visible on the screen, by checking if the top
      // or bottom of the widget is within the viewport
      final isVisible = widgetBottom > 0 && widgetTop < viewportHeight;
      final scrollDirection = _getScrollDirection(scrollOffset); // get the scroll direction

      // check if the widget can reverse when animating
      final canReverse =
          _wasVisible && !isVisible && scrollDirection == ScrollDirection.forward && widgetTop > viewportHeight;

      // calculate the fraction of the widget that is visible on the screen
      final visibleFraction = _calculateVisibleFraction(widgetTop, widgetBottom, viewportHeight);

      // call the onVisibilityChanged callback if the visibility has changed
      if (isVisible != _wasVisible || canReverse || visibleFraction != _visibleFraction) {
        widget.onVisibilityChanged?.call(VisibilityDetectorInfo(
          visibleFraction: visibleFraction,
          visible: isVisible,
          direction: scrollDirection,
          canReverse: canReverse,
        ));
      }

      _wasVisible = isVisible; // update the visibility status
      _visibleFraction = visibleFraction; // update the visible fraction
      _lastOffset = scrollOffset; // update the last scroll offset
    });
  }

  /// Calculate the fraction of the widget that is visible on the screen.
  double _calculateVisibleFraction(double top, double bottom, double viewportHeight) {
    final visibleHeight = bottom.clamp(0, viewportHeight) - top.clamp(0, viewportHeight);
    return (visibleHeight / (bottom - top)).clamp(0.0, 1.0);
  }

  /// Get the scroll direction based on the current scroll offset.
  ScrollDirection _getScrollDirection(double currentOffset) {
    if (currentOffset > _lastOffset) return ScrollDirection.reverse;
    if (currentOffset < _lastOffset) return ScrollDirection.forward;
    return ScrollDirection.idle;
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_checkVisibility);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: widget.child,
    );
  }
}

/// A class that contains information about the visibility of a widget.
///
/// The [visibleFraction] property represents the fraction of the widget that is
/// visible on the screen. The [visible] property indicates whether the widget
/// is currently visible on the screen. The [direction] property represents the
/// direction of the scroll (forward, reverse, or idle). The [canReverse] property
/// indicates whether the widget can reverse when animating.
class VisibilityDetectorInfo {
  final double visibleFraction;
  final bool visible;
  final ScrollDirection direction;
  final bool canReverse;

  VisibilityDetectorInfo({
    required this.visibleFraction,
    required this.visible,
    required this.direction,
    required this.canReverse,
  });

  @override
  String toString() {
    return 'VisibilityDetectorInfo(visibleFraction: $visibleFraction, visible: $visible, direction: $direction, canReverse: $canReverse)';
  }
}

/// A callback that is called whenever the visibility of a widget changes.
typedef VisibilityDetectorInfoCallback = void Function(VisibilityDetectorInfo info);
