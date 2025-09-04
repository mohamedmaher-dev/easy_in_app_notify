part of '../easy_in_app_notify.dart';

/// Root widget for displaying an in-app notification overlay.
///
/// This StatefulWidget serves as the main container for a notification,
/// managing its lifecycle, animations, and state. It coordinates between
/// the content, theming, options, and animation systems. Features a
/// animated blur background that fades in and out smoothly.
class _NotifyView extends StatefulWidget {
  /// Notification content including title, message, icon, and trailing text.
  final EasyInAppNotifyContent content;

  /// Configuration options for behavior like duration and interactions.
  final EasyInAppNotifyOption option;

  /// Visual theming configuration for colors, spacing, and appearance.
  final EasyInAppNotifyTheme theme;

  /// Callback function executed when the notification is dismissed.
  ///
  /// This is called after the exit animation completes and is used to
  /// clean up the overlay entry from the widget tree.
  final VoidCallback onDismissed;

  /// Callback function executed when the notification is tapped.
  ///
  /// This is called when the notification is tapped and is used to
  /// handle the tap event.
  final VoidCallback? onTap;

  /// Creates a new notification view widget.
  ///
  /// All parameters are required as they define the complete notification
  /// experience including content, behavior, appearance, and lifecycle.
  const _NotifyView({
    required this.content,
    required this.onDismissed,
    required this.option,
    required this.theme,
    required this.onTap,
  });

  @override
  State<_NotifyView> createState() => _NotifyViewtate();
}

/// State class for the notification view widget.
///
/// Manages the animation lifecycle and provides ticker support for smooth
/// animations. Uses Provider pattern to distribute configuration data
/// to child widgets efficiently.
class _NotifyViewtate extends State<_NotifyView> with TickerProviderStateMixin {
  /// Animation manager that handles all timing and animation coordination.
  late final _AnimManger _animationManager;

  @override
  void initState() {
    super.initState();
    // Initialize animation manager with configuration from widget properties
    _animationManager = _AnimManger(
      vsync: this, // Provides ticker for animations
      duration: widget.option.duration, // Auto-dismiss duration
      onDismiss: () {
        // Call user's callback first
        widget.onDismissed();
        // Then call static hide to clean up the overlay
        EasyInAppNotify.hide();
      },
    );

    // Set the static dismiss callback to the animation manager's dismiss method
    // This allows EasyInAppNotify.dismiss() to trigger animations
    EasyInAppNotify._setDismissCallback(_animationManager.dismiss);
  }

  @override
  void dispose() {
    // Clean up animation resources to prevent memory leaks
    _animationManager.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => MultiProvider(
    // Provide configuration objects to child widgets via Provider pattern
    providers: [
      Provider.value(value: widget.content), // Notification content data
      Provider.value(value: widget.theme), // Visual styling configuration
      Provider.value(value: widget.option), // Behavior configuration
    ],
    child: Stack(
      children: [
        Positioned.fill(
          child: FadeTransition(
            opacity: _animationManager.fadeAnimation, // Animated opacity
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: widget.theme.blurColor.withAlpha(
                  (0.3 * 255).toInt(),
                ), // dim background
              ),
            ),
          ),
        ),
        _NotifyContainer(
          slideAnimation:
              _animationManager.slideAnimation, // Position animation
          onDismiss: _animationManager.dismiss, // Manual dismiss handler
          onTap: widget.onTap, // Pass tap callback to container
          child: _NotifyCard(
            progressAnimation:
                _animationManager.progressAnimation, // Progress animation
          ),
        ),
      ],
    ),
  );
}
