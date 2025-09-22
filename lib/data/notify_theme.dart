part of '../easy_in_app_notify.dart';

/// Visual styling configuration for notification appearance.
///
/// This class provides comprehensive theming options for customizing the visual
/// presentation of notifications. It supports both standard and custom widget
/// notifications with consistent styling capabilities.
///
/// Enhanced in v2.3.0 with improved documentation and clarity for developers.
///
/// Example:
/// ```dart
/// EasyInAppNotifyTheme(
///   color: Colors.blue,
///   margin: 16.0,
///   radius: 12.0,
///   blurBackground: true,
///   elevation: 8.0,
/// )
/// ```
class EasyInAppNotifyTheme {
  /// Primary accent color for the notification theme.
  ///
  /// Used for the icon background, progress bar, and other accent elements.
  /// If null, defaults to the app's primary theme color.
  final Color? color;

  /// Margin around the notification from screen edges.
  ///
  /// Controls the spacing between the notification and the edges of the screen.
  /// Default is 5 logical pixels.
  final double margin;

  /// Internal padding within notification components.
  ///
  /// Applied to icon containers and other internal elements for consistent spacing.
  /// Default is 10 logical pixels.
  final double padding;

  /// Border radius for rounded corners on the notification card.
  ///
  /// Creates smooth, rounded corners for a modern appearance.
  /// Default is 10 logical pixels.
  final double radius;

  /// Shadow elevation for the notification card.
  ///
  /// Creates depth and visual separation from the background content.
  /// Higher values create more pronounced shadows.
  /// Default is 5 logical pixels.
  final double elevation;

  /// Size of the notification icon.
  ///
  /// Controls the dimensions of the icon displayed within the notification.
  /// Default is 20 logical pixels.
  final double iconSize;

  /// Whether to enable animated background blur effect.
  ///
  /// When enabled, creates a beautiful iOS-style backdrop blur effect that
  /// fades in smoothly with the notification. This enhances visual focus
  /// and creates depth in the interface.
  ///
  /// Default is true for modern appearance.
  final bool blurBackground;

  /// Color overlay for the blur effect background.
  ///
  /// Applied as a semi-transparent overlay on top of the blurred background
  /// to create the desired visual effect. Typically a dark color with low opacity.
  ///
  /// Default is Colors.black with automatic opacity applied.
  final Color blurColor;

  /// Whether to show a progress bar indicating time remaining.
  ///
  /// When enabled, displays a linear progress indicator at the bottom of the
  /// notification that visually shows how much time is left before auto-dismiss.
  /// This is a visual element, making it part of the theming system.
  ///
  /// Default is true.
  final bool showProgressBar;

  /// Whether users can swipe the notification to dismiss it manually.
  ///
  /// When enabled, users can swipe the notification horizontally to dismiss it
  /// before the auto-dismiss timer expires. This affects the visual interaction
  /// behavior and gesture handling.
  ///
  /// Default is true.
  final bool swipeToDismiss;

  /// Creates a new notification theme configuration.
  ///
  /// All parameters are optional and provide sensible defaults for a modern,
  /// clean notification appearance that works well with Material Design principles.
  ///
  /// The defaults are optimized for v2.3.0's enhanced visual system and
  /// universal widget support.
  const EasyInAppNotifyTheme({
    this.color,
    this.margin = 5,
    this.padding = 10,
    this.radius = 10,
    this.elevation = 5,
    this.iconSize = 20,
    this.blurBackground = true,
    this.blurColor = Colors.black,
    this.showProgressBar = true,
    this.swipeToDismiss = true,
  });
}
