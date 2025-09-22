import 'dart:async';
import 'package:flutter/material.dart';
import 'models/notification_content.dart';
import 'models/notification_style.dart';
import 'models/notification_config.dart';
import 'widgets/notification_wrapper.dart';

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
  static final Map<String, _NotificationData> _notificationRegistry = {};
  static int _notificationCounter = 0;

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
    _notificationRegistry[notificationId] = _NotificationData(
      content: content,
      style: style,
      config: config,
    );

    // Check if multiple notifications are allowed
    if (!config.allowMultiple && _activeNotifications.value.isNotEmpty) {
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
  }) => show(
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
  }) => show(
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
  }) => show(
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
  }) => show(
    content: NotificationContent.info(title: title, message: message),
    config: config ?? const NotificationConfig(),
  );

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
    final currentNotifications = List<String>.from(_activeNotifications.value);
    if (currentNotifications.remove(notificationId)) {
      _activeNotifications.value = currentNotifications;
      _autoDismissTimers.remove(notificationId)?.cancel();
      _notificationRegistry.remove(notificationId);
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
    for (final timer in _autoDismissTimers.values) {
      timer.cancel();
    }
    _autoDismissTimers.clear();
    _notificationRegistry.clear();
    _activeNotifications.value = [];
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

/// Internal data class to store notification configuration.
class _NotificationData {
  final NotificationContent content;
  final NotificationStyle style;
  final NotificationConfig config;

  const _NotificationData({
    required this.content,
    required this.style,
    required this.config,
  });
}

/// Internal widget that manages individual notification overlays.
///
/// This widget is used internally by the notification system and should
/// not be used directly by consumers of the package.
class _NotificationOverlay extends StatefulWidget {
  final String notificationId;

  const _NotificationOverlay({super.key, required this.notificationId});

  @override
  State<_NotificationOverlay> createState() => _NotificationOverlayState();
}

class _NotificationOverlayState extends State<_NotificationOverlay> {
  NotificationContent? _content;
  NotificationStyle? _style;
  NotificationConfig? _config;

  @override
  void initState() {
    super.initState();
    _loadNotificationData();
  }

  void _loadNotificationData() {
    // Get notification data from registry
    final notificationData =
        EasyInAppNotify._notificationRegistry[widget.notificationId];
    if (notificationData != null) {
      setState(() {
        _content = notificationData.content;
        _style = notificationData.style;
        _config = notificationData.config;
      });
    } else {
      // If data is not available yet, try again after a short delay
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted) {
          final retryData =
              EasyInAppNotify._notificationRegistry[widget.notificationId];
          if (retryData != null) {
            setState(() {
              _content = retryData.content;
              _style = retryData.style;
              _config = retryData.config;
            });
          } else {
            // Final fallback
            setState(() {
              _content = const NotificationContent(
                title: 'Unknown Notification',
                message: 'Notification data not found.',
                icon: Icons.error,
              );
              _style = const NotificationStyle();
              _config = const NotificationConfig();
            });
          }
        }
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    // Return empty container if data is not yet loaded
    if (_content == null || _style == null || _config == null) {
      return const SizedBox.shrink();
    }

    return NotificationWrapper(
      content: _content!,
      style: _style!,
      config: _config!,
      onDismiss: () {
        EasyInAppNotify.dismiss(widget.notificationId);
      },
    );
  }
}
