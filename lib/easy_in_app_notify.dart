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
  static void show(
    final BuildContext context, {
    required final EasyInAppNotifyContent content,
    final EasyInAppNotifyOption? option,
    final EasyInAppNotifyTheme? theme,
  }) {
    final overlay = _getOverlay(context);
    if (overlay == null) {
      _handleMissingOverlay();
      return;
    }

    // Hide any existing notification
    hide();

    // Create and show the new notification
    _currentNotification = OverlayEntry(
      builder: (final context) => _buildNotification(
        content: content,
        option: option ?? const EasyInAppNotifyOption(),
        theme: theme ?? const EasyInAppNotifyTheme(),
      ),
    );

    overlay.insert(_currentNotification!);
  }

  /// Hide the current notification immediately.
  ///
  /// This method is called automatically when:
  /// - A new notification is shown
  /// - The user dismisses the notification
  /// - The auto-dismiss timer expires
  ///
  /// You can also call it manually if needed.
  static void hide() {
    if (_currentNotification?.mounted == true) {
      _currentNotification!.remove();
      _currentNotification!.dispose();
      _currentNotification = null;
    }
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
  }) {
    // Play notification sound if supported
    _playNotificationSound();

    return _NotifyView(
      content: content,
      option: option,
      theme: theme,
      onDismissed: hide,
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
