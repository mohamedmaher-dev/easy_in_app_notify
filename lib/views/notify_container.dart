part of '../easy_in_app_notify.dart';

/// Container widget that handles positioning, animations, and user interactions.
///
/// This widget serves as the outer shell for notifications, managing their
/// position on screen, slide animations, and optional swipe-to-dismiss functionality.
/// It ensures proper positioning within safe areas and applies Material theming.
class _NotifyContainer extends StatelessWidget {
  /// Animation that controls the slide-in and slide-out movement.
  final Animation<Offset> slideAnimation;

  /// Callback function to execute when the notification is dismissed.
  final VoidCallback onDismiss;

  /// Child widget (typically the notification card) to display.
  final Widget child;

  /// Creates a new notification container.
  ///
  /// All parameters are required to ensure proper animation coordination
  /// and user interaction handling.
  const _NotifyContainer({
    required this.slideAnimation,
    required this.onDismiss,
    required this.child,
  });

  @override
  Widget build(final BuildContext context) {
    // Get theming and options from Provider context
    final theme = Provider.of<EasyInAppNotifyTheme>(context);
    final option = Provider.of<EasyInAppNotifyOption>(context);

    return Positioned(
      // Position at top of screen with configurable margins
      top: theme.margin,
      left: theme.margin,
      right: theme.margin,
      child: SafeArea(
        child: SlideTransition(
          position: slideAnimation, // Apply slide animation
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(theme.radius),
            // Conditionally wrap with Dismissible for swipe-to-dismiss
            child: option.swipeToDismiss
                ? Dismissible(
                    key: UniqueKey(),
                    onDismissed: (_) => onDismiss(), // Handle swipe dismissal
                    child: child,
                  )
                : child, // No swipe interaction when disabled
          ),
        ),
      ),
    );
  }
}
