part of '../easy_in_app_notify.dart';

/// Configuration options for controlling notification behavior and timing.
///
/// This class defines how the notification should behave in terms of timing
/// and auto-dismiss functionality. Visual elements like progress bars and
/// gesture handling are now part of EasyInAppNotifyTheme.
class EasyInAppNotifyOption {
  /// Duration in seconds that the notification should remain visible.
  ///
  /// After this time elapses, the notification will automatically dismiss itself.
  /// Default is 5 seconds. Must be greater than 0. Set to a higher value for
  /// notifications that require more reading time or contain important information.
  final int duration;

  /// Creates a new notification options configuration.
  ///
  /// Focuses purely on timing and auto-dismiss behavior. Visual elements like
  /// progress bars and gesture handling are configured in EasyInAppNotifyTheme.
  ///
  /// [duration] must be greater than 0 to ensure notifications auto-dismiss.
  const EasyInAppNotifyOption({this.duration = 5})
    : assert(duration > 0, 'Duration must be greater than 0 seconds');
}
