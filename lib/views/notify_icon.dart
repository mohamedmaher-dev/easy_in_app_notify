part of '../easy_in_app_notify.dart';

/// Widget that displays the notification icon with styled background.
///
/// This widget renders an icon within a rounded container with a subtle
/// background color. The icon helps users quickly identify the notification
/// type or category.
class _NotificationIcon extends StatelessWidget {
  /// Creates a new notification icon widget.
  const _NotificationIcon();

  @override
  Widget build(final BuildContext context) {
    // Get content data and theming from Provider context
    final content = Provider.of<EasyInAppNotifyContent>(context);
    final theme = Provider.of<EasyInAppNotifyTheme>(context);

    // Create subtle background color using primary color with transparency
    final primaryBackgroundColor = Theme.of(
      context,
    ).colorScheme.primary.withAlpha(kBackgroundColorAlpha);

    return Container(
      padding: EdgeInsets.all(theme.padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(theme.radius),
        // Use custom theme color or default primary color for background
        color: theme.color == null
            ? primaryBackgroundColor
            : theme.color!.withAlpha(kBackgroundColorAlpha),
      ),
      child: Icon(
        // Use custom icon or default bell icon
        content.icon ?? CupertinoIcons.bell,
        // Use custom theme color or default primary color for icon
        color: theme.color ?? Theme.of(context).colorScheme.primary,
        size: theme.iconSize,
      ),
    );
  }
}
