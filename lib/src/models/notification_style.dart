import 'package:flutter/material.dart';

/// Position where the notification should appear on screen.
enum NotificationPosition { top, bottom, center }

/// Animation type for notification entry and exit.
enum NotificationAnimation { slide, fade, scale, none }

/// Configuration class for notification visual styling and behavior.
///
/// This class defines how the notification looks and behaves, including
/// colors, animations, positioning, and interaction settings.
@immutable
class NotificationStyle {
  /// Primary color used for the notification theme.
  final Color primaryColor;

  /// Background color of the notification card.
  final Color backgroundColor;

  /// Text color for the title and message.
  final Color textColor;

  /// Icon color, defaults to [primaryColor] if not specified.
  final Color? iconColor;

  /// Border radius for rounded corners.
  final double borderRadius;

  /// Elevation/shadow depth of the notification card.
  final double elevation;

  /// Margin around the notification from screen edges.
  final EdgeInsets margin;

  /// Padding inside the notification card.
  final EdgeInsets padding;

  /// Position where the notification appears.
  final NotificationPosition position;

  /// Animation type for show/hide transitions.
  final NotificationAnimation animation;

  /// Duration of the entrance/exit animations.
  final Duration animationDuration;

  /// Whether to show a progress bar indicating auto-dismiss countdown.
  final bool showProgressBar;

  /// Whether to enable swipe-to-dismiss functionality.
  final bool enableSwipeToDismiss;

  /// Whether to blur the background behind the notification.
  final bool enableBackgroundBlur;

  /// Opacity of the background blur effect (0.0 to 1.0).
  final double backgroundBlurOpacity;

  /// Maximum width of the notification (null for full width).
  final double? maxWidth;

  /// Creates a new notification style configuration.
  const NotificationStyle({
    this.primaryColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
    this.iconColor,
    this.borderRadius = 8.0,
    this.elevation = 4.0,
    this.margin = const EdgeInsets.all(16.0),
    this.padding = const EdgeInsets.all(16.0),
    this.position = NotificationPosition.top,
    this.animation = NotificationAnimation.slide,
    this.animationDuration = const Duration(milliseconds: 300),
    this.showProgressBar = false,
    this.enableSwipeToDismiss = true,
    this.enableBackgroundBlur = false,
    this.backgroundBlurOpacity = 0.1,
    this.maxWidth,
  });

  /// Creates a success-themed notification style.
  const NotificationStyle.success({
    this.primaryColor = Colors.green,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
    this.iconColor,
    this.borderRadius = 8.0,
    this.elevation = 4.0,
    this.margin = const EdgeInsets.all(16.0),
    this.padding = const EdgeInsets.all(16.0),
    this.position = NotificationPosition.top,
    this.animation = NotificationAnimation.slide,
    this.animationDuration = const Duration(milliseconds: 300),
    this.showProgressBar = false,
    this.enableSwipeToDismiss = true,
    this.enableBackgroundBlur = false,
    this.backgroundBlurOpacity = 0.1,
    this.maxWidth,
  });

  /// Creates an error-themed notification style.
  const NotificationStyle.error({
    this.primaryColor = Colors.red,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
    this.iconColor,
    this.borderRadius = 8.0,
    this.elevation = 4.0,
    this.margin = const EdgeInsets.all(16.0),
    this.padding = const EdgeInsets.all(16.0),
    this.position = NotificationPosition.top,
    this.animation = NotificationAnimation.slide,
    this.animationDuration = const Duration(milliseconds: 300),
    this.showProgressBar = false,
    this.enableSwipeToDismiss = true,
    this.enableBackgroundBlur = false,
    this.backgroundBlurOpacity = 0.1,
    this.maxWidth,
  });

  /// Creates a warning-themed notification style.
  const NotificationStyle.warning({
    this.primaryColor = Colors.orange,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
    this.iconColor,
    this.borderRadius = 8.0,
    this.elevation = 4.0,
    this.margin = const EdgeInsets.all(16.0),
    this.padding = const EdgeInsets.all(16.0),
    this.position = NotificationPosition.top,
    this.animation = NotificationAnimation.slide,
    this.animationDuration = const Duration(milliseconds: 300),
    this.showProgressBar = false,
    this.enableSwipeToDismiss = true,
    this.enableBackgroundBlur = false,
    this.backgroundBlurOpacity = 0.1,
    this.maxWidth,
  });

  /// Creates an info-themed notification style.
  const NotificationStyle.info({
    this.primaryColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
    this.iconColor,
    this.borderRadius = 8.0,
    this.elevation = 4.0,
    this.margin = const EdgeInsets.all(16.0),
    this.padding = const EdgeInsets.all(16.0),
    this.position = NotificationPosition.top,
    this.animation = NotificationAnimation.slide,
    this.animationDuration = const Duration(milliseconds: 300),
    this.showProgressBar = false,
    this.enableSwipeToDismiss = true,
    this.enableBackgroundBlur = false,
    this.backgroundBlurOpacity = 0.1,
    this.maxWidth,
  });

  /// Gets the effective icon color (uses primaryColor if iconColor is null).
  Color get effectiveIconColor => iconColor ?? primaryColor;

  /// Creates a copy of this style with modified properties.
  NotificationStyle copyWith({
    final Color? primaryColor,
    final Color? backgroundColor,
    final Color? textColor,
    final Color? iconColor,
    final double? borderRadius,
    final double? elevation,
    final EdgeInsets? margin,
    final EdgeInsets? padding,
    final NotificationPosition? position,
    final NotificationAnimation? animation,
    final Duration? animationDuration,
    final bool? showProgressBar,
    final bool? enableSwipeToDismiss,
    final bool? enableBackgroundBlur,
    final double? backgroundBlurOpacity,
    final double? maxWidth,
  }) => NotificationStyle(
    primaryColor: primaryColor ?? this.primaryColor,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    textColor: textColor ?? this.textColor,
    iconColor: iconColor ?? this.iconColor,
    borderRadius: borderRadius ?? this.borderRadius,
    elevation: elevation ?? this.elevation,
    margin: margin ?? this.margin,
    padding: padding ?? this.padding,
    position: position ?? this.position,
    animation: animation ?? this.animation,
    animationDuration: animationDuration ?? this.animationDuration,
    showProgressBar: showProgressBar ?? this.showProgressBar,
    enableSwipeToDismiss: enableSwipeToDismiss ?? this.enableSwipeToDismiss,
    enableBackgroundBlur: enableBackgroundBlur ?? this.enableBackgroundBlur,
    backgroundBlurOpacity: backgroundBlurOpacity ?? this.backgroundBlurOpacity,
    maxWidth: maxWidth ?? this.maxWidth,
  );

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is NotificationStyle &&
          runtimeType == other.runtimeType &&
          primaryColor == other.primaryColor &&
          backgroundColor == other.backgroundColor &&
          textColor == other.textColor &&
          iconColor == other.iconColor &&
          borderRadius == other.borderRadius &&
          elevation == other.elevation &&
          margin == other.margin &&
          padding == other.padding &&
          position == other.position &&
          animation == other.animation &&
          animationDuration == other.animationDuration &&
          showProgressBar == other.showProgressBar &&
          enableSwipeToDismiss == other.enableSwipeToDismiss &&
          enableBackgroundBlur == other.enableBackgroundBlur &&
          backgroundBlurOpacity == other.backgroundBlurOpacity &&
          maxWidth == other.maxWidth;

  @override
  int get hashCode => Object.hash(
    primaryColor,
    backgroundColor,
    textColor,
    iconColor,
    borderRadius,
    elevation,
    margin,
    padding,
    position,
    animation,
    animationDuration,
    showProgressBar,
    enableSwipeToDismiss,
    enableBackgroundBlur,
    backgroundBlurOpacity,
    maxWidth,
  );

  @override
  String toString() =>
      'NotificationStyle(primaryColor: $primaryColor, position: $position)';
}
