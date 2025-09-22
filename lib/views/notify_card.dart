part of '../easy_in_app_notify.dart';

/// Card widget that provides the visual structure for the notification content.
///
/// This widget creates the Material card appearance with rounded corners,
/// elevation, and shadow. It organizes the notification content and optional
/// progress bar in a vertical layout.
class _NotifyCard extends StatelessWidget {
  final EasyInAppNotifyTheme theme;
  final EasyInAppNotifyContent content;

  /// Animation that drives the progress bar countdown visualization.
  final Animation<double> progressAnimation;

  /// Creates a new notification card.
  ///
  /// Requires the progress animation to coordinate with the visual countdown
  /// when the progress bar is enabled.
  const _NotifyCard({
    required this.progressAnimation,
    required this.content,
    required this.theme,
  });

  @override
  Widget build(final BuildContext context) => Card(
    // Apply themed styling for consistent Material appearance
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(theme.radius),
    ),
    elevation: theme.elevation,
    child: Column(
      mainAxisSize: MainAxisSize.min, // Minimize vertical space usage
      children: [
        // Always show the main notification content
        _NotificationContent(content: content, theme: theme),

        // Conditionally show progress bar based on options
        if (EasyInAppNotify._currentOption.showProgressBar)
          _NotifyProgress(animation: progressAnimation, theme: theme),
      ],
    ),
  );
}
