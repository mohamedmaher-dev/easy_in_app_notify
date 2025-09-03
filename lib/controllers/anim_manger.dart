part of '../easy_in_app_notify.dart';

/// Manages all animations and timing for notification display and dismissal.
///
/// This class coordinates the slide-in animation, progress bar animation,
/// and auto-dismiss timer for in-app notifications. It ensures smooth
/// visual transitions and proper cleanup of resources.
class _AnimManger {
  /// Ticker provider for driving animations (typically a StatefulWidget).
  final TickerProvider vsync;

  /// Duration in seconds for how long the notification should be visible.
  final int duration;

  /// Callback function to execute when the notification should be dismissed.
  final VoidCallback onDismiss;

  /// Animation controller for the slide-in/slide-out transition.
  late final AnimationController _slideController;

  /// Animation controller for the progress bar countdown.
  late final AnimationController _progressController;

  /// Slide transition animation that moves the notification from top.
  late final Animation<Offset> _offsetAnimation;

  /// Progress animation that fills the progress bar over time.
  late final Animation<double> _progressAnimation;

  /// Timer that automatically dismisses the notification after duration.
  late final Timer _dismissTimer;

  /// Creates and initializes a new animation manager.
  ///
  /// Automatically sets up all animations and starts them immediately.
  /// The notification will slide in from the top and begin its countdown.
  _AnimManger({
    required this.vsync,
    required this.duration,
    required this.onDismiss,
  }) {
    _initializeAnimations();
    _startAnimations();
  }

  /// Initializes all animation controllers and their respective animations.
  ///
  /// Sets up two main animations:
  /// 1. Slide animation for smooth entry/exit transitions
  /// 2. Progress animation for the countdown progress bar
  void _initializeAnimations() {
    // Slide animation controller - handles smooth entry and exit
    _slideController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 250),
    );

    // Progress animation controller - handles countdown visualization
    _progressController = AnimationController(
      vsync: vsync,
      duration: Duration(seconds: duration),
    );

    // Slide transition animation - moves notification from above screen
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Start above screen
      end: Offset.zero, // End at normal position
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    // Progress fill animation - linear countdown from 0% to 100%
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.linear),
    );
  }

  /// Starts all animations and sets up the auto-dismiss timer.
  ///
  /// This method coordinates the start of the notification display sequence:
  /// - Slides the notification into view
  /// - Begins the progress countdown
  /// - Sets up automatic dismissal after the specified duration
  void _startAnimations() {
    // Start slide-in animation to bring notification into view
    _slideController.forward();

    // Start progress animation to show countdown to user
    _progressController.forward();

    // Set auto-dismiss timer to hide notification when duration expires
    _dismissTimer = Timer(Duration(seconds: duration), dismiss);
  }

  /// Dismisses the notification with a smooth slide-out animation.
  ///
  /// Can be called manually (e.g., user swipe) or automatically by timer.
  /// Prevents multiple dismiss operations if already animating.
  Future<void> dismiss() async {
    if (_slideController.isAnimating) return;
    await _slideController.reverse();
    onDismiss();
  }

  /// Disposes of all animation controllers and cancels timers.
  ///
  /// Essential for preventing memory leaks and ensuring proper cleanup
  /// when the notification is removed from the widget tree.
  void dispose() {
    _slideController.dispose();
    _progressController.dispose();
    _dismissTimer.cancel();
  }

  /// Gets the slide animation for positioning the notification.
  Animation<Offset> get slideAnimation => _offsetAnimation;

  /// Gets the progress animation for the countdown progress bar.
  Animation<double> get progressAnimation => _progressAnimation;
}
