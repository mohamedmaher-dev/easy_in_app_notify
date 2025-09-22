part of '../easy_in_app_notify.dart';

/// Root widget for displaying an in-app notification overlay.
///
/// This StatefulWidget serves as the main container for a notification,
/// managing its lifecycle, animations, and state. It coordinates between
/// the content, theming, options, and animation systems. Features a
/// animated blur background that fades in and out smoothly.
class EasyInAppView extends StatefulWidget {
  final EasyInAppNotifyContent content;

  /// Visual theming configuration for colors, spacing, and appearance.
  final EasyInAppNotifyTheme theme;

  /// Creates a new notification view widget.
  final VoidCallback? onTap;

  /// All parameters are required as they define the complete notification
  /// experience including content, behavior, appearance, and lifecycle.
  const EasyInAppView({
    super.key,
    required this.content,
    this.theme = const EasyInAppNotifyTheme(),
    this.onTap,
  });

  @override
  State<EasyInAppView> createState() => _NotifyViewtate();
}

/// State class for the notification view widget.
///
/// Manages the animation lifecycle and provides ticker support for smooth
/// animations. Uses Provider pattern to distribute configuration data
/// to child widgets efficiently.
class _NotifyViewtate extends State<EasyInAppView>
    with TickerProviderStateMixin {
  /// Animation manager that handles all timing and animation coordination.
  late final _AnimManger _animationManager;

  @override
  void initState() {
    super.initState();
    // Initialize animation manager with configuration from widget properties
    _animationManager = _AnimManger(
      vsync: this, // Provides ticker for animations
      duration:
          EasyInAppNotify._currentOption.duration, // Auto-dismiss duration
      onDismiss: () => EasyInAppNotify.hide(),
    );

    // Register the animation manager with the main class so dismiss() can access it
    EasyInAppNotify._setAnimationManager(_animationManager);

    // Set the static dismiss callback to the animation manager's dismiss method
    // This allows EasyInAppNotify.dismiss() to trigger animations
    EasyInAppNotify._setDismissCallback(_animationManager.dismiss);
  }

  @override
  void dispose() {
    // Clean up animation resources to prevent memory leaks
    _animationManager.dispose();
    // Clear the animation manager reference from the main class
    EasyInAppNotify._setAnimationManager(null);
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Stack(
    children: [
      if (widget.theme.blurBackground)
        Positioned.fill(
          child: FadeTransition(
            opacity: _animationManager.fadeAnimation, // Animated opacity
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: widget.theme.blurColor.withAlpha(
                  (0.1 * 255).toInt(),
                ), // dim background
              ),
            ),
          ),
        ),
      _NotifyContainer(
        theme: widget.theme,
        slideAnimation: _animationManager.slideAnimation,
        onDismiss: _animationManager.dismiss,
        progressAnimation: _animationManager.progressAnimation,
        content: widget.content,
      ),
    ],
  );
}
