part of '../easy_in_app_notify.dart';

/// Widget that displays the main textual content of the notification.
///
/// This widget renders the notification's title, message, icon, and optional
/// trailing text using Material Design's ListTile component for consistent
/// layout and typography.
class _NotificationContent extends StatelessWidget {
  /// Creates a new notification content widget.
  const _NotificationContent();

  @override
  Widget build(final BuildContext context) {
    // Get theming and content data from Provider context
    final content = Provider.of<EasyInAppNotifyContent>(context);

    return ListTile(
      // Icon displayed on the left side
      leading: const _NotificationIcon(),

      // Main notification title with emphasized font weight
      title: Text(
        content.title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),

      // Notification message displayed below the title
      subtitle: Text(
        content.message,
        style: Theme.of(context).textTheme.bodyMedium,
      ),

      // Optional trailing widget or text (e.g., timestamp, action hint)
      trailing:
          content.trailing ??
          (content.trailingText != null
              ? Text(
                  content.trailingText!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                )
              : null),
    );
  }
}
