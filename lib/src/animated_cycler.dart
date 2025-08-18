import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A versatile animated widget that automatically cycles through a list of
/// items with smooth bidirectional animations.
///
/// [AnimatedCycler] supports both vertical and horizontal directions and works
/// with any data type using Dart generics. Perfect for creating rolling
/// tickers, rotating banners, news feeds, or any content that needs cyclical
/// display.
///
/// ## Basic Usage
///
/// ### Vertical Direction (Default)
/// ```dart
/// AnimatedCycler<String>(
///   direction: Axis.vertical,
///   items: ['Message 1', 'Message 2', 'Message 3'],
///   size: 50, // height
///   itemBuilder: (context, message, index) {
///     return Center(child: Text(message));
///   },
/// )
/// ```
///
/// ### Horizontal Direction
/// ```dart
/// AnimatedCycler<Product>(
///   direction: Axis.horizontal,
///   items: productList,
///   size: 200, // width
///   itemBuilder: (context, product, index) {
///     return ProductCard(product);
///   },
/// )
/// ```
///
/// ## Named Constructors
///
/// Use [AnimatedCycler.vertical] for vertical content like rankings or
/// notifications.
/// Use [AnimatedCycler.horizontal] for horizontal content like banners or
/// carousels.
///
/// ## Manual Control
///
/// Access control methods through a [GlobalKey]:
/// ```dart
/// final key = GlobalKey<AnimatedCyclerState>();
///
/// // In your widget
/// AnimatedCycler(key: key, ...)
///
/// // Control methods
/// key.currentState?.nextItem();
/// key.currentState?.previousItem();
/// key.currentState?.togglePlayPause();
/// ```
class AnimatedCycler<T> extends StatefulWidget {
  /// Creates an [AnimatedCycler] widget.
  ///
  /// The [items] and [itemBuilder] parameters are required.
  /// All other parameters have sensible defaults for common use cases.
  const AnimatedCycler({
    required this.items,
    required this.itemBuilder,
    super.key,
    this.direction = Axis.vertical,
    this.displayDuration = const Duration(seconds: 3),
    this.animationDuration = const Duration(milliseconds: 800),
    this.size = 50.0,
    this.autoPlay = true,
    this.animationCurve = Curves.easeInOut,
    this.loop = true,
    this.onItemTap,
    this.onAnimationComplete,
  });

  /// Creates a vertical [AnimatedCycler] optimized for vertical content.
  ///
  /// This named constructor is optimized for content that flows vertically,
  /// such as rankings, news headlines, notifications, or status updates.
  ///
  /// The [height] parameter controls the container height. If not provided,
  /// defaults to 50.0.
  ///
  /// Example:
  /// ```dart
  /// AnimatedCycler.vertical(
  ///   items: ['🥇 First Place', '🥈 Second Place', '🥉 Third Place'],
  ///   height: 60,
  ///   itemBuilder: (context, text, index) {
  ///     return Center(child: Text(text));
  ///   },
  /// )
  /// ```
  const AnimatedCycler.vertical({
    required this.items,
    required this.itemBuilder,
    super.key,
    double? height,
    this.displayDuration = const Duration(seconds: 3),
    this.animationDuration = const Duration(milliseconds: 800),
    this.autoPlay = true,
    this.animationCurve = Curves.easeInOut,
    this.loop = true,
    this.onItemTap,
    this.onAnimationComplete,
  })  : direction = Axis.vertical,
        size = height ?? 50.0;

  /// Creates a horizontal [AnimatedCycler] optimized for horizontal content.
  ///
  /// This named constructor is optimized for content that flows horizontally,
  /// such as banner advertisements, product carousels, image sliders, or
  /// promotional content.
  ///
  /// The [width] parameter controls the container width. If not provided,
  /// defaults to 200.0.
  ///
  /// Example:
  /// ```dart
  /// AnimatedCycler.horizontal(
  ///   items: productList,
  ///   width: 300,
  ///   itemBuilder: (context, product, index) {
  ///     return ProductCard(product: product);
  ///   },
  /// )
  /// ```
  const AnimatedCycler.horizontal({
    required this.items,
    required this.itemBuilder,
    super.key,
    double? width,
    this.displayDuration = const Duration(seconds: 3),
    this.animationDuration = const Duration(milliseconds: 800),
    this.autoPlay = true,
    this.animationCurve = Curves.easeInOut,
    this.loop = true,
    this.onItemTap,
    this.onAnimationComplete,
  })  : direction = Axis.horizontal,
        size = width ?? 200.0;

  /// The list of items to cycle through.
  ///
  /// Must not be null. If empty, the widget will display an empty container.
  final List<T> items;

  /// Builder function to create the UI for each item.
  ///
  /// Called for each item in [items] with:
  /// - `context`: The build context
  /// - `item`: The current item data
  /// - `index`: The current item index
  ///
  /// Must return a widget that represents the item.
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// The animation direction.
  ///
  /// - [Axis.vertical]: Items animate from bottom to top (default)
  /// - [Axis.horizontal]: Items animate from right to left
  final Axis direction;

  /// Duration each item is displayed before transitioning.
  ///
  /// Defaults to 3 seconds. Only applies when `autoPlay` is true.
  final Duration displayDuration;

  /// Duration of the transition animation between items.
  ///
  /// Defaults to 800 milliseconds. Controls how fast items transition.
  final Duration animationDuration;

  /// The size of the widget container.
  ///
  /// - For [Axis.vertical]: Sets the height
  /// - For [Axis.horizontal]: Sets the width
  ///
  /// Defaults to 50.0.
  final double size;

  /// Whether to automatically cycle through items.
  ///
  /// When true, items will automatically transition after [displayDuration].
  /// When false, items only change through manual control methods.
  ///
  /// Defaults to true.
  final bool autoPlay;

  /// The animation curve for transitions.
  ///
  /// Defines the easing function for item transitions.
  /// Defaults to [Curves.easeInOut].
  final Curve animationCurve;

  /// Whether to loop back to the first item after the last item.
  ///
  /// When true, cycles infinitely through all items.
  /// When false, stops at the last item.
  ///
  /// Defaults to true.
  final bool loop;

  /// Callback function called when an item is tapped.
  ///
  /// Receives the tapped item and its index as parameters.
  /// Optional callback - can be null if tap handling is not needed.
  final void Function(T item, int index)? onItemTap;

  /// Callback function called when an animation transition completes.
  ///
  /// Receives the newly displayed item and its index as parameters.
  /// Called after each successful transition to a new item.
  /// Optional callback - can be null if completion handling is not needed.
  final void Function(T item, int index)? onAnimationComplete;

  @override
  State<AnimatedCycler<T>> createState() => AnimatedCyclerState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<T>('items', items))
      ..add(
        ObjectFlagProperty<
            Widget Function(BuildContext context, T item, int index)>.has(
          'itemBuilder',
          itemBuilder,
        ),
      )
      ..add(EnumProperty<Axis>('direction', direction))
      ..add(
        DiagnosticsProperty<Duration>('displayDuration', displayDuration),
      )
      ..add(
        DiagnosticsProperty<Duration>('animationDuration', animationDuration),
      )
      ..add(DoubleProperty('size', size))
      ..add(DiagnosticsProperty<bool>('autoPlay', autoPlay))
      ..add(
        DiagnosticsProperty<Curve>('animationCurve', animationCurve),
      )
      ..add(DiagnosticsProperty<bool>('loop', loop))
      ..add(
        ObjectFlagProperty<void Function(T item, int index)?>.has(
          'onItemTap',
          onItemTap,
        ),
      )
      ..add(
        ObjectFlagProperty<void Function(T item, int index)?>.has(
          'onAnimationComplete',
          onAnimationComplete,
        ),
      );
  }
}

/// The state class for [AnimatedCycler] that provides manual control methods.
///
/// Access this state through a [GlobalKey] to manually control the cycler:
/// ```dart
/// final key = GlobalKey<AnimatedCyclerState>();
///
/// // Use the key with your AnimatedCycler
/// AnimatedCycler(key: key, ...)
///
/// // Access control methods
/// key.currentState?.nextItem();
/// key.currentState?.togglePlayPause();
/// ```
class AnimatedCyclerState<T> extends State<AnimatedCycler<T>>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    if (widget.autoPlay && widget.items.isNotEmpty) {
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedCycler<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Reset animation if items list changed
    if (oldWidget.items != widget.items) {
      _currentIndex = 0;
      _animationController.reset();
    }

    // Restart timer if autoPlay setting changed
    if (oldWidget.autoPlay != widget.autoPlay) {
      if (widget.autoPlay) {
        _startAutoPlay();
      } else {
        _stopAutoPlay();
      }
    }
  }

  /// Initializes the animation controller and animation curve.
  void _initializeAnimation() {
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );
  }

  /// Starts automatic cycling through items.
  void _startAutoPlay() {
    _stopAutoPlay(); // Clean up existing timer

    if (widget.items.isEmpty) {
      return;
    }

    _timer = Timer.periodic(widget.displayDuration, (timer) {
      // If loop is false and we're at the last item, stop auto-play
      if (!widget.loop && _currentIndex >= widget.items.length - 1) {
        _stopAutoPlay();
        return;
      }
      _goToNextItem();
    });
  }

  /// Stops automatic cycling.
  void _stopAutoPlay() {
    _timer?.cancel();
    _timer = null;
  }

  /// Transitions to the next item with animation.
  void _goToNextItem() {
    if (widget.items.isEmpty) {
      return;
    }

    // Check if we can go to next item when loop is false
    if (!widget.loop && _currentIndex >= widget.items.length - 1) {
      return;
    }

    _animationController.forward().then((_) {
      if (mounted) {
        setState(() {
          if (widget.loop) {
            _currentIndex = (_currentIndex + 1) % widget.items.length;
          } else {
            _currentIndex = 
                (_currentIndex + 1).clamp(0, widget.items.length - 1);
          }
        });
        _animationController.reset();

        // Trigger animation complete callback
        widget.onAnimationComplete?.call(
          widget.items[_currentIndex],
          _currentIndex,
        );
      }
    });
  }

  /// Gets the currently displayed item.
  T? get _currentItem {
    if (widget.items.isEmpty) {
      return null;
    }
    return widget.items[_currentIndex];
  }

  /// Gets the next item to be displayed.
  T? get _nextItem {
    if (widget.items.isEmpty) {
      return null;
    }
    final nextIndex = widget.loop 
        ? (_currentIndex + 1) % widget.items.length
        : (_currentIndex + 1).clamp(0, widget.items.length - 1);
    return widget.items[nextIndex];
  }

  /// Gets the index of the next item.
  int get _nextIndex {
    if (widget.items.isEmpty) {
      return 0;
    }
    return widget.loop 
        ? (_currentIndex + 1) % widget.items.length
        : (_currentIndex + 1).clamp(0, widget.items.length - 1);
  }

  /// Calculates the animation offset based on direction and progress.
  ///
  /// For vertical direction, returns y-axis offset.
  /// For horizontal direction, returns x-axis offset.
  Offset _getAnimationOffset(double progress) {
    final value = progress * widget.size;

    return widget.direction == Axis.vertical
        ? Offset(0, value) // Vertical: y-axis movement
        : Offset(value, 0); // Horizontal: x-axis movement
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return SizedBox(
        width: widget.direction == Axis.horizontal ? widget.size : null,
        height: widget.direction == Axis.vertical ? widget.size : null,
      );
    }

    // Performance optimization: calculate direction once
    final isVertical = widget.direction == Axis.vertical;
    final containerWidth = isVertical ? null : widget.size;
    final containerHeight = isVertical ? widget.size : null;

    return SizedBox(
      width: containerWidth,
      height: containerHeight,
      child: ClipRect(
        child: Stack(
          children: <Widget>[
            // Current item (slides out in animation direction)
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => Transform.translate(
                offset: _getAnimationOffset(-_animation.value),
                child: _buildItemWidget(_currentItem, _currentIndex),
              ),
            ),

            // Next item (slides in from opposite direction)
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => Transform.translate(
                offset: _getAnimationOffset(1 - _animation.value),
                child: _buildItemWidget(_nextItem, _nextIndex),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the widget for an individual item with tap handling.
  Widget _buildItemWidget(T? item, int index) {
    if (item == null) {
      return const SizedBox.shrink();
    }

    final isVertical = widget.direction == Axis.vertical;

    return GestureDetector(
      onTap: () => widget.onItemTap?.call(item, index),
      child: SizedBox(
        width: isVertical ? null : widget.size,
        height: isVertical ? widget.size : null,
        child: widget.itemBuilder(context, item, index),
      ),
    );
  }

  /// Manually advances to the next item.
  ///
  /// Triggers the same animation as automatic cycling.
  /// If `loop` is false and at the last item, this has no effect.
  void nextItem() {
    _goToNextItem();
  }

  /// Manually goes back to the previous item.
  ///
  /// Animates to the previous item in the list.
  /// If `loop` is true, wraps around to the last item when at the first item.
  /// If `loop` is false, stops at the first item.
  void previousItem() {
    if (widget.items.isEmpty) {
      return;
    }

    // Check if we can go to previous item when loop is false
    if (!widget.loop && _currentIndex <= 0) {
      return;
    }

    _animationController.forward().then((_) {
      if (mounted) {
        setState(() {
          if (widget.loop) {
            _currentIndex =
                (_currentIndex - 1 + widget.items.length) % widget.items.length;
          } else {
            _currentIndex = 
                (_currentIndex - 1).clamp(0, widget.items.length - 1);
          }
        });
        _animationController.reset();

        // Trigger animation complete callback
        widget.onAnimationComplete?.call(
          widget.items[_currentIndex],
          _currentIndex,
        );
      }
    });
  }

  /// Jumps directly to the item at the specified [index].
  ///
  /// The [index] must be valid (0 <= index < items.length).
  /// Invalid indices are ignored to prevent errors.
  void goToIndex(int index) {
    if (widget.items.isEmpty || index < 0 || index >= widget.items.length) {
      return;
    }

    _animationController.forward().then((_) {
      if (mounted) {
        setState(() {
          _currentIndex = index;
        });
        _animationController.reset();

        // Trigger animation complete callback
        widget.onAnimationComplete?.call(
          widget.items[_currentIndex],
          _currentIndex,
        );
      }
    });
  }

  /// Gets the index of the currently displayed item.
  ///
  /// Returns 0 if the items list is empty.
  int get currentIndex => _currentIndex;

  /// Gets the currently displayed item.
  ///
  /// Returns null if the items list is empty.
  T? get currentItem => _currentItem;

  /// Checks if auto-play is currently active.
  ///
  /// Returns true if the timer is running and cycling through items.
  bool get isPlaying => _timer?.isActive ?? false;

  /// Toggles auto-play between paused and playing states.
  ///
  /// If currently playing, pauses auto-play.
  /// If currently paused, resumes auto-play.
  void togglePlayPause() {
    if (isPlaying) {
      _stopAutoPlay();
    } else {
      _startAutoPlay();
    }
  }

  /// Pauses auto-play without affecting the `autoPlay` setting.
  ///
  /// Use [togglePlayPause] to resume, or call `_startAutoPlay` directly.
  void pause() {
    _stopAutoPlay();
  }

  /// Resumes auto-play if `autoPlay` is true.
  ///
  /// Has no effect if `autoPlay` is false.
  void resume() {
    if (widget.autoPlay) {
      _startAutoPlay();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('currentIndex', currentIndex))
      ..add(DiagnosticsProperty<T?>('currentItem', currentItem))
      ..add(DiagnosticsProperty<bool>('isPlaying', isPlaying));
  }
}
