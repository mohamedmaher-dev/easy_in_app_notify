/// Easy In-App Notify - A Flutter package for displaying Firebase Cloud Messaging (FCM) notifications as beautiful in-app overlays.
///
/// This library provides a simple, customizable solution for showing Firebase
/// notifications as overlay notifications within Flutter applications when the
/// app is in the foreground. Perfect for FCM integration. Features include:
/// - Firebase Cloud Messaging integration
/// - Smooth slide-in animations
/// - Auto-dismiss with visual countdown
/// - Swipe-to-dismiss functionality
/// - Customizable theming and styling
/// - Sound notification support
/// - Material Design compliance
///
/// The package is designed to be lightweight, easy to integrate with Firebase,
/// and follows Flutter best practices for state management and widget composition.
library;

import 'dart:async';

import 'package:easy_in_app_notify/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:provider/provider.dart';

// Part files containing the notification system components
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

/// Global controller for displaying in-app notifications as overlays.
///
/// This singleton class manages the lifecycle of notification overlays within
/// a Flutter application. It ensures only one notification is visible at a time
/// and handles proper cleanup of resources.
///
/// Usage:
/// ```dart
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       home: MyHomePage(), // StatefulWidget AFTER MaterialApp
///     );
///   }
/// }
///
/// class MyHomePage extends StatefulWidget {
///   @override
///   _MyHomePageState createState() => _MyHomePageState();
/// }
///
/// class _MyHomePageState extends State<MyHomePage> {
///   @override
///   void initState() {
///     super.initState();
///     // Initialize AFTER MaterialApp is built
///     WidgetsBinding.instance.addPostFrameCallback((_) {
///       EasyInAppNotify.init(context);
///     });
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(/* your content */);
///   }
/// }
///
/// // Show a notification anywhere in your app
/// EasyInAppNotify.show(
///   content: EasyInAppNotifyContent(
///     title: "Success!",
///     message: "Your changes have been saved.",
///   ),
/// );
/// ```
class EasyInAppNotify {
  /// Internal context reference for overlay operations.
  ///
  /// This context must be from within the MaterialApp widget tree to ensure
  /// proper access to the overlay and theme systems.
  static late BuildContext _context;

  /// Initialize the notification service with a proper context.
  ///
  /// This method must be called once during app initialization in the
  /// `initState` method of a StatefulWidget that is AFTER MaterialApp
  /// in the widget tree (typically the home widget). This ensures proper
  /// access to the overlay system.
  ///
  /// [context] - A BuildContext from within the MaterialApp widget tree
  ///
  /// Example:
  /// ```dart
  /// class MyApp extends StatelessWidget {
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return MaterialApp(
  ///       home: MyHomePage(), // StatefulWidget that calls init
  ///     );
  ///   }
  /// }
  ///
  /// class MyHomePage extends StatefulWidget {
  ///   @override
  ///   _MyHomePageState createState() => _MyHomePageState();
  /// }
  ///
  /// class _MyHomePageState extends State<MyHomePage> {
  ///   @override
  ///   void initState() {
  ///     super.initState();
  ///     // Initialize AFTER MaterialApp is built
  ///     WidgetsBinding.instance.addPostFrameCallback((_) {
  ///       EasyInAppNotify.init(context);
  ///     });
  ///   }
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Scaffold(/* your content */);
  ///   }
  /// }
  /// ```
  static void init(final BuildContext context) => _context = context;

  /// Current overlay entry for the active notification.
  ///
  /// Null when no notification is currently displayed. Only one notification
  /// can be shown at a time to prevent UI conflicts and ensure clarity.
  static OverlayEntry? _entry;

  /// Display an in-app notification overlay.
  ///
  /// Creates and shows a new notification with the specified content, styling,
  /// and behavior options. Automatically dismisses any existing notification
  /// before showing the new one.
  ///
  /// [content] - Required notification content (title, message, etc.)
  /// [option] - Optional behavior configuration (duration, interactions)
  /// [theme] - Optional visual styling configuration (colors, spacing)
  ///
  /// Example:
  /// ```dart
  /// EasyInAppNotify.show(
  ///   content: EasyInAppNotifyContent(
  ///     title: "Download Complete",
  ///     message: "Your file has been downloaded successfully.",
  ///     icon: Icons.download_done,
  ///     trailingText: "Just now",
  ///   ),
  ///   option: EasyInAppNotifyOption(
  ///     duration: 3,
  ///     showProgressBar: true,
  ///   ),
  ///   theme: EasyInAppNotifyTheme(
  ///     color: Colors.green,
  ///     elevation: 8,
  ///   ),
  /// );
  /// ```
  static void show({
    required final EasyInAppNotifyContent content,
    final EasyInAppNotifyOption? option,
    final EasyInAppNotifyTheme? theme,
  }) {
    // Get overlay from the initialized context
    final overlay = Overlay.of(_context);

    // Hide any existing notification before showing new one
    if (_entry != null && _entry!.mounted) _hide();

    // Create new overlay entry with notification widget
    _entry = OverlayEntry(
      builder: (final context) {
        // Play system notification sound for audio feedback
        FlutterRingtonePlayer().playNotification();

        return _NotifyView(
          content: content,
          theme:
              theme ??
              const EasyInAppNotifyTheme(), // Use default theme if none provided
          option:
              option ??
              const EasyInAppNotifyOption(), // Use default options if none provided
          onDismissed: () => _hide(), // Clean up when dismissed
        );
      },
    );

    // Insert the notification overlay into the widget tree
    overlay.insert(_entry!);
  }

  /// Hide and clean up the current notification overlay.
  ///
  /// Removes the overlay entry from the widget tree and disposes of all
  /// associated resources. This method is called automatically when
  /// notifications are dismissed or when a new notification is shown.
  static void _hide() {
    _entry!.remove();
    _entry!.dispose();
  }
}
