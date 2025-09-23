import 'dart:async';
import 'models/notification_data.dart';
import 'package:flutter/material.dart';
import 'models/notification_content.dart';
import 'models/notification_style.dart';
import 'models/notification_config.dart';
import 'widgets/notification_wrapper.dart';
part 'widgets/notification_overlay.dart';

/// Main API class for displaying in-app notifications.
///
/// This class provides a simple, clean API for showing notifications with
/// rich customization options. It manages the notification overlay system
/// and handles multiple notification scenarios.
///
/// Example usage:
/// ```dart
/// // Simple notification
/// EasyInAppNotify.show(
///   content: NotificationContent.success(
///     title: 'Success!',
///     message: 'Your action was completed successfully.',
///   ),
/// );
///
/// // Fully customized notification
/// EasyInAppNotify.show(
///   content: NotificationContent(
///     title: 'Custom Notification',
///     message: 'This is a customized notification.',
///     icon: Icons.star,
///   ),
///   style: NotificationStyle(
///     primaryColor: Colors.purple,
///     position: NotificationPosition.bottom,
///     enableBackgroundBlur: true,
///     showProgressBar: true,
///   ),
///   config: NotificationConfig(
///     duration: 5,
///     dismissOnTap: true,
///   ),
/// );
/// ```
class EasyInAppNotify {
  // Private constructor to prevent instantiation
  EasyInAppNotify._();

  // State management
  static final ValueNotifier<List<String>> _activeNotifications =
      ValueNotifier<List<String>>([]);
  static final Map<String, Timer> _autoDismissTimers = {};
  static final Map<String, NotificationData> _notificationRegistry = {};
  static final Map<String, VoidCallback> _dismissCallbacks = {};
  static int _notificationCounter = 0;

  /// Dismisses existing notifications when allowMultiple is false.
  ///
  /// This method handles the dismissal of currently active notifications
  /// and schedules cleanup of their registry entries after a delay to
  /// prevent race conditions.
  static void _dismissExistingNotifications() {
    // Only dismiss from the active list, but keep the registry intact
    // until the widgets are actually removed
    final oldNotifications = List<String>.from(_activeNotifications.value);
    for (final oldId in oldNotifications) {
      _autoDismissTimers.remove(oldId)?.cancel();
    }
    _activeNotifications.value = [];

    // Clean up old registry entries after a short delay to allow widgets to finish
    Future.delayed(const Duration(milliseconds: 100), () {
      for (final oldId in oldNotifications) {
        _notificationRegistry.remove(oldId);
      }
    });
  }

  /// Shows a notification with the specified content, style, and configuration.
  ///
  /// This is the main method for displaying notifications. It supports both
  /// simple and highly customized notifications through the parameter objects.
  ///
  /// Parameters:
  /// - [content]: The notification content (title, message, icon, etc.)
  /// - [style]: Visual styling and positioning (optional)
  /// - [config]: Behavior and timing configuration (optional)
  ///
  /// Returns a unique identifier for the notification that can be used
  /// to dismiss it programmatically.
  ///
  /// Example:
  /// ```dart
  /// String notificationId = EasyInAppNotify.show(
  ///   content: NotificationContent.info(
  ///     title: 'Information',
  ///     message: 'Here is some important information.',
  ///   ),
  ///   style: NotificationStyle.info(),
  ///   config: NotificationConfig(duration: 4),
  /// );
  /// ```
  static String show({
    required final NotificationContent content,
    final NotificationStyle style = const NotificationStyle(),
    final NotificationConfig config = const NotificationConfig(),
  }) {
    // Generate unique ID for this notification
    final notificationId = 'notification_${++_notificationCounter}';

    // Store notification data in registry FIRST
    _notificationRegistry[notificationId] = NotificationData(
      content: content,
      style: style,
      config: config,
    );

    // Check if multiple notifications are allowed
    if (!config.allowMultiple && _activeNotifications.value.isNotEmpty) {
      _dismissExistingNotifications();
    }

    // Add to active notifications
    final currentNotifications = List<String>.from(_activeNotifications.value);
    currentNotifications.add(notificationId);
    _activeNotifications.value = currentNotifications;

    return notificationId;
  }

  /// Shows a simple success notification.
  ///
  /// Convenience method for displaying success notifications with predefined
  /// styling and sensible defaults.
  ///
  /// Example:
  /// ```dart
  /// EasyInAppNotify.showSuccess(
  ///   title: 'Data Saved',
  ///   message: 'Your changes have been saved successfully.',
  /// );
  /// ```
  static String showSuccess({
    required final String title,
    final String? message,
    final NotificationConfig? config,
  }) => EasyInAppNotify.show(
    content: NotificationContent.success(title: title, message: message),
    style: const NotificationStyle.success(),
    config: config ?? const NotificationConfig(),
  );

  /// Shows a simple error notification.
  ///
  /// Convenience method for displaying error notifications with predefined
  /// styling and sensible defaults.
  ///
  /// Example:
  /// ```dart
  /// EasyInAppNotify.showError(
  ///   title: 'Error',
  ///   message: 'Something went wrong. Please try again.',
  /// );
  /// ```
  static String showError({
    required final String title,
    final String? message,
    final NotificationConfig? config,
  }) => EasyInAppNotify.show(
    content: NotificationContent.error(title: title, message: message),
    style: const NotificationStyle.error(),
    config: config ?? const NotificationConfig(),
  );

  /// Shows a simple warning notification.
  ///
  /// Convenience method for displaying warning notifications with predefined
  /// styling and sensible defaults.
  ///
  /// Example:
  /// ```dart
  /// EasyInAppNotify.showWarning(
  ///   title: 'Warning',
  ///   message: 'Please check your input and try again.',
  /// );
  /// ```
  static String showWarning({
    required final String title,
    final String? message,
    final NotificationConfig? config,
  }) => EasyInAppNotify.show(
    content: NotificationContent.warning(title: title, message: message),
    style: const NotificationStyle.warning(),
    config: config ?? const NotificationConfig(),
  );

  /// Shows a simple info notification.
  ///
  /// Convenience method for displaying informational notifications with
  /// predefined styling and sensible defaults.
  ///
  /// Example:
  /// ```dart
  /// EasyInAppNotify.showInfo(
  ///   title: 'Information',
  ///   message: 'Here is some useful information.',
  /// );
  /// ```
  static String showInfo({
    required final String title,
    final String? message,
    final NotificationConfig? config,
  }) => EasyInAppNotify.show(
    content: NotificationContent.info(title: title, message: message),
    config: config ?? const NotificationConfig(),
  );

  /// Registers a dismiss callback for a notification.
  ///
  /// This is used internally by the notification wrapper to register
  /// its animation controller's dismiss method.
  static void registerDismissCallback(
    final String notificationId,
    final VoidCallback callback,
  ) {
    _dismissCallbacks[notificationId] = callback;
  }

  /// Dismisses a specific notification by its ID.
  ///
  /// The notification will be removed with its configured exit animation.
  /// If the notification ID is not found, this method does nothing.
  ///
  /// Example:
  /// ```dart
  /// String id = EasyInAppNotify.showInfo(title: 'Info');
  /// // Later...
  /// EasyInAppNotify.dismiss(id);
  /// ```
  static void dismiss(final String notificationId) {
    // First try to trigger the animation controller's dismiss method
    final dismissCallback = _dismissCallbacks[notificationId];
    if (dismissCallback != null) {
      dismissCallback();
    } else {
      // Fallback: immediate removal without animation
      _removeDismissedNotification(notificationId);
    }
  }

  /// Internal method to remove a notification after animation completes.
  static void _removeDismissedNotification(final String notificationId) {
    final currentNotifications = List<String>.from(_activeNotifications.value);
    if (currentNotifications.remove(notificationId)) {
      _activeNotifications.value = currentNotifications;
      _autoDismissTimers.remove(notificationId)?.cancel();
      _notificationRegistry.remove(notificationId);
      _dismissCallbacks.remove(notificationId);
    }
  }

  /// Dismisses all currently active notifications.
  ///
  /// All notifications will be removed with their configured exit animations.
  /// This is useful for cleanup when navigating between screens or
  /// when showing critical notifications that require full attention.
  ///
  /// Example:
  /// ```dart
  /// EasyInAppNotify.dismissAll();
  /// ```
  static void dismissAll() {
    final notificationIds = List<String>.from(_activeNotifications.value);
    for (final notificationId in notificationIds) {
      dismiss(notificationId);
    }
  }

  /// Returns the number of currently active notifications.
  ///
  /// This can be useful for determining if notifications are currently
  /// being displayed or for implementing custom notification limits.
  ///
  /// Example:
  /// ```dart
  /// if (EasyInAppNotify.activeCount > 3) {
  ///   EasyInAppNotify.dismissAll();
  /// }
  /// ```
  static int get activeCount => _activeNotifications.value.length;

  /// Returns true if any notifications are currently active.
  ///
  /// This is a convenience getter for checking notification state.
  ///
  /// Example:
  /// ```dart
  /// if (EasyInAppNotify.hasActiveNotifications) {
  ///   print('Notifications are currently being displayed');
  /// }
  /// ```
  static bool get hasActiveNotifications =>
      _activeNotifications.value.isNotEmpty;

  /// Returns the initialization builder for the notification overlay system.
  ///
  /// This method must be used in your MaterialApp's builder property to
  /// set up the notification overlay system. Without this, notifications
  /// will not be displayed.
  ///
  /// Example:
  /// ```dart
  /// MaterialApp(
  ///   builder: EasyInAppNotify.init(),
  ///   home: MyHomePage(),
  /// )
  /// ```
  static TransitionBuilder init() =>
      (final BuildContext context, final Widget? child) => Stack(
        children: [
          child!,
          ValueListenableBuilder<List<String>>(
            valueListenable: _activeNotifications,
            builder: (final context, final activeNotifications, _) => Stack(
              children: activeNotifications
                  .map(
                    (final id) => _NotificationOverlay(
                      key: ValueKey(id),
                      notificationId: id,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      );
}
