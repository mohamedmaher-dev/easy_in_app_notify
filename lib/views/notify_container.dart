part of '../easy_in_app_notify.dart';

/// Container widget that handles positioning, animations, and user interactions.
///
/// This widget serves as the outer shell for notifications, managing their
/// position on screen, slide animations, and optional swipe-to-dismiss functionality.
/// It ensures proper positioning within safe areas and applies Material theming.
class _NotifyContainer extends StatelessWidget {
  final EasyInAppNotifyTheme theme;

  /// Animation that controls the slide-in and slide-out movement.
  final Animation<Offset> slideAnimation;

  /// Animation that drives the progress bar countdown visualization.
  final Animation<double> progressAnimation;

  /// Notification content including title, message, icon, and trailing text.
  final EasyInAppNotifyContent content;

  /// Callback function to execute when the notification is dismissed.
  final VoidCallback onDismiss;

  /// Callback function to execute when the notification is tapped.
  final VoidCallback? onTap;

  /// Child widget (typically the notification card) to display.

  /// Creates a new notification container.
  ///
  /// All parameters are required to ensure proper animation coordination
  /// and user interaction handling.
  const _NotifyContainer({
    required this.slideAnimation,
    required this.onDismiss,
    required this.progressAnimation,
    required this.content,
    // ignore: unused_element_parameter
    this.onTap,
    required this.theme,
  });

  @override
  Widget build(final BuildContext context) {
    // Get theming and options from Provider context
    final Widget child = _NotifyCard(
      progressAnimation: progressAnimation,
      content: content,
      theme: theme,
    );

    return Positioned(
      // Position at top of screen with configurable margins
      top: theme.margin,
      left: theme.margin,
      right: theme.margin,
      child: GestureDetector(
        onTap: onTap, // Handle tap events
        child: SafeArea(
          child: SlideTransition(
            position: slideAnimation, // Apply slide animation
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(theme.radius),
              // Conditionally wrap with Dismissible for swipe-to-dismiss
              child: EasyInAppNotify._currentOption.swipeToDismiss
                  ? Dismissible(
                      key: UniqueKey(),
                      onDismissed: (_) => onDismiss(), // Handle swipe dismissal
                      child: child,
                    )
                  : child, // No swipe interaction when disabled
            ),
          ),
        ),
      ),
    );
  }
}
