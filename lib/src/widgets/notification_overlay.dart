part of '../easy_in_app_notify.dart';

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
      notificationId: widget.notificationId,
      onDismiss: () {
        EasyInAppNotify._removeDismissedNotification(widget.notificationId);
      },
    );
  }
}
