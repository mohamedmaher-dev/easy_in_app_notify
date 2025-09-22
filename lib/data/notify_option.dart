part of '../easy_in_app_notify.dart';

/// Configuration options for controlling notification behavior and interactions.
///
/// This class defines how the notification should behave, including timing,
/// user interactions, and visual feedback elements.
class EasyInAppNotifyOption {
  /// Duration in seconds that the notification should remain visible.
  ///
  /// After this time elapses, the notification will automatically dismiss itself.
  /// Default is 5 seconds. Must be greater than 0. Set to a higher value for
  /// notifications that require more reading time or contain important information.
  final int duration;

  /// Whether to show a progress bar indicating time remaining.
  ///
  /// When enabled, displays a linear progress indicator at the bottom of the
  /// notification that visually shows how much time is left before auto-dismiss.
  /// Default is true.
  final bool showProgressBar;

  /// Whether users can swipe the notification to dismiss it manually.
  ///
  /// When enabled, users can swipe the notification horizontally to dismiss it
  /// before the auto-dismiss timer expires. Default is true.
  final bool swipeToDismiss;

  /// Creates a new notification options configuration.
  ///
  /// All parameters are optional and will use sensible defaults if not provided.
  /// The defaults provide a good user experience for most notification types.
  ///
  /// [duration] must be greater than 0 to ensure notifications auto-dismiss.
  const EasyInAppNotifyOption({
    this.duration = 5,
    this.showProgressBar = true,
    this.swipeToDismiss = true,
  }) : assert(duration > 0, 'Duration must be greater than 0 seconds');
}
