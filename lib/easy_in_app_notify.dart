library;

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:easy_in_app_notify/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// View Components
part 'views/easy_in_app_notify_view.dart';
part 'views/notify_card.dart';
part 'views/notify_container.dart';
part 'views/notify_content.dart';
part 'views/notify_icon.dart';
part 'views/notify_progress.dart';

// Controllers
part 'controllers/anim_manger.dart';

// Data Models
part 'data/notify_content.dart';
part 'data/notify_option.dart';
part 'data/notify_theme.dart';

/// Main notification manager for displaying in-app notifications.
///
/// This class provides a centralized way to show and manage notifications
/// in your Flutter application. All notifications are displayed as overlays
/// and support automatic dismissal, manual dismissal, and animations.
///
/// Example:
/// ```dart
/// EasyInAppNotify.show(
///   context,
///   view: Card(child: Text('Hello!')),
///   option: EasyInAppNotifyOption(duration: 3),
/// );
/// ```
class EasyInAppNotify {
  // Private constructor to prevent instantiation
  EasyInAppNotify._();

  // ============================================================================
  // PRIVATE STATE VARIABLES
  // ============================================================================

  /// Current notification options (duration, progress bar, etc.)
  static late EasyInAppNotifyOption _currentOption;

  /// Callback executed when notification is dismissed
  static late VoidCallback _onDismissed;

  /// Animation manager for animated notifications (null for custom views)
  static _AnimManger? _animationManager;

  /// Timer for automatic dismissal based on duration setting
  static Timer? _autoDismissTimer;

  /// Current notification overlay entry
  static OverlayEntry? _currentNotification;

  // ============================================================================
  // INTERNAL CONFIGURATION METHODS
  // ============================================================================

  /// Sets the dismiss callback for the current notification.
  /// This is called internally by notification views to register their dismiss logic.
  static void _setDismissCallback(final VoidCallback? callback) =>
      _onDismissed = callback ?? () {};

  /// Registers the animation manager for animated notifications.
  /// This allows the main dismiss() method to trigger animations when available.
  static void _setAnimationManager(final _AnimManger? manager) =>
      _animationManager = manager;

  // ============================================================================
  // AUTO-DISMISS TIMER MANAGEMENT
  // ============================================================================

  /// Starts the auto-dismiss timer based on the current option settings.
  ///
  /// This is centralized so any notification type can use automatic dismiss.
  /// The timer duration is guaranteed to be > 0 by the EasyInAppNotifyOption assertion.
  static void _startAutoDismissTimer() {
    // Cancel any existing timer first to prevent conflicts
    _cancelAutoDismissTimer();

    // Start new timer - duration is guaranteed to be > 0 by assertion
    final duration = _currentOption.duration;
    _autoDismissTimer = Timer(Duration(seconds: duration), () {
      dismiss(); // Use dismiss() instead of hide() to trigger animations if available
    });
  }

  /// Cancels the auto-dismiss timer if it's running.
  ///
  /// This is called when manually hiding/dismissing notifications
  /// to prevent the timer from firing after the notification is gone.
  static void _cancelAutoDismissTimer() {
    _autoDismissTimer?.cancel();
    _autoDismissTimer = null;
  }

  // ============================================================================
  // PUBLIC API METHODS
  // ============================================================================

  /// Displays a notification overlay with the specified view and options.
  ///
  /// This is the main method for showing notifications. It accepts any widget
  /// as the [view] parameter, making it flexible for both standard notifications
  /// and completely custom designs.
  ///
  /// Parameters:
  /// - [context]: BuildContext to access the overlay
  /// - [view]: Widget to display as the notification content
  /// - [option]: Configuration for behavior (duration, progress bar, etc.)
  /// - [onDismissed]: Callback executed when notification is dismissed
  ///
  /// Example:
  /// ```dart
  /// EasyInAppNotify.show(
  ///   context,
  ///   view: Card(child: Text('Hello!')),
  ///   option: EasyInAppNotifyOption(duration: 3),
  ///   onDismissed: () => print('Dismissed'),
  /// );
  /// ```
  static void show(
    final BuildContext context, {
    required final Widget view,
    final EasyInAppNotifyOption option = const EasyInAppNotifyOption(),
    final VoidCallback? onDismissed,
  }) {
    // Store configuration for use by other components
    _currentOption = option;
    _onDismissed = onDismissed ?? () {};

    // Get overlay or handle error
    final overlay = _getOverlay(context);
    if (overlay == null) {
      _handleMissingOverlay();
      return;
    }

    // Hide any existing notification first
    hide();

    // Create and insert new notification
    _currentNotification = OverlayEntry(
      builder: (final context) => _buildNotification(view: view),
    );
    overlay.insert(_currentNotification!);

    // Start the centralized auto-dismiss timer
    _startAutoDismissTimer();
  }

  /// Immediately hides the current notification without animations.
  ///
  /// This method directly removes the notification from the overlay and
  /// executes the onDismissed callback. For animated dismissal, use [dismiss] instead.
  static void hide() {
    if (_currentNotification?.mounted == true) {
      _cancelAutoDismissTimer();
      _currentNotification!.remove();
      _currentNotification!.dispose();
      _currentNotification = null;
      _onDismissed.call();
    }
  }

  /// Programmatically dismisses the current notification with animations.
  ///
  /// This method attempts to trigger dismiss animations if available, providing
  /// a smooth user experience. If no animation manager is available (e.g., for
  /// custom views), it falls back to immediate [hide].
  ///
  /// This is the preferred method for manual dismissal as it provides the best
  /// visual experience for users.
  static void dismiss() {
    if (_animationManager != null) {
      _animationManager!.dismiss(); // Animated dismissal
    } else {
      hide(); // Immediate dismissal for custom views
    }
  }

  /// Returns true if a notification is currently being displayed.
  ///
  /// This can be useful for preventing multiple notifications from showing
  /// simultaneously or for conditional logic based on notification state.
  static bool get isShowing => _currentNotification?.mounted == true;

  // ============================================================================
  // PRIVATE HELPER METHODS
  // ============================================================================

  /// Safely retrieves the OverlayState from the given context.
  ///
  /// Returns null if no overlay is found, which should be handled by the caller.
  /// This can happen if the context doesn't have access to a MaterialApp/WidgetsApp.
  static OverlayState? _getOverlay(final BuildContext context) {
    try {
      return Overlay.of(context);
    } on Exception {
      return null;
    }
  }

  /// Handles the case where no overlay is found in the context.
  ///
  /// This provides a helpful error message to developers about how to fix
  /// the issue. The assertion will only trigger in debug mode.
  static void _handleMissingOverlay() {
    assert(false, '''
🚨 EasyInAppNotify: Overlay not found!

Make sure you are calling EasyInAppNotify.show() from a context that has access to an Overlay.
This typically means calling it from within a Widget that is part of your MaterialApp/WidgetsApp widget tree.
''');
  }

  /// Builds the notification widget and plays the notification sound.
  ///
  /// This method serves as a factory for creating the final notification widget.
  /// Currently, it passes through the view directly, but could be extended
  /// in the future to add wrapper functionality.
  static Widget _buildNotification({required final Widget view}) {
    _playNotificationSound();
    return view;
  }

  /// Plays an appropriate notification sound based on the current platform.
  ///
  /// Uses different system sounds for different platforms to provide
  /// a native feel. Gracefully handles platforms that don't support sounds.
  static void _playNotificationSound() {
    try {
      if (kIsWeb || Platform.isIOS || Platform.isAndroid) {
        SystemSound.play(SystemSoundType.click);
      } else {
        SystemSound.play(SystemSoundType.alert);
      }
    } on Exception catch (e) {
      debugPrint('EasyInAppNotify: Could not play notification sound: $e');
    }
  }
}
