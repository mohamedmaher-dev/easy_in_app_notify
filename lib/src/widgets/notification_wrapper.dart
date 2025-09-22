import 'dart:ui';
import 'package:flutter/material.dart';
import '../controllers/notification_animation_controller.dart';
import '../models/notification_content.dart';
import '../models/notification_style.dart';
import '../models/notification_config.dart';
import 'notification_card.dart';

/// Wrapper widget that handles positioning, animations, and interactions.
///
/// This widget manages the notification's position on screen, applies animations,
/// handles user interactions, and provides the backdrop blur effect.
class NotificationWrapper extends StatefulWidget {
  /// The content to display in the notification.
  final NotificationContent content;

  /// The styling configuration for the notification.
  final NotificationStyle style;

  /// The behavior configuration for the notification.
  final NotificationConfig config;

  /// Callback executed when the notification should be dismissed.
  final VoidCallback onDismiss;

  /// Creates a new notification wrapper.
  const NotificationWrapper({
    super.key,
    required this.content,
    required this.style,
    required this.config,
    required this.onDismiss,
  });

  @override
  State<NotificationWrapper> createState() => _NotificationWrapperState();
}

class _NotificationWrapperState extends State<NotificationWrapper>
    with TickerProviderStateMixin {
  late final NotificationAnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = NotificationAnimationController(
      vsync: this,
      style: widget.style,
      autoDismissDuration: widget.config.duration,
      onComplete: widget.onDismiss,
    );

    // Execute onShow callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.config.onShow?.call();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Stack(
    children: [
      // Background blur
      if (widget.style.enableBackgroundBlur) _buildBackgroundBlur(),

      // Notification content
      _buildNotificationContent(),
    ],
  );

  /// Builds the background blur effect.
  Widget _buildBackgroundBlur() => AnimatedBuilder(
    animation: _animationController.backgroundAnimation,
    builder: (final context, final child) => Positioned.fill(
      child: GestureDetector(
        onTap: _handleBackgroundTap,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5 * _animationController.backgroundAnimation.value,
            sigmaY: 5 * _animationController.backgroundAnimation.value,
          ),
          child: Container(
            color: Colors.black.withValues(
              alpha: _animationController.backgroundAnimation.value,
            ),
          ),
        ),
      ),
    ),
  );

  /// Builds the main notification content with positioning and animations.
  Widget _buildNotificationContent() => Positioned(
    top: widget.style.position == NotificationPosition.top
        ? widget.style.margin.top
        : null,
    bottom: widget.style.position == NotificationPosition.bottom
        ? widget.style.margin.bottom
        : null,
    left: widget.style.margin.left,
    right: widget.style.margin.right,
    child: SafeArea(child: _buildAnimatedNotification()),
  );

  /// Builds the notification with appropriate animation.
  Widget _buildAnimatedNotification() {
    final Widget child = _buildInteractiveNotification();

    // Apply animation based on type
    switch (widget.style.animation) {
      case NotificationAnimation.slide:
        return SlideTransition(
          position: _animationController.slideAnimation,
          child: child,
        );
      case NotificationAnimation.fade:
        return FadeTransition(
          opacity: _animationController.fadeAnimation,
          child: child,
        );
      case NotificationAnimation.scale:
        return ScaleTransition(
          scale: _animationController.scaleAnimation,
          child: child,
        );
      case NotificationAnimation.none:
        return child;
    }
  }

  /// Builds the notification with interaction handlers.
  Widget _buildInteractiveNotification() {
    Widget notification = NotificationCard(
      content: widget.content,
      style: widget.style,
      progressAnimation: widget.style.showProgressBar
          ? _animationController.progressAnimation
          : null,
    );

    // Wrap with gesture detector for tap handling
    notification = GestureDetector(
      onTap: _handleNotificationTap,
      child: notification,
    );

    // Wrap with mouse region for hover handling
    notification = MouseRegion(
      onEnter: (_) => _handleHoverEnter(),
      onExit: (_) => _handleHoverExit(),
      child: notification,
    );

    // Wrap with dismissible for swipe-to-dismiss
    if (widget.style.enableSwipeToDismiss) {
      notification = Dismissible(
        key: UniqueKey(),
        direction: _getDismissDirection(),
        onDismissed: (_) => _handleSwipeDismiss(),
        child: notification,
      );
    }

    return notification;
  }

  /// Gets the allowed dismiss direction based on position.
  DismissDirection _getDismissDirection() {
    switch (widget.style.position) {
      case NotificationPosition.top:
        return DismissDirection.up;
      case NotificationPosition.bottom:
        return DismissDirection.down;
      case NotificationPosition.center:
        return DismissDirection.horizontal;
    }
  }

  /// Handles tap on the notification itself.
  void _handleNotificationTap() {
    widget.config.onTap?.call();

    if (widget.config.dismissOnTap) {
      _animationController.dismiss();
    }
  }

  /// Handles tap on the background (outside notification).
  void _handleBackgroundTap() {
    // Typically don't dismiss on background tap for better UX
    // But could be made configurable in the future
  }

  /// Handles mouse hover enter.
  void _handleHoverEnter() {
    if (widget.config.pauseOnHover) {
      _animationController.pauseAutoDismiss();
    }
  }

  /// Handles mouse hover exit.
  void _handleHoverExit() {
    if (widget.config.pauseOnHover) {
      _animationController.resumeAutoDismiss();
    }
  }

  /// Handles swipe-to-dismiss.
  void _handleSwipeDismiss() {
    widget.config.onDismissed?.call();
    widget.onDismiss();
  }
}
