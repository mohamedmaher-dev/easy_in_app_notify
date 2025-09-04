# Easy In-App Notify 📱🔥

A beautiful and customizable Flutter package for displaying notifications as in-app overlays with smooth animations, progress indicators, and intuitive user interactions.

Perfect for showing notifications when your app is in the foreground!

> **🎉 Version 2.2.0** - Enhanced with **custom widget support**, **callback handling**, **animated blur background effects**, and **improved platform-optimized sounds**! Still zero configuration required.

## 📷 Screenshots

<p align="center">
  <img src="https://raw.githubusercontent.com/mohamedmaher-dev/easy_in_app_notify/master/assets/images/screenshot-2025-09-03_15.06.09.149.png" width="300" alt="Easy In-App Notify Example 1">
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://raw.githubusercontent.com/mohamedmaher-dev/easy_in_app_notify/master/assets/images/screenshot-2025-09-03_15.06.43.597.png" width="300" alt="Easy In-App Notify Example 2">
</p>

## ✨ Features

- 🎯 **Overlay Notifications** - Non-blocking notifications that appear over your app content
- 📱 **Foreground Notifications** - Show notifications when app is active/foreground
- 🎨 **Fully Customizable** - Colors, spacing, dimensions, and visual styling
- 🛠️ **Custom Widget Support** _(Since v2.1.0)_ - Display completely custom widgets as notifications
- 📞 **Callback Handling** _(Since v2.1.0)_ - Handle tap events and dismissal callbacks
- ⏱️ **Auto-Dismiss** - Configurable duration with visual countdown progress bar
- 👆 **Swipe to Dismiss** - Users can swipe notifications away manually
- 🎭 **Smooth Animations** - Slide-in/slide-out transitions with easing curves
- 🌫️ **Animated Blur Background** _(Since v2.1.0)_ - Beautiful animated backdrop blur effect with smooth fade transitions and semi-transparent overlay for modern iOS-style appearance
- 🔊 **Platform-Optimized Sounds** _(Enhanced in v2.1.0)_ - Smart platform detection: alert sound on desktop, click sound on mobile/web (no external dependencies)
- 🎯 **Material Design** - Follows Material Design principles and theming
- 📱 **Safe Area Aware** - Respects device safe areas and notches
- 🌐 **RTL Support** - Full right-to-left language support
- 🚀 **Lightweight** - Minimal dependencies and optimized performance

## 📦 Installation

Run this command to add the package to your project:

```bash
flutter pub add easy_in_app_notify
```

Or manually add to your `pubspec.yaml`:

```yaml
dependencies:
  easy_in_app_notify: # Latest version from pub.dev
```

## 🚀 Quick Start

### 1. Zero Configuration Setup

No setup required! Just import and use:

```dart
import 'package:easy_in_app_notify/easy_in_app_notify.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            EasyInAppNotify.show(
              context, // Pass context as first parameter
              content: EasyInAppNotifyContent(
                title: "Hello!",
                message: "Welcome to the app.",
              ),
            );
          },
          child: Text('Show Notification'),
        ),
      ),
    );
  }
}
```

**That's it!**

- ✅ **Zero setup** - no initialization or configuration required
- ✅ **No StatefulWidget** needed
- ✅ **Direct usage** - just call with any BuildContext
- ✅ **Works everywhere** in your app

### 2. Show Notifications

Display notifications anywhere in your app:

```dart
EasyInAppNotify.show(
  context, // Pass your BuildContext
  content: EasyInAppNotifyContent(
    title: "Success!",
    message: "Your changes have been saved successfully.",
  ),
);
```

## 📖 Usage Examples

### Basic Notification

```dart
EasyInAppNotify.show(
  context,
  content: EasyInAppNotifyContent(
    title: "Welcome!",
    message: "Thanks for using our app.",
  ),
);
```

### Notification with Custom Icon

```dart
EasyInAppNotify.show(
  context,
  content: EasyInAppNotifyContent(
    title: "Download Complete",
    message: "Your file has been downloaded successfully.",
    icon: Icons.download_done,
    trailingText: "2m ago",
  ),
);
```

### Customized Notification

```dart
EasyInAppNotify.show(
  context,
  content: EasyInAppNotifyContent(
    title: "Error Occurred",
    message: "Failed to save your changes. Please try again.",
    icon: Icons.error,
    trailingText: "Retry",
  ),
  option: EasyInAppNotifyOption(
    duration: 8, // Show for 8 seconds
    showProgressBar: true,
    swipeToDismiss: true,
  ),
  theme: EasyInAppNotifyTheme(
    color: Colors.red,
    elevation: 10,
    radius: 15,
    margin: 10,
  ),
);
```

### Different Notification Types

```dart
// Success notification
EasyInAppNotify.show(
  context,
  content: EasyInAppNotifyContent(
    title: "Success",
    message: "Operation completed successfully!",
    icon: Icons.check_circle,
  ),
  theme: EasyInAppNotifyTheme(color: Colors.green),
);

// Warning notification
EasyInAppNotify.show(
  context,
  content: EasyInAppNotifyContent(
    title: "Warning",
    message: "Please check your internet connection.",
    icon: Icons.warning,
  ),
  theme: EasyInAppNotifyTheme(color: Colors.orange),
);

// Info notification
EasyInAppNotify.show(
  context,
  content: EasyInAppNotifyContent(
    title: "Info",
    message: "New features are available in settings.",
    icon: Icons.info,
  ),
  theme: EasyInAppNotifyTheme(color: Colors.blue),
);
```

### ✨ NEW in v2.1.0: Custom Widget Notifications

Display completely custom widgets as notifications:

```dart
// Custom styled notification with any widget
EasyInAppNotify.showCustom(
  context,
  Container(
    margin: EdgeInsets.all(16),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple, Colors.pink],
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
      ],
    ),
    child: Row(
      children: [
        Icon(Icons.star, color: Colors.white, size: 28),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Achievement Unlocked!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'You\'ve completed 100 tasks',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
```

### 📞 NEW in v2.1.0: Callback Handling

Handle user interactions with notifications:

```dart
// Notification with tap and dismissal callbacks
EasyInAppNotify.show(
  context,
  content: EasyInAppNotifyContent(
    title: "New Message",
    message: "Tap to view conversation",
    icon: Icons.message,
  ),
  onTap: () {
    // Handle notification tap
    Navigator.pushNamed(context, '/chat');
    print('Notification tapped!');
  },
  onDismissed: () {
    // Handle notification dismissal
    print('Notification was dismissed');
    // Log analytics, update state, etc.
  },
  theme: EasyInAppNotifyTheme(color: Colors.green),
);
```

## 🏗️ Using Without Direct Context Access

When you need to show notifications from classes that don't have access to BuildContext (like service classes, static methods, or background tasks), here are several patterns you can use:

### 1. Pass Context as Parameter

The simplest approach is to pass context as a parameter to methods that need it:

```dart
class ApiService {
  static void handleError(BuildContext context, String error) {
    EasyInAppNotify.show(
      context,
      content: EasyInAppNotifyContent(
        title: "API Error",
        message: error,
      ),
      theme: EasyInAppNotifyTheme(color: Colors.red),
    );
  }
}

// Usage
ApiService.handleError(context, "Network request failed");
```

### 2. Callback Pattern

Use callbacks to decouple your business logic from UI concerns:

```dart
class DataService {
  static Function(String)? onError;
  static Function(String)? onSuccess;

  static void fetchData() {
    try {
      // ... fetch logic
      onSuccess?.call("Data loaded successfully");
    } catch (e) {
      onError?.call("Failed to fetch data: $e");
    }
  }
}

// Setup in your widget
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Setup callbacks
    DataService.onError = (message) {
      EasyInAppNotify.show(
        context,
        content: EasyInAppNotifyContent(
          title: "Error",
          message: message,
        ),
        theme: EasyInAppNotifyTheme(color: Colors.red),
      );
    };

    DataService.onSuccess = (message) {
      EasyInAppNotify.show(
        context,
        content: EasyInAppNotifyContent(
          title: "Success",
          message: message,
        ),
        theme: EasyInAppNotifyTheme(color: Colors.green),
      );
    };

    return YourWidget();
  }
}
```

### 3. Navigator Key Pattern

Create a global navigator key to access context from anywhere:

```dart
class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void showNotification(String title, String message, {Color? color}) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      EasyInAppNotify.show(
        context,
        content: EasyInAppNotifyContent(title: title, message: message),
        theme: EasyInAppNotifyTheme(color: color ?? Colors.blue),
      );
    }
  }
}

// In your MaterialApp
MaterialApp(
  navigatorKey: AppNavigator.navigatorKey,
  home: MyHomePage(),
)

// Usage from anywhere (services, static methods, etc.)
AppNavigator.showNotification(
  "Upload Complete",
  "Your file has been uploaded successfully!",
  color: Colors.green,
);
```

### 4. Service Locator Pattern

Use a service locator or dependency injection pattern:

```dart
class NotificationService {
  BuildContext? _context;

  void setContext(BuildContext context) => _context = context;

  void showSuccess(String message) {
    _showNotification("Success", message, Colors.green);
  }

  void showError(String message) {
    _showNotification("Error", message, Colors.red);
  }

  void showInfo(String message) {
    _showNotification("Info", message, Colors.blue);
  }

  void _showNotification(String title, String message, Color color) {
    if (_context != null) {
      EasyInAppNotify.show(
        _context!,
        content: EasyInAppNotifyContent(title: title, message: message),
        theme: EasyInAppNotifyTheme(color: color),
      );
    }
  }
}

// Register and use
final notificationService = NotificationService();

// In your widget
@override
Widget build(BuildContext context) {
  notificationService.setContext(context);
  // ... rest of your widget
}

// Usage from anywhere
notificationService.showSuccess("Operation completed!");
```

### 5. Provider/Riverpod Pattern

If you're using state management, you can integrate notifications:

```dart
// Using Provider
class NotificationProvider extends ChangeNotifier {
  BuildContext? _context;

  void setContext(BuildContext context) => _context = context;

  void showNotification(String title, String message) {
    if (_context != null) {
      EasyInAppNotify.show(
        _context!,
        content: EasyInAppNotifyContent(title: title, message: message),
      );
    }
  }
}

// Usage
Provider.of<NotificationProvider>(context, listen: false)
  .showNotification("Hello", "World");
```

### 6. Firebase Cloud Messaging (FCM) Integration

When using Firebase Cloud Messaging, you often need to handle notifications in background handlers where BuildContext isn't available:

```dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class FCMService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void initialize() {
    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages when app is active
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showFCMNotification(message);
    });

    // Handle notification opened app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _showFCMNotification(message);
    });
  }

  static void _showFCMNotification(RemoteMessage message) {
    final context = navigatorKey.currentContext;
    if (context != null && message.notification != null) {
      // Determine notification type from FCM data
      final notificationType = message.data['type'] ?? 'info';
      Color notificationColor = _getColorForType(notificationType);
      IconData notificationIcon = _getIconForType(notificationType);

      EasyInAppNotify.show(
        context,
        content: EasyInAppNotifyContent(
          title: message.notification!.title ?? 'Notification',
          message: message.notification!.body ?? '',
          icon: notificationIcon,
          trailingText: message.data['timestamp'] ?? 'Now',
        ),
        theme: EasyInAppNotifyTheme(color: notificationColor),
        option: EasyInAppNotifyOption(
          duration: int.tryParse(message.data['duration'] ?? '5') ?? 5,
        ),
      );
    }
  }

  static Color _getColorForType(String type) {
    switch (type.toLowerCase()) {
      case 'success': return Colors.green;
      case 'error': return Colors.red;
      case 'warning': return Colors.orange;
      default: return Colors.blue;
    }
  }

  static IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'success': return Icons.check_circle;
      case 'error': return Icons.error;
      case 'warning': return Icons.warning;
      default: return Icons.notifications;
    }
  }
}

// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');

  // Note: You cannot show in-app notifications when app is in background
  // Background messages are handled by the system notification tray
  // Use local notifications for background scenarios if needed
}

// Setup in your main app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize FCM
  FCMService.initialize();

  runApp(MyApp());
}

// In your MaterialApp
MaterialApp(
  navigatorKey: FCMService.navigatorKey,
  home: MyHomePage(),
)
```

#### Advanced FCM Integration with Custom Routing

```dart
class AdvancedFCMService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void initialize() {
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationClick);
  }

  static void _handleForegroundMessage(RemoteMessage message) {
    final messageType = message.data['messageType'] ?? 'general';

    switch (messageType) {
      case 'chat':
        _showChatNotification(message);
        break;
      case 'order':
        _showOrderNotification(message);
        break;
      case 'promotion':
        _showPromotionNotification(message);
        break;
      default:
        _showGeneralNotification(message);
    }
  }

  static void _showChatNotification(RemoteMessage message) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      EasyInAppNotify.show(
        context,
        content: EasyInAppNotifyContent(
          title: message.data['senderName'] ?? 'New Message',
          message: message.notification?.body ?? '',
          icon: Icons.chat,
          trailingText: _formatTimestamp(message.data['timestamp']),
        ),
        theme: EasyInAppNotifyTheme(color: Colors.green),
        option: EasyInAppNotifyOption(duration: 6),
      );
    }
  }

  static void _showOrderNotification(RemoteMessage message) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      final status = message.data['orderStatus'] ?? 'updated';
      EasyInAppNotify.show(
        context,
        content: EasyInAppNotifyContent(
          title: 'Order ${status.toUpperCase()}',
          message: message.notification?.body ?? '',
          icon: _getOrderIcon(status),
          trailingText: '#${message.data['orderId'] ?? ''}',
        ),
        theme: EasyInAppNotifyTheme(color: _getOrderColor(status)),
      );
    }
  }

  static void _showPromotionNotification(RemoteMessage message) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      EasyInAppNotify.show(
        context,
        content: EasyInAppNotifyContent(
          title: message.notification?.title ?? 'Special Offer!',
          message: message.notification?.body ?? '',
          icon: Icons.local_offer,
          trailingText: message.data['discount'] ?? 'Limited Time',
        ),
        theme: EasyInAppNotifyTheme(
          color: Colors.orange,
          elevation: 10,
        ),
        option: EasyInAppNotifyOption(duration: 8),
      );
    }
  }

  static void _showGeneralNotification(RemoteMessage message) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      EasyInAppNotify.show(
        context,
        content: EasyInAppNotifyContent(
          title: message.notification?.title ?? 'Notification',
          message: message.notification?.body ?? '',
          icon: Icons.notifications,
        ),
        theme: EasyInAppNotifyTheme(color: Colors.blue),
      );
    }
  }

  static void _handleNotificationClick(RemoteMessage message) {
    // Handle navigation when notification is clicked
    final route = message.data['route'];
    if (route != null) {
      navigatorKey.currentState?.pushNamed(route);
    }
  }

  static String _formatTimestamp(String? timestamp) {
    if (timestamp == null) return 'Now';
    try {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inMinutes < 1) return 'Now';
      if (difference.inHours < 1) return '${difference.inMinutes}m ago';
      if (difference.inDays < 1) return '${difference.inHours}h ago';
      return '${difference.inDays}d ago';
    } catch (e) {
      return 'Now';
    }
  }

  static IconData _getOrderIcon(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed': return Icons.check_circle;
      case 'shipped': return Icons.local_shipping;
      case 'delivered': return Icons.done_all;
      case 'cancelled': return Icons.cancel;
      default: return Icons.shopping_cart;
    }
  }

  static Color _getOrderColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed': return Colors.green;
      case 'shipped': return Colors.blue;
      case 'delivered': return Colors.purple;
      case 'cancelled': return Colors.red;
      default: return Colors.orange;
    }
  }
}
```

## 🛠️ API Reference

### Methods

#### `EasyInAppNotify.show()`

Display a standard notification with customizable content, styling, and behavior.

```dart
static void show(
  BuildContext context, {
  required EasyInAppNotifyContent content,
  EasyInAppNotifyOption? option,
  EasyInAppNotifyTheme? theme,
  VoidCallback? onTap,        // NEW in v2.1.0
  VoidCallback? onDismissed,  // NEW in v2.1.0
})
```

**Parameters:**

- `context`: BuildContext to access the overlay
- `content`: Notification content (title, message, icon, etc.)
- `option`: Optional behavior settings (duration, progress bar, etc.)
- `theme`: Optional visual styling settings
- `onTap`: Callback executed when notification is tapped _(NEW in v2.1.0)_
- `onDismissed`: Callback executed when notification is dismissed _(NEW in v2.1.0)_

#### `EasyInAppNotify.showCustom()` _(NEW in v2.1.0)_

Display a completely custom widget as a notification.

**⚠️ Important:** Custom notifications do **NOT** auto-dismiss and must be dismissed manually using `EasyInAppNotify.dismiss()`.

```dart
static void showCustom(
  BuildContext context,
  Widget child,
)
```

**Parameters:**

- `context`: BuildContext to access the overlay
- `child`: Custom widget to display as notification

**Basic Example:**

```dart
// Show custom notification
EasyInAppNotify.showCustom(
  context,
  Container(
    margin: EdgeInsets.all(16),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.purple,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      'Custom notification that stays until dismissed',
      style: TextStyle(color: Colors.white),
    ),
  ),
);

// Later, dismiss it programmatically
EasyInAppNotify.dismiss();
```

**Interactive Example:**

```dart
// Custom notification with buttons
EasyInAppNotify.showCustom(
  context,
  Container(
    margin: EdgeInsets.all(16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Do you want to continue?'),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                EasyInAppNotify.dismiss(); // Dismiss on button press
                // Handle "Yes" action
              },
              child: Text('Yes'),
            ),
            ElevatedButton(
              onPressed: () {
                EasyInAppNotify.dismiss(); // Dismiss on button press
                // Handle "No" action
              },
              child: Text('No'),
            ),
          ],
        ),
      ],
    ),
  ),
);
```

#### `EasyInAppNotify.dismiss()` _(NEW in v2.1.0)_

Programmatically dismiss the current notification and trigger the dismiss callback.

**⭐ Works with both regular and custom notifications!**

```dart
static void dismiss()
```

This method triggers the `onDismissed` callback (if provided) and then removes the notification from the screen. Use this when you want to programmatically dismiss a notification and ensure callbacks are executed.

**Examples:**

```dart
// Regular notification with dismiss callback
EasyInAppNotify.show(
  context,
  content: EasyInAppNotifyContent(title: "Info", message: "Message"),
  onDismissed: () => print("Notification was dismissed"),
);

// Later, programmatically dismiss it
EasyInAppNotify.dismiss(); // This will call the onDismissed callback
```

```dart
// Custom notification (requires manual dismissal)
EasyInAppNotify.showCustom(
  context,
  MyCustomNotificationWidget(),
);

// Must dismiss manually since custom notifications don't auto-dismiss
EasyInAppNotify.dismiss(); // This will hide the custom notification
```

#### `EasyInAppNotify.hide()`

Manually hide the currently displayed notification without triggering callbacks.

```dart
static void hide()
```

#### `EasyInAppNotify.isShowing`

Check if a notification is currently being displayed.

```dart
static bool get isShowing
```

## 🎛️ Configuration

### EasyInAppNotifyContent

Configure the notification content:

| Property       | Type        | Description                              | Default               |
| -------------- | ----------- | ---------------------------------------- | --------------------- |
| `title`        | `String`    | Main notification title (required)       | -                     |
| `message`      | `String`    | Notification message (required)          | -                     |
| `icon`         | `IconData?` | Optional icon to display                 | `CupertinoIcons.bell` |
| `trailingText` | `String?`   | Optional trailing text (e.g., timestamp) | `null`                |

### EasyInAppNotifyOption

Configure notification behavior:

| Property          | Type   | Description                      | Default |
| ----------------- | ------ | -------------------------------- | ------- |
| `duration`        | `int`  | Auto-dismiss duration in seconds | `5`     |
| `showProgressBar` | `bool` | Show countdown progress bar      | `true`  |
| `swipeToDismiss`  | `bool` | Enable swipe-to-dismiss          | `true`  |

### EasyInAppNotifyTheme

Configure visual appearance:

| Property    | Type     | Description              | Default             |
| ----------- | -------- | ------------------------ | ------------------- |
| `color`     | `Color?` | Primary accent color     | App's primary color |
| `margin`    | `double` | Margin from screen edges | `5.0`               |
| `padding`   | `double` | Internal padding         | `10.0`              |
| `radius`    | `double` | Border radius            | `10.0`              |
| `elevation` | `double` | Card elevation/shadow    | `5.0`               |
| `iconSize`  | `double` | Icon size                | `20.0`              |

## 🎨 Theming

### Using App Theme Colors

The package automatically uses your app's theme colors when no custom colors are specified:

```dart
EasyInAppNotify.show(
  context,
  content: EasyInAppNotifyContent(
    title: "Themed Notification",
    message: "This uses your app's primary color!",
  ),
  // No theme specified - uses app's primary color
);
```

### Custom Theme

```dart
EasyInAppNotify.show(
  context,
  content: EasyInAppNotifyContent(
    title: "Custom Theme",
    message: "This notification has custom styling.",
  ),
  theme: EasyInAppNotifyTheme(
    color: Color(0xFF6366F1), // Custom purple color
    elevation: 12,
    radius: 20,
    margin: 15,
    padding: 15,
    iconSize: 24,
  ),
);
```

### 🌫️ Animated Blur Background Effect _(NEW in v2.1.0)_

All notifications now feature a beautiful animated blur background effect that creates a modern, polished appearance:

- **🎯 Backdrop Blur**: Blurs the background content while keeping it visible
- **🎬 Smooth Fade Animation**: Blur effect fades in and out with smooth transitions
- **📱 iOS-Style Design**: Modern appearance similar to iOS notifications
- **🌑 Semi-Transparent Overlay**: Dark overlay (30% opacity) ensures text readability
- **✨ Professional Polish**: Adds depth and visual hierarchy to notifications
- **🔧 Automatic**: No configuration needed - works out of the box

**Animation Features:**

- **300ms fade-in** when notification appears
- **Synchronized fade-out** when notification dismisses
- **Smooth curves** using easeInOut animation timing
- **Perfect coordination** with slide animations

**Visual Benefits:**

- Creates focus on the notification content
- Maintains visual context of the background
- Reduces visual noise and distractions
- Enhances text contrast and readability
- Provides a premium, modern user experience
- Adds professional animation polish

The animated blur effect is automatically applied to all notification types (both regular and custom) and works seamlessly across all platforms.

## 📱 Platform-Specific Behavior

### Sound Support

EasyInAppNotify uses platform-optimized system sounds based on Flutter's platform support:

- **🖥️ Desktop (Windows, macOS, Linux)**: Uses `SystemSoundType.alert` - proper notification alert sound
- **📱 Mobile (iOS, Android)**: Uses `SystemSoundType.click` - brief button press sound
- **🌐 Web**: Attempts `SystemSoundType.click` - may work in some browsers, silently ignored if not supported

#### When Sounds May Not Play

Notification sounds may not play in these situations:

- **📴 Silent Mode**: Device is in silent/vibrate mode
- **🔇 System Settings**: User has disabled system sounds
- **🎵 Focus Modes**: Device is in Do Not Disturb or Focus mode
- **🔊 Volume**: Media/notification volume is set to zero
- **🌐 Web Permissions**: Browser blocks auto-play audio

This is normal behavior and matches how system notifications work on each platform.

### Platform Compatibility

| Platform | Sound Support | Overlay Support | RTL Support |
| -------- | ------------- | --------------- | ----------- |
| Android  | ✅ Click      | ✅ Full         | ✅ Yes      |
| iOS      | ✅ Click      | ✅ Full         | ✅ Yes      |
| Web      | ⚠️ Click\*    | ✅ Full         | ✅ Yes      |
| macOS    | ✅ Alert      | ✅ Full         | ✅ Yes      |
| Windows  | ✅ Alert      | ✅ Full         | ✅ Yes      |
| Linux    | ✅ Alert      | ✅ Full         | ✅ Yes      |

**\*Web sound support:** Varies by browser and user settings; may be silently ignored

#### **🔊 Sound Behavior Notes**

- **Mobile**: `SystemSoundType.click` provides a brief, subtle notification sound
- **Desktop**: `SystemSoundType.alert` provides a proper system notification alert
- **Web**: Attempts `SystemSoundType.click` but depends on browser audio policies
- **All Platforms**: Respects user's silent mode and system sound settings

## 🔧 Advanced Usage

### Conditional Progress Bar

```dart
EasyInAppNotify.show(
  context,
  content: EasyInAppNotifyContent(
    title: "Processing...",
    message: "Please wait while we process your request.",
  ),
  option: EasyInAppNotifyOption(
    duration: 10,
    showProgressBar: true, // Show progress for long operations
    swipeToDismiss: false, // Prevent dismissal during processing
  ),
);
```

### Quick Notification Helper

Create helper methods for common notification types:

```dart
class NotificationHelper {
  static void showSuccess(BuildContext context, String title, String message) {
    EasyInAppNotify.show(
      context,
      content: EasyInAppNotifyContent(
        title: title,
        message: message,
        icon: Icons.check_circle,
      ),
      theme: EasyInAppNotifyTheme(color: Colors.green),
      option: EasyInAppNotifyOption(duration: 3),
    );
  }

  static void showError(BuildContext context, String title, String message) {
    EasyInAppNotify.show(
      context,
      content: EasyInAppNotifyContent(
        title: title,
        message: message,
        icon: Icons.error,
      ),
      theme: EasyInAppNotifyTheme(color: Colors.red),
      option: EasyInAppNotifyOption(duration: 6),
    );
  }
}

// Usage
NotificationHelper.showSuccess("Saved!", "Your profile has been updated.");
NotificationHelper.showError("Error", "Failed to connect to server.");
```

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

> **Note:** Sound notifications are only supported on Android and iOS platforms. On other platforms, notifications will display without sound.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup

1. Fork the repository
2. Clone your fork: `git clone https://github.com/mohamedmaher-dev/easy_in_app_notify.git`
3. Create a feature branch: `git checkout -b feature/amazing-feature`
4. Make your changes and add tests
5. Commit your changes: `git commit -m 'Add amazing feature'`
6. Push to the branch: `git push origin feature/amazing-feature`
7. Open a Pull Request

## 🐛 Issues

If you encounter any issues or have feature requests, please file them on the [GitHub Issues](https://github.com/mohamedmaher-dev/easy_in_app_notify/issues) page.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design for the design guidelines
- The Flutter community for inspiration and feedback

---

Made with ❤️ for the Flutter community
