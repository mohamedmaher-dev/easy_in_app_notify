import 'package:easy_in_app_notify/easy_in_app_notify.dart';

/// Internal data class to store notification configuration for the registry system.
///
/// This class serves as a container for all notification-related data that needs
/// to be preserved during the notification lifecycle. It's used internally by
/// the notification management system to handle complex scenarios like:
///
/// ## Multi-Notification Support
///
/// When multiple notifications are displayed simultaneously:
/// - Each notification gets a unique ID and corresponding [NotificationData] entry
/// - The registry maps notification IDs to their data for reliable retrieval
/// - Prevents data corruption when notifications overlap or dismiss rapidly
/// - Handles race conditions between widget creation and data availability
///
/// ## Data Persistence
///
/// The notification data is stored in the registry from creation until cleanup:
/// 1. **Creation**: Data is stored immediately when `show()` is called
/// 2. **Display**: Overlay widgets retrieve data using their notification ID
/// 3. **Dismissal**: Data is removed after animation completes
/// 4. **Cleanup**: Delayed removal prevents race conditions during widget disposal
///
/// ## Thread Safety
///
/// This immutable data structure ensures thread-safe access across:
/// - UI thread (widget building)
/// - Timer callbacks (auto-dismiss)
/// - User interactions (tap/swipe gestures)
/// - State changes (app lifecycle events)
///
/// Example usage in registry:
/// ```dart
/// _notificationRegistry[notificationId] = NotificationData(
///   content: NotificationContent.success(title: 'Success!'),
///   style: NotificationStyle.success(),
///   config: NotificationConfig(duration: 3),
/// );
/// ```
class NotificationData {
  /// The notification content including title, message, and icon.
  ///
  /// Contains all the textual and visual content that will be displayed
  /// to the user. This includes the notification title, optional message,
  /// icon, and any custom styling properties.
  final NotificationContent content;

  /// The visual styling configuration for the notification.
  ///
  /// Defines how the notification will appear visually, including:
  /// - Colors (primary, background, text)
  /// - Position (top, center, bottom)
  /// - Animation type (slide, fade, scale)
  /// - Layout properties (padding, margin, border radius)
  /// - Effects (blur, elevation, progress bar)
  final NotificationStyle style;

  /// The behavioral configuration for the notification.
  ///
  /// Controls how the notification behaves during its lifecycle:
  /// - Duration and auto-dismiss timing
  /// - User interaction handling (tap, swipe)
  /// - Multi-notification management
  /// - Callback functions for events
  final NotificationConfig config;

  /// Creates a new notification data container.
  ///
  /// All parameters are required to ensure complete notification configuration.
  /// This constructor is typically called internally by the notification system
  /// when storing data in the registry.
  ///
  /// Parameters:
  /// - [content]: The notification content and text
  /// - [style]: The visual styling configuration
  /// - [config]: The behavioral configuration
  const NotificationData({
    required this.content,
    required this.style,
    required this.config,
  });

  /// Returns a string representation of the notification data.
  ///
  /// Useful for debugging and logging notification state during development.
  /// Includes key properties from all three configuration objects.
  @override
  String toString() =>
      'NotificationData('
      'title: ${content.title}, '
      'position: ${style.position}, '
      'duration: ${config.duration}'
      ')';

  /// Compares two [NotificationData] instances for equality.
  ///
  /// Two instances are considered equal if all their configuration
  /// properties are identical. This is useful for testing and
  /// state management scenarios.
  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is NotificationData &&
          runtimeType == other.runtimeType &&
          content == other.content &&
          style == other.style &&
          config == other.config;

  /// Generates a hash code for this notification data.
  ///
  /// Used by Dart's collection classes and for equality comparisons.
  /// Based on the hash codes of all three configuration objects.
  @override
  int get hashCode => Object.hash(content, style, config);
}
