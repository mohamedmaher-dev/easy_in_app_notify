import 'package:flutter/material.dart';

/// Configuration class for notification content including text, icons, and actions.
///
/// This class defines all the content that will be displayed in the notification,
/// including the title, message, icon, and any additional visual elements.
@immutable
class NotificationContent {
  /// The main title text displayed prominently in the notification.
  final String title;

  /// The secondary message text providing additional details.
  final String? message;

  /// Optional icon displayed alongside the text content.
  final IconData? icon;

  /// Optional trailing widget (e.g., action button, badge).
  final Widget? trailing;

  /// Optional custom widget to replace the entire content area.
  final Widget? customContent;

  /// Creates a new notification content configuration.
  ///
  /// The [title] is required and should be a concise, descriptive text.
  /// The [message] provides additional context or details.
  /// Use [icon] to add visual context to the notification type.
  /// Use [trailing] for action buttons or status indicators.
  /// Use [customContent] to completely override the default layout.
  const NotificationContent({
    required this.title,
    this.message,
    this.icon,
    this.trailing,
    this.customContent,
  });

  /// Creates a success notification with predefined styling hints.
  const NotificationContent.success({
    required this.title,
    this.message,
    this.icon = Icons.check_circle,
    this.trailing,
    this.customContent,
  });

  /// Creates an error notification with predefined styling hints.
  const NotificationContent.error({
    required this.title,
    this.message,
    this.icon = Icons.error,
    this.trailing,
    this.customContent,
  });

  /// Creates a warning notification with predefined styling hints.
  const NotificationContent.warning({
    required this.title,
    this.message,
    this.icon = Icons.warning,
    this.trailing,
    this.customContent,
  });

  /// Creates an info notification with predefined styling hints.
  const NotificationContent.info({
    required this.title,
    this.message,
    this.icon = Icons.info,
    this.trailing,
    this.customContent,
  });

  /// Creates a copy of this content with modified properties.
  NotificationContent copyWith({
    final String? title,
    final String? message,
    final IconData? icon,
    final Widget? trailing,
    final Widget? customContent,
  }) => NotificationContent(
    title: title ?? this.title,
    message: message ?? this.message,
    icon: icon ?? this.icon,
    trailing: trailing ?? this.trailing,
    customContent: customContent ?? this.customContent,
  );

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is NotificationContent &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          message == other.message &&
          icon == other.icon &&
          trailing == other.trailing &&
          customContent == other.customContent;

  @override
  int get hashCode =>
      title.hashCode ^
      message.hashCode ^
      icon.hashCode ^
      trailing.hashCode ^
      customContent.hashCode;

  @override
  String toString() => 'NotificationContent(title: $title, message: $message)';
}
