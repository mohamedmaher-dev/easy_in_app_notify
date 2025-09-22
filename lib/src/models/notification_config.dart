import 'package:flutter/material.dart';

/// Configuration class for notification behavior and timing.
///
/// This class controls how long notifications are displayed, how they respond
/// to user interactions, and other behavioral settings.
@immutable
class NotificationConfig {
  /// Duration in seconds that the notification remains visible.
  /// Set to 0 to disable auto-dismiss.
  final int duration;

  /// Whether the notification can be dismissed by tapping on it.
  final bool dismissOnTap;

  /// Whether the notification should pause auto-dismiss when hovered.
  final bool pauseOnHover;

  /// Whether multiple notifications can be shown simultaneously.
  final bool allowMultiple;

  /// Callback executed when the notification is tapped.
  final VoidCallback? onTap;

  /// Callback executed when the notification is dismissed.
  final VoidCallback? onDismissed;

  /// Callback executed when the notification starts showing.
  final VoidCallback? onShow;

  /// Creates a new notification configuration.
  ///
  /// The [duration] determines how long the notification stays visible.
  /// Set to 0 to require manual dismissal.
  const NotificationConfig({
    this.duration = 4,
    this.dismissOnTap = false,
    this.pauseOnHover = true,
    this.allowMultiple = false,
    this.onTap,
    this.onDismissed,
    this.onShow,
  }) : assert(duration >= 0, 'Duration must be non-negative');

  /// Creates a configuration for persistent notifications (no auto-dismiss).
  const NotificationConfig.persistent({
    this.dismissOnTap = true,
    this.pauseOnHover = true,
    this.allowMultiple = false,
    this.onTap,
    this.onDismissed,
    this.onShow,
  }) : duration = 0;

  /// Creates a configuration for quick notifications (short duration).
  const NotificationConfig.quick({
    this.duration = 2,
    this.dismissOnTap = false,
    this.pauseOnHover = true,
    this.allowMultiple = false,
    this.onTap,
    this.onDismissed,
    this.onShow,
  });

  /// Creates a configuration for long notifications (extended duration).
  const NotificationConfig.long({
    this.duration = 8,
    this.dismissOnTap = false,
    this.pauseOnHover = true,
    this.allowMultiple = false,
    this.onTap,
    this.onDismissed,
    this.onShow,
  });

  /// Whether auto-dismiss is enabled (duration > 0).
  bool get autooDismiss => duration > 0;

  /// Creates a copy of this configuration with modified properties.
  NotificationConfig copyWith({
    final int? duration,
    final bool? dismissOnTap,
    final bool? pauseOnHover,
    final bool? allowMultiple,
    final VoidCallback? onTap,
    final VoidCallback? onDismissed,
    final VoidCallback? onShow,
  }) => NotificationConfig(
    duration: duration ?? this.duration,
    dismissOnTap: dismissOnTap ?? this.dismissOnTap,
    pauseOnHover: pauseOnHover ?? this.pauseOnHover,
    allowMultiple: allowMultiple ?? this.allowMultiple,
    onTap: onTap ?? this.onTap,
    onDismissed: onDismissed ?? this.onDismissed,
    onShow: onShow ?? this.onShow,
  );

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is NotificationConfig &&
          runtimeType == other.runtimeType &&
          duration == other.duration &&
          dismissOnTap == other.dismissOnTap &&
          pauseOnHover == other.pauseOnHover &&
          allowMultiple == other.allowMultiple &&
          onTap == other.onTap &&
          onDismissed == other.onDismissed &&
          onShow == other.onShow;

  @override
  int get hashCode => Object.hash(
    duration,
    dismissOnTap,
    pauseOnHover,
    allowMultiple,
    onTap,
    onDismissed,
    onShow,
  );

  @override
  String toString() =>
      'NotificationConfig(duration: $duration, dismissOnTap: $dismissOnTap)';
}
