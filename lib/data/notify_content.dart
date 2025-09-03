part of '../easy_in_app_notify.dart';

/// Data model containing the content to be displayed in an in-app notification.
///
/// This class encapsulates all the textual and visual content that will be
/// shown to the user in a notification overlay.
class EasyInAppNotifyContent {
  /// The main title/heading of the notification.
  ///
  /// This will be displayed prominently and typically describes what
  /// the notification is about in a concise manner.
  final String title;

  /// The detailed message content of the notification.
  ///
  /// This provides additional context or information about the notification
  /// and will be displayed below the title with a smaller font.
  final String message;

  /// Optional icon to display alongside the notification content.
  ///
  /// If not provided, defaults to [CupertinoIcons.bell]. The icon helps
  /// users quickly identify the type or category of notification.
  final IconData? icon;

  /// Optional trailing text to display on the right side of the notification.
  ///
  /// This is typically used for timestamps, additional context, or action hints
  /// like "Tap to view" or "2m ago".
  final String? trailingText;

  /// Creates a new notification content instance.
  ///
  /// [title] and [message] are required and will be the primary content
  /// displayed to users. [icon] and [trailingText] are optional and can
  /// be used to enhance the notification with visual and contextual information.
  const EasyInAppNotifyContent({
    required this.title,
    required this.message,
    this.icon,
    this.trailingText,
  });
}
