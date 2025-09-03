import 'package:flutter/material.dart';
import 'package:easy_in_app_notify/easy_in_app_notify.dart';

/// Enumeration of notification types for easy categorization
enum NotificationType { success, error, warning, info, loading }

/// Helper class providing convenient methods for common notification scenarios
class NotificationHelper {
  /// Show a success notification with green theming
  static void showSuccess(final String title, final String message) {
    EasyInAppNotify.show(
      content: EasyInAppNotifyContent(
        title: title,
        message: message,
        icon: Icons.check_circle,
      ),
      theme: const EasyInAppNotifyTheme(color: Colors.green),
      option: const EasyInAppNotifyOption(
        duration: 3, // Shorter duration for success messages
      ),
    );
  }

  /// Show an error notification with red theming
  static void showError(final String title, final String message) {
    EasyInAppNotify.show(
      content: EasyInAppNotifyContent(
        title: title,
        message: message,
        icon: Icons.error,
      ),
      theme: const EasyInAppNotifyTheme(
        color: Colors.red,
        elevation: 8, // Higher elevation for errors
      ),
      option: const EasyInAppNotifyOption(
        duration: 6, // Longer duration for errors
      ),
    );
  }

  /// Show a warning notification with orange theming
  static void showWarning(final String title, final String message) {
    EasyInAppNotify.show(
      content: EasyInAppNotifyContent(
        title: title,
        message: message,
        icon: Icons.warning,
      ),
      theme: const EasyInAppNotifyTheme(color: Colors.orange),
      option: const EasyInAppNotifyOption(),
    );
  }

  /// Show an info notification with blue theming
  static void showInfo(final String title, final String message) {
    EasyInAppNotify.show(
      content: EasyInAppNotifyContent(
        title: title,
        message: message,
        icon: Icons.info,
      ),
      theme: const EasyInAppNotifyTheme(color: Colors.blue),
      option: const EasyInAppNotifyOption(
        duration: 4, // Standard duration for info
      ),
    );
  }

  /// Show a loading notification that cannot be dismissed by swiping
  static void showLoading(final String title, final String message) {
    EasyInAppNotify.show(
      content: EasyInAppNotifyContent(
        title: title,
        message: message,
        icon: Icons.hourglass_empty,
      ),
      theme: const EasyInAppNotifyTheme(color: Colors.grey),
      option: const EasyInAppNotifyOption(
        duration: 8, // Longer duration for loading
        swipeToDismiss: false, // Cannot be dismissed during loading
      ),
    );
  }

  /// Show a notification based on the specified type
  static void showTypedNotification(
    final NotificationType type,
    final String title,
    final String message,
  ) {
    switch (type) {
      case NotificationType.success:
        showSuccess(title, message);
        break;
      case NotificationType.error:
        showError(title, message);
        break;
      case NotificationType.warning:
        showWarning(title, message);
        break;
      case NotificationType.info:
        showInfo(title, message);
        break;
      case NotificationType.loading:
        showLoading(title, message);
        break;
    }
  }

  /// Show a chat message notification (for messaging services)
  static void showChatMessage({
    required final String senderName,
    required final String message,
    final String? timestamp,
  }) {
    EasyInAppNotify.show(
      content: EasyInAppNotifyContent(
        title: 'New message from $senderName',
        message: message,
        icon: Icons.chat,
        trailingText: timestamp ?? 'Now',
      ),
      theme: const EasyInAppNotifyTheme(color: Colors.green),
      option: const EasyInAppNotifyOption(duration: 6),
    );
  }

  /// Show an order update notification (for e-commerce apps)
  static void showOrderUpdate({
    required final String orderId,
    required final String status,
    required final String message,
  }) {
    Color statusColor;
    IconData statusIcon;

    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'paid':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'shipped':
      case 'in_transit':
        statusColor = Colors.blue;
        statusIcon = Icons.local_shipping;
        break;
      case 'delivered':
        statusColor = Colors.purple;
        statusIcon = Icons.done_all;
        break;
      case 'cancelled':
      case 'failed':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = Colors.orange;
        statusIcon = Icons.info;
    }

    EasyInAppNotify.show(
      content: EasyInAppNotifyContent(
        title: 'Order Update',
        message: message,
        icon: statusIcon,
        trailingText: '#$orderId',
      ),
      theme: EasyInAppNotifyTheme(color: statusColor),
    );
  }

  /// Show a promotional notification (for marketing messages)
  static void showPromotion({
    required final String title,
    required final String message,
    final String? promoCode,
    final int? discountPercent,
  }) {
    String displayTitle = title;
    if (discountPercent != null) {
      displayTitle = '$title - $discountPercent% OFF!';
    }

    EasyInAppNotify.show(
      content: EasyInAppNotifyContent(
        title: displayTitle,
        message: message,
        icon: Icons.local_offer,
        trailingText: promoCode ?? 'Limited Time',
      ),
      theme: const EasyInAppNotifyTheme(
        color: Colors.orange,
        elevation: 10, // Higher elevation for promotions
      ),
      option: const EasyInAppNotifyOption(
        duration: 8, // Longer duration for promotions
      ),
    );
  }

  /// Show a system alert notification (for important system messages)
  static void showSystemAlert({
    required final String title,
    required final String message,
    final bool isUrgent = false,
  }) {
    EasyInAppNotify.show(
      content: EasyInAppNotifyContent(
        title: title,
        message: message,
        icon: isUrgent ? Icons.priority_high : Icons.notifications_active,
        trailingText: isUrgent ? 'URGENT' : 'System',
      ),
      theme: EasyInAppNotifyTheme(
        color: isUrgent ? Colors.red : Colors.indigo,
        elevation: isUrgent ? 15 : 8,
      ),
      option: EasyInAppNotifyOption(
        duration: isUrgent ? 10 : 6,
        swipeToDismiss: !isUrgent, // Urgent alerts cannot be swiped away
      ),
    );
  }

  /// Show a custom notification with full control over styling
  static void showCustom({
    required final String title,
    required final String message,
    final IconData? icon,
    final String? trailingText,
    final Color? color,
    final int duration = 5,
    final bool showProgressBar = true,
    final bool swipeToDismiss = true,
    final double? elevation,
    final double? radius,
  }) {
    EasyInAppNotify.show(
      content: EasyInAppNotifyContent(
        title: title,
        message: message,
        icon: icon,
        trailingText: trailingText,
      ),
      theme: EasyInAppNotifyTheme(
        color: color,
        elevation: elevation ?? 5,
        radius: radius ?? 10,
      ),
      option: EasyInAppNotifyOption(
        duration: duration,
        showProgressBar: showProgressBar,
        swipeToDismiss: swipeToDismiss,
      ),
    );
  }

  /// Utility method to determine notification type based on keywords in message
  static NotificationType detectNotificationType(final String message) {
    final lowerMessage = message.toLowerCase();

    if (lowerMessage.contains('success') ||
        lowerMessage.contains('completed') ||
        lowerMessage.contains('done')) {
      return NotificationType.success;
    } else if (lowerMessage.contains('error') ||
        lowerMessage.contains('failed') ||
        lowerMessage.contains('problem')) {
      return NotificationType.error;
    } else if (lowerMessage.contains('warning') ||
        lowerMessage.contains('caution') ||
        lowerMessage.contains('attention')) {
      return NotificationType.warning;
    } else if (lowerMessage.contains('loading') ||
        lowerMessage.contains('processing') ||
        lowerMessage.contains('wait')) {
      return NotificationType.loading;
    } else {
      return NotificationType.info;
    }
  }

  /// Show a smart notification that automatically determines type from message content
  static void showSmart(final String title, final String message) {
    final type = detectNotificationType(message);
    showTypedNotification(type, title, message);
  }
}
