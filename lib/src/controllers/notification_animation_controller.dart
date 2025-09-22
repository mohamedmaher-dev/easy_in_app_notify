import 'dart:async';
import 'package:flutter/material.dart';
import '../models/notification_style.dart';

/// Controller that manages all animations for notification display.
///
/// This class handles entrance animations, exit animations, progress animations,
/// and background blur effects. It provides a clean API for controlling
/// the animation lifecycle of notifications.
class NotificationAnimationController {
  /// Ticker provider for driving animations.
  final TickerProvider vsync;

  /// Style configuration containing animation settings.
  final NotificationStyle style;

  /// Duration of auto-dismiss in seconds (0 = no auto-dismiss).
  final int autoDismissDuration;

  /// Callback executed when animations complete and notification should be hidden.
  final VoidCallback onComplete;

  // Animation Controllers
  late final AnimationController _entranceController;
  late final AnimationController _exitController;
  late final AnimationController _progressController;
  late final AnimationController _backgroundController;

  // Animations
  late final Animation<double> _entranceAnimation;
  late final Animation<double> _exitAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _progressAnimation;
  late final Animation<double> _backgroundAnimation;

  // State
  bool _isDisposed = false;
  bool _isExiting = false;
  Timer? _autoDismissTimer;

  /// Creates a new notification animation controller.
  NotificationAnimationController({
    required this.vsync,
    required this.style,
    required this.autoDismissDuration,
    required this.onComplete,
  }) {
    _initializeControllers();
    _initializeAnimations();
    _startEntranceAnimation();
    _startAutoDismissTimer();
  }

  /// Initializes all animation controllers with appropriate durations.
  void _initializeControllers() {
    _entranceController = AnimationController(
      duration: style.animationDuration,
      vsync: vsync,
    );

    _exitController = AnimationController(
      duration: style.animationDuration,
      vsync: vsync,
    );

    _progressController = AnimationController(
      duration: Duration(seconds: autoDismissDuration),
      vsync: vsync,
    );

    _backgroundController = AnimationController(
      duration: style.animationDuration,
      vsync: vsync,
    );
  }

  /// Initializes all animations with appropriate curves and tweens.
  void _initializeAnimations() {
    // Entrance animation (0 to 1)
    _entranceAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );

    // Exit animation (1 to 0)
    _exitAnimation = CurvedAnimation(
      parent: _exitController,
      curve: Curves.easeInCubic,
    );

    // Slide animation based on position
    _slideAnimation = Tween<Offset>(
      begin: _getSlideBeginOffset(),
      end: Offset.zero,
    ).animate(_entranceAnimation);

    // Scale animation
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(_entranceAnimation);

    // Fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_entranceAnimation);

    // Progress animation (0 to 1 over auto-dismiss duration)
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.linear),
    );

    // Background blur animation
    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: style.backgroundBlurOpacity,
    ).animate(_entranceAnimation);
  }

  /// Gets the initial slide offset based on notification position.
  Offset _getSlideBeginOffset() {
    switch (style.position) {
      case NotificationPosition.top:
        return const Offset(0, -1);
      case NotificationPosition.bottom:
        return const Offset(0, 1);
      case NotificationPosition.center:
        return const Offset(0, -0.5);
    }
  }

  /// Starts the entrance animation sequence.
  void _startEntranceAnimation() {
    if (_isDisposed) return;

    // Start background animation if blur is enabled
    if (style.enableBackgroundBlur) {
      _backgroundController.forward();
    }

    // Start main entrance animation
    _entranceController.forward();
  }

  /// Starts the auto-dismiss timer if duration > 0.
  void _startAutoDismissTimer() {
    if (autoDismissDuration <= 0 || _isDisposed) return;

    // Start progress animation
    if (style.showProgressBar) {
      _progressController.forward();
    }

    // Set up auto-dismiss timer
    _autoDismissTimer = Timer(Duration(seconds: autoDismissDuration), () {
      if (!_isDisposed && !_isExiting) {
        dismiss();
      }
    });
  }

  /// Dismisses the notification with exit animation.
  Future<void> dismiss() async {
    if (_isDisposed || _isExiting) return;

    _isExiting = true;
    _cancelAutoDismissTimer();

    // Reverse animations
    final futures = <Future>[_exitController.forward()];

    if (style.enableBackgroundBlur) {
      futures.add(_backgroundController.reverse());
    }

    // Wait for all animations to complete
    await Future.wait(futures);

    if (!_isDisposed) {
      onComplete();
    }
  }

  /// Pauses the auto-dismiss timer (useful for hover interactions).
  void pauseAutoDismiss() {
    if (style.showProgressBar && !_isDisposed) {
      _progressController.stop();
    }
  }

  /// Resumes the auto-dismiss timer.
  void resumeAutoDismiss() {
    if (style.showProgressBar && !_isDisposed && !_isExiting) {
      _progressController.forward();
    }
  }

  /// Cancels the auto-dismiss timer.
  void _cancelAutoDismissTimer() {
    _autoDismissTimer?.cancel();
    _autoDismissTimer = null;
  }

  /// Disposes of all animation controllers and cancels timers.
  void dispose() {
    if (_isDisposed) return;
    _isDisposed = true;

    _cancelAutoDismissTimer();
    _entranceController.dispose();
    _exitController.dispose();
    _progressController.dispose();
    _backgroundController.dispose();
  }

  // Getters for animations
  /// Animation for the main notification widget based on animation type.
  Animation<double> get mainAnimation {
    switch (style.animation) {
      case NotificationAnimation.slide:
        return _entranceAnimation;
      case NotificationAnimation.fade:
        return _fadeAnimation;
      case NotificationAnimation.scale:
        return _scaleAnimation;
      case NotificationAnimation.none:
        return const AlwaysStoppedAnimation(1.0);
    }
  }

  /// Slide animation for slide-type notifications.
  Animation<Offset> get slideAnimation => _slideAnimation;

  /// Scale animation for scale-type notifications.
  Animation<double> get scaleAnimation => _scaleAnimation;

  /// Fade animation for fade-type notifications.
  Animation<double> get fadeAnimation => _fadeAnimation;

  /// Progress animation for progress bar.
  Animation<double> get progressAnimation => _progressAnimation;

  /// Background blur animation.
  Animation<double> get backgroundAnimation => _backgroundAnimation;

  /// Exit animation for dismissal.
  Animation<double> get exitAnimation => _exitAnimation;

  /// Whether the controller is currently animating.
  bool get isAnimating =>
      _entranceController.isAnimating ||
      _exitController.isAnimating ||
      _progressController.isAnimating ||
      _backgroundController.isAnimating;

  /// Whether the notification is currently being dismissed.
  bool get isExiting => _isExiting;
}
