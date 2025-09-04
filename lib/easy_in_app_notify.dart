/// # Easy In-App Notify 📱✨
///
/// A beautiful, lightweight Flutter package for displaying notifications as
/// stunning in-app overlays. Perfect for showing notifications when your app
/// is in the foreground!
///
/// ## ⚡ Super Simple Setup
/// ```dart
/// // Show notifications ANYWHERE in your app (with context)
/// EasyInAppNotify.show(
///   context,
///   content: EasyInAppNotifyContent(
///     title: "Success!",
///     message: "Your operation completed successfully.",
///   ),
/// );
/// ```
///
/// ## ✨ Features
/// - 🎯 Beautiful overlay notifications that don't block your UI
/// - ⚡ Zero configuration - just use with any BuildContext
/// - 🎨 Fully customizable themes, colors, and animations
/// - 📱 Works on Android, iOS, and all Flutter platforms
/// - 🔊 Platform-optimized notification sounds (alert on desktop, click on mobile/web)
/// - 👆 Swipe to dismiss functionality
/// - ⏰ Auto-dismiss with visual progress indicator
/// - 🌙 Respects system themes and safe areas
/// - 🚀 High performance with smooth animations
///
/// ## 🎯 Simple Usage
/// Just call `EasyInAppNotify.show(context, ...)` from anywhere in your app!
///
/// ## 🏗️ Using Without Direct Context Access
///
/// When you need to show notifications from classes that don't have access to BuildContext
/// (like service classes, static methods, or background tasks), here are several patterns:
///
/// ### 1. **Pass Context as Parameter**
/// ```dart
/// class ApiService {
///   static void handleError(BuildContext context, String error) {
///     EasyInAppNotify.show(
///       context,
///       content: EasyInAppNotifyContent(
///         title: "API Error",
///         message: error,
///       ),
///     );
///   }
/// }
///
/// // Usage
/// ApiService.handleError(context, "Network failed");
/// ```
///
/// ### 2. **Callback Pattern**
/// ```dart
/// class DataService {
///   static Function(String)? onError;
///
///   static void fetchData() {
///     // ... fetch logic
///     if (error != null) {
///       onError?.call("Failed to fetch data");
///     }
///   }
/// }
///
/// // Setup in your widget
/// DataService.onError = (message) {
///   EasyInAppNotify.show(
///     context,
///     content: EasyInAppNotifyContent(title: "Error", message: message),
///   );
/// };
/// ```
///
/// ### 3. **Navigator Key Pattern**
/// ```dart
/// class AppNavigator {
///   static final GlobalKey<NavigatorState> navigatorKey =
///       GlobalKey<NavigatorState>();
///
///   static void showNotification(String title, String message) {
///     final context = navigatorKey.currentContext;
///     if (context != null) {
///       EasyInAppNotify.show(
///         context,
///         content: EasyInAppNotifyContent(title: title, message: message),
///       );
///     }
///   }
/// }
///
/// // In your MaterialApp
/// MaterialApp(
///   navigatorKey: AppNavigator.navigatorKey,
///   home: MyHomePage(),
/// )
///
/// // Usage from anywhere
/// AppNavigator.showNotification("Success", "Data saved!");
/// ```
///
/// ### 4. **Service Locator Pattern**
/// ```dart
/// class NotificationService {
///   BuildContext? _context;
///
///   void setContext(BuildContext context) => _context = context;
///
///   void showSuccess(String message) {
///     if (_context != null) {
///       EasyInAppNotify.show(
///         _context!,
///         content: EasyInAppNotifyContent(title: "Success", message: message),
///       );
///     }
///   }
/// }
///
/// // Register and use
/// final notificationService = NotificationService();
/// notificationService.setContext(context);
/// notificationService.showSuccess("Operation completed!");
/// ```
///
/// ### 5. **Firebase Cloud Messaging (FCM) Integration**
/// ```dart
/// class FCMService {
///   static final GlobalKey<NavigatorState> navigatorKey =
///       GlobalKey<NavigatorState>();
///
///   static void initialize() {
///     // Handle background messages
///     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
///
///     // Handle foreground messages
///     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
///       _showFCMNotification(message);
///     });
///   }
///
///   static void _showFCMNotification(RemoteMessage message) {
///     final context = navigatorKey.currentContext;
///     if (context != null && message.notification != null) {
///       EasyInAppNotify.show(
///         context,
///         content: EasyInAppNotifyContent(
///           title: message.notification!.title ?? 'Notification',
///           message: message.notification!.body ?? '',
///           icon: Icons.notifications,
///         ),
///         theme: EasyInAppNotifyTheme(color: Colors.blue),
///       );
///     }
///   }
/// }
///
/// // Background message handler (top-level function)
/// @pragma('vm:entry-point')
/// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
///   await Firebase.initializeApp();
///   // Handle background notification here
///   // Note: You cannot show in-app notifications in background
///   // Consider using local notifications instead
/// }
///
/// // In your MaterialApp
/// MaterialApp(
///   navigatorKey: FCMService.navigatorKey,
///   home: MyHomePage(),
/// )
/// ```
library;

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:easy_in_app_notify/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Core notification system components
part 'views/easy_in_app_notify_view.dart';
part 'views/notify_card.dart';
part 'views/notify_container.dart';
part 'views/notify_content.dart';
part 'views/notify_icon.dart';
part 'views/notify_progress.dart';
part 'controllers/anim_manger.dart';
part 'data/notify_content.dart';
part 'data/notify_option.dart';
part 'data/notify_theme.dart';

/// # EasyInAppNotify
///
/// The main notification controller for displaying beautiful in-app notifications.
///
/// ## 🚀 Quick Start
/// ```dart
/// // Show notifications anywhere in your app
/// EasyInAppNotify.show(
///   context,
///   content: EasyInAppNotifyContent(
///     title: "Hello World!",
///     message: "Your first notification is ready!",
///   ),
/// );
/// ```
///
/// ## 🎨 Advanced Usage
/// ```dart
/// EasyInAppNotify.show(
///   context,
///   content: EasyInAppNotifyContent(
///     title: "Download Complete",
///     message: "Your file has been successfully downloaded.",
///     icon: Icons.download_done,
///     trailingText: "Just now",
///   ),
///   option: EasyInAppNotifyOption(
///     duration: 5,
///     showProgressBar: true,
///     swipeToDismiss: true,
///   ),
///   theme: EasyInAppNotifyTheme(
///     color: Colors.green,
///     elevation: 8,
///     borderRadius: 16,
///   ),
/// );
/// ```
class EasyInAppNotify {
  EasyInAppNotify._(); // Private constructor to prevent instantiation

  // ==========================================
  // Core State Management
  // ==========================================

  /// The current notification overlay entry (null when no notification is shown)
  static OverlayEntry? _currentNotification;

  /// The current notification's animation dismiss callback (null when no notification is shown)
  /// This triggers the smooth animations before hiding the notification
  static VoidCallback? _currentDismissCallback;

  /// Internal method to set the animation dismiss callback
  /// Called by _NotifyView to connect the animation manager's dismiss method
  static void _setDismissCallback(final VoidCallback? callback) {
    _currentDismissCallback = callback;
  }

  // ==========================================
  // Public API
  // ==========================================

  /// Display a beautiful in-app notification.
  ///
  /// Shows a notification overlay with the specified content, styling, and behavior.
  /// Automatically dismisses any existing notification before showing the new one.
  ///
  /// ## Parameters
  /// - **context**: BuildContext to access the overlay
  /// - **content**: The notification content (title, message, icon, etc.)
  /// - **option**: Optional behavior settings (duration, progress bar, etc.)
  /// - **theme**: Optional visual styling (colors, elevation, etc.)
  /// - **onTap**: Optional callback executed when notification is tapped
  /// - **onDismissed**: Optional callback executed when notification is dismissed
  ///
  /// ## Examples
  ///
  /// ### Simple Notification
  /// ```dart
  /// EasyInAppNotify.show(
  ///   context,
  ///   content: EasyInAppNotifyContent(
  ///     title: "Success!",
  ///     message: "Operation completed successfully.",
  ///   ),
  /// );
  /// ```
  ///
  /// ### Rich Notification
  /// ```dart
  /// EasyInAppNotify.show(
  ///   context,
  ///   content: EasyInAppNotifyContent(
  ///     title: "New Message",
  ///     message: "You have received a new message from John.",
  ///     icon: Icons.message,
  ///     trailingText: "2m ago",
  ///   ),
  ///   option: EasyInAppNotifyOption(
  ///     duration: 4,
  ///     showProgressBar: true,
  ///   ),
  ///   theme: EasyInAppNotifyTheme(
  ///     color: Colors.blue,
  ///     elevation: 6,
  ///   ),
  /// );
  /// ```
  ///
  /// ### With Callbacks
  /// ```dart
  /// EasyInAppNotify.show(
  ///   context,
  ///   content: EasyInAppNotifyContent(
  ///     title: "New Message",
  ///     message: "Tap to view conversation",
  ///     icon: Icons.message,
  ///   ),
  ///   onTap: () {
  ///     Navigator.pushNamed(context, '/chat');
  ///     print('Notification tapped!');
  ///   },
  ///   onDismissed: () {
  ///     print('Notification was dismissed');
  ///     // Log analytics, update state, etc.
  ///   },
  /// );
  /// ```
  static void show(
    final BuildContext context, {
    required final EasyInAppNotifyContent content,
    final EasyInAppNotifyOption? option,
    final EasyInAppNotifyTheme? theme,
    final VoidCallback? onTap,
    final VoidCallback? onDismissed,
  }) {
    final overlay = _getOverlay(context);
    if (overlay == null) {
      _handleMissingOverlay();
      return;
    }

    // Hide any existing notification
    hide();

    // Note: _currentDismissCallback will be set by the _NotifyView
    // to the animation manager's dismiss method

    // Create and show the new notification
    _currentNotification = OverlayEntry(
      builder: (final context) => _buildNotification(
        content: content,
        option: option ?? const EasyInAppNotifyOption(),
        theme: theme ?? const EasyInAppNotifyTheme(),
        onDismissed: onDismissed,
        onTap: onTap,
      ),
    );

    overlay.insert(_currentNotification!);
  }

  /// Display a completely custom widget as a notification.
  ///
  /// Shows any custom widget as an overlay notification. Unlike regular notifications,
  /// custom notifications do NOT auto-dismiss and must be dismissed manually using
  /// `EasyInAppNotify.dismiss()` or `EasyInAppNotify.hide()`.
  ///
  /// ## Parameters
  /// - **context**: BuildContext to access the overlay
  /// - **child**: Custom widget to display as the notification
  ///
  /// ## Important Notes
  /// - Custom notifications do **not** auto-dismiss
  /// - No built-in timer, progress bar, or swipe-to-dismiss functionality
  /// - Must be dismissed manually using `EasyInAppNotify.dismiss()`
  /// - Full control over appearance and behavior
  ///
  /// ## Examples
  ///
  /// ### Basic Custom Notification
  /// ```dart
  /// // Show custom notification
  /// EasyInAppNotify.showCustom(
  ///   context,
  ///   Container(
  ///     margin: EdgeInsets.all(16),
  ///     padding: EdgeInsets.all(20),
  ///     decoration: BoxDecoration(
  ///       color: Colors.purple,
  ///       borderRadius: BorderRadius.circular(12),
  ///     ),
  ///     child: Text(
  ///       'Custom notification that stays until dismissed',
  ///       style: TextStyle(color: Colors.white),
  ///     ),
  ///   ),
  /// );
  ///
  /// // Later, dismiss it programmatically
  /// EasyInAppNotify.dismiss(); // or EasyInAppNotify.hide()
  /// ```
  ///
  /// ### Interactive Custom Notification
  /// ```dart
  /// EasyInAppNotify.showCustom(
  ///   context,
  ///   Container(
  ///     margin: EdgeInsets.all(16),
  ///     padding: EdgeInsets.all(16),
  ///     decoration: BoxDecoration(
  ///       color: Colors.white,
  ///       borderRadius: BorderRadius.circular(12),
  ///       boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
  ///     ),
  ///     child: Column(
  ///       mainAxisSize: MainAxisSize.min,
  ///       children: [
  ///         Text('Do you want to continue?'),
  ///         SizedBox(height: 12),
  ///         Row(
  ///           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  ///           children: [
  ///             ElevatedButton(
  ///               onPressed: () {
  ///                 EasyInAppNotify.dismiss(); // Dismiss on button press
  ///                 // Handle "Yes" action
  ///               },
  ///               child: Text('Yes'),
  ///             ),
  ///             ElevatedButton(
  ///               onPressed: () {
  ///                 EasyInAppNotify.dismiss(); // Dismiss on button press
  ///                 // Handle "No" action
  ///               },
  ///               child: Text('No'),
  ///             ),
  ///           ],
  ///         ),
  ///       ],
  ///     ),
  ///   ),
  /// );
  /// ```
  static void showCustom(final BuildContext context, final Widget child) {
    final overlay = _getOverlay(context);
    if (overlay == null) {
      _handleMissingOverlay();
      return;
    }

    // Hide any existing notification
    hide();

    // Create and show the new notification
    _currentNotification = OverlayEntry(builder: (final context) => child);

    // Set up dismiss callback to just hide the notification
    _setDismissCallback(hide);

    overlay.insert(_currentNotification!);
  }

  /// Dismiss the current notification and trigger the dismiss callback.
  ///
  /// This method triggers the `onDismissed` callback (if provided) and then
  /// removes the notification from the screen. Use this when you want to
  /// programmatically dismiss a notification and ensure callbacks are executed.
  ///
  /// ## Example
  /// ```dart
  /// // Show notification with dismiss callback
  /// EasyInAppNotify.show(
  ///   context,
  ///   content: EasyInAppNotifyContent(title: "Info", message: "Message"),
  ///   onDismissed: () => print("Notification was dismissed"),
  /// );
  ///
  /// // Later, programmatically dismiss it
  /// EasyInAppNotify.dismiss(); // This will call the onDismissed callback
  /// ```
  static void dismiss() {
    if (isShowing) {
      // Trigger the animation manager's dismiss method which will handle animations
      // and then call the user's callback + hide() after animations complete
      _currentDismissCallback?.call();
    }
  }

  /// Hide the current notification immediately.
  ///
  /// This method removes the notification without triggering the dismiss callback.
  /// It's called automatically when:
  /// - A new notification is shown
  /// - The user dismisses the notification (after callback is triggered)
  /// - The auto-dismiss timer expires (after callback is triggered)
  ///
  /// For programmatic dismissal that triggers callbacks, use `dismiss()` instead.
  static void hide() {
    if (_currentNotification?.mounted == true) {
      _currentNotification!.remove();
      _currentNotification!.dispose();
      _currentNotification = null;
    }
    // Clear the dismiss callback
    _currentDismissCallback = null;
  }

  /// Check if a notification is currently being displayed.
  ///
  /// Returns `true` if a notification is visible, `false` otherwise.
  ///
  /// ## Example
  /// ```dart
  /// if (!EasyInAppNotify.isShowing) {
  ///   EasyInAppNotify.show(content: myContent);
  /// }
  /// ```
  static bool get isShowing => _currentNotification?.mounted == true;

  // ==========================================
  // Internal Implementation
  // ==========================================

  /// Get the overlay from the context
  static OverlayState? _getOverlay(final BuildContext context) {
    try {
      // Get overlay from context
      return Overlay.of(context);
    } on Exception {
      return null;
    }
  }

  /// Handle the case where overlay is not available
  static void _handleMissingOverlay() {
    assert(false, '''
🚨 EasyInAppNotify: Overlay not found!

Make sure you are calling EasyInAppNotify.show() from a context that has access to an Overlay.
This typically means calling it from within a Widget that is part of your MaterialApp/WidgetsApp widget tree.
''');
  }

  /// Build the notification widget with all necessary functionality
  static Widget _buildNotification({
    required final EasyInAppNotifyContent content,
    required final EasyInAppNotifyOption option,
    required final EasyInAppNotifyTheme theme,
    final VoidCallback? onDismissed,
    final VoidCallback? onTap,
  }) {
    // Play notification sound if supported
    _playNotificationSound();

    return _NotifyView(
      content: content,
      option: option,
      theme: theme,
      onDismissed: () {
        // Only call user's callback - _NotifyView will handle hide() after animations
        onDismissed?.call();
      },
      onTap: onTap,
    );
  }

  /// Play notification sound using Flutter's built-in SystemSound
  /// Uses platform-appropriate sound types for best compatibility
  static void _playNotificationSound() {
    try {
      if (kIsWeb || Platform.isIOS || Platform.isAndroid) {
        // Web, Mobile: Use click sound
        // Note: Web may not play sound but won't crash (yields no behavior per Flutter docs)
        SystemSound.play(SystemSoundType.click);
      } else {
        // Desktop (macOS, Windows, Linux): Use alert sound
        // Only desktop platforms support proper system alert sounds
        SystemSound.play(SystemSoundType.alert);
      }
    } on Exception catch (e) {
      // Silently ignore sound errors to prevent crashes
      // This can happen when:
      // - Device is in silent mode
      // - System sounds are disabled
      // - Platform doesn't support the sound type
      debugPrint('EasyInAppNotify: Could not play notification sound: $e');
    }
  }
}
