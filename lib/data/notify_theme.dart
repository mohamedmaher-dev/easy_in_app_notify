part of '../easy_in_app_notify.dart';

/// Visual styling configuration for notification appearance.
///
/// This class controls all aspects of how the notification looks, including
/// colors, spacing, dimensions, and visual effects.
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

  /// Creates a new notification theme configuration.
  ///
  /// All parameters are optional and provide sensible defaults for a modern,
  /// clean notification appearance that works well with Material Design.
  const EasyInAppNotifyTheme({
    this.color,
    this.margin = 5,
    this.padding = 10,
    this.radius = 10,
    this.elevation = 5,
    this.iconSize = 20,
  });
}
