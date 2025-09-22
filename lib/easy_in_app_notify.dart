/// Easy In-App Notify - Beautiful Flutter in-app notifications
///
/// A modern, feature-rich Flutter package for displaying beautiful in-app
/// notifications with smooth animations, customizable styling, and flexible
/// configuration options.
///
/// ## Features
///
/// - 🎨 **Beautiful Design**: Modern, clean notification cards with Material Design
/// - 🎭 **Rich Animations**: Smooth slide, fade, and scale animations
/// - 🎯 **Flexible Positioning**: Top, bottom, or center positioning
/// - ⏱️ **Auto-dismiss**: Configurable auto-dismiss with progress indicators
/// - 👆 **Interactive**: Tap-to-dismiss, swipe-to-dismiss, and hover effects
/// - 🎨 **Highly Customizable**: Colors, fonts, spacing, and custom content
/// - 📱 **Responsive**: Adapts to different screen sizes and orientations
/// - 🔧 **Easy Integration**: Simple API with sensible defaults
///
/// ## Quick Start
///
/// 1. Add the notification system to your MaterialApp:
/// ```dart
/// MaterialApp(
///   builder: EasyInAppNotify.init(),
///   home: MyHomePage(),
/// )
/// ```
///
/// 2. Show notifications anywhere in your app:
/// ```dart
/// EasyInAppNotify.showSuccess(
///   title: 'Success!',
///   message: 'Your action was completed successfully.',
/// );
/// ```
///
/// ## Advanced Usage
///
/// For more control, use the main `show` method with custom configuration:
/// ```dart
/// EasyInAppNotify.show(
///   content: NotificationContent(
///     title: 'Custom Notification',
///     message: 'This notification has custom styling.',
///     icon: Icons.star,
///   ),
///   style: NotificationStyle(
///     primaryColor: Colors.purple,
///     position: NotificationPosition.bottom,
///     enableBackgroundBlur: true,
///     showProgressBar: true,
///   ),
///   config: NotificationConfig(
///     duration: 5,
///     dismissOnTap: true,
///     onTap: () => print('Notification tapped!'),
///   ),
/// );
/// ```
library;

// Core API
export 'src/easy_in_app_notify.dart';

// Models
export 'src/models/notification_content.dart';
export 'src/models/notification_style.dart'
    hide NotificationPosition, NotificationAnimation;
export 'src/models/notification_config.dart';

// Public enums
export 'src/models/notification_style.dart'
    show NotificationPosition, NotificationAnimation;
