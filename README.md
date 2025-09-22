# 📱 Easy In-App Notify

**Beautiful, customizable in-app notifications for Flutter applications**

[![pub package](https://img.shields.io/pub/v/easy_in_app_notify.svg)](https://pub.dev/packages/easy_in_app_notify)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white)](https://flutter.dev)

---

## 🌟 Overview

Easy In-App Notify is a powerful Flutter package that provides beautiful overlay notifications with smooth animations, customizable theming, and universal widget support. Perfect for displaying non-blocking notifications when your app is in the foreground.

**Latest Version: 2.3.1** - Now with centralized auto-dismiss system, universal dismiss support, and enhanced architecture!

---

## 📸 Screenshots

<div align="center">
  
| Standard Notification | Custom Widget | v2.3.0 Features |
|:---:|:---:|:---:|
| ![Standard Notification](https://raw.githubusercontent.com/mohamedmaher-dev/easy_in_app_notify/test/assets/images/screenshot-2025-09-03_15.06.09.149.png) | ![Custom Widget](https://raw.githubusercontent.com/mohamedmaher-dev/easy_in_app_notify/test/assets/images/screenshot-2025-09-03_15.06.43.597.png) | ![v2.3.0 Demo](https://raw.githubusercontent.com/mohamedmaher-dev/easy_in_app_notify/test/assets/images/screenshot-2025-09-22_11.51.50.62.png) |
| Built-in notification with progress bar | Custom Card widget with icons | v2.3.1 features demonstration |

</div>

---

## ✨ Features

### 🆕 **New in v2.3.1**

- 🔧 **Fixed onTap Callback** - Critical bug fix for tap event handling
- 📱 **Enhanced Documentation** - New Samsung Galaxy A14 screenshot
- 🔍 **SEO Optimized** - Package description optimized for better discoverability
- 🖼️ **Visual Improvements** - Professional three-column screenshot layout

### 🚀 **Core Features (v2.3.0+)**

- 🎯 **Centralized Auto-Dismiss** - Universal timer management for all notification types
- 🔧 **Universal Dismiss Support** - `dismiss()` works with any widget (Card, Container, custom widgets)
- ✅ **Duration Validation** - Ensures reliable auto-dismiss behavior (duration > 0)
- 📚 **Enhanced Documentation** - Comprehensive code documentation with examples
- 🏗️ **Refactored Architecture** - Improved maintainability and code organization

### 🚀 **Core Capabilities**

- 📱 **Overlay Notifications** - Non-blocking notifications over your app content
- 🎨 **Custom Widget Support** - Display any Flutter widget as a notification
- ⏱️ **Configurable Auto-Dismiss** - Set custom durations with visual progress indicators
- 👆 **Swipe to Dismiss** - Intuitive gesture-based dismissal
- 🎭 **Smooth Animations** - Beautiful slide-in/out transitions with easing curves
- 🌫️ **Animated Blur Background** - Modern iOS-style backdrop effects
- 🔊 **Platform-Optimized Sounds** - Smart sound selection per platform
- 📞 **Callback Support** - Handle tap events and dismissal callbacks
- 🌐 **Universal Compatibility** - Works with Material Design, Cupertino, and custom themes

---

## 📦 Installation

### Using Flutter CLI

```bash
flutter pub add easy_in_app_notify
```

### Manual Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  easy_in_app_notify: ^2.3.0
```

Then run:

```bash
flutter pub get
```

---

## 🚀 Quick Start

### Basic Usage

```dart
import 'package:easy_in_app_notify/easy_in_app_notify.dart';

// Show a simple notification
            EasyInAppNotify.show(
  context,
  view: EasyInAppView(
              content: EasyInAppNotifyContent(
      title: "Success!",
      message: "Your action was completed successfully.",
    ),
  ),
  option: EasyInAppNotifyOption(
    duration: 3, // Auto-dismiss after 3 seconds
  ),
);
```

### Custom Widget Notification (v2.3.0)

```dart
// Display any custom widget as a notification
EasyInAppNotify.show(
  context,
  view: Card(
    margin: EdgeInsets.all(16),
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 32),
          SizedBox(height: 8),
          Text("Custom Notification", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("This is a custom Card widget!"),
        ],
      ),
    ),
  ),
  option: EasyInAppNotifyOption(
    duration: 4,
    swipeToDismiss: true,
  ),
);
```

### Manual Dismissal (Universal Support)

```dart
// Show notification
EasyInAppNotify.show(context, view: myWidget, option: myOptions);

// Dismiss programmatically (works with ANY widget type)
EasyInAppNotify.dismiss();
```

---

## 🎛️ Configuration

### EasyInAppNotifyContent

Configure the notification content for standard notifications:

```dart
EasyInAppNotifyContent(
  title: "Notification Title",           // Required: Main heading
  message: "Detailed message content",   // Required: Description text
  icon: Icons.notifications,             // Optional: Leading icon
  trailingText: "2m ago",               // Optional: Trailing text
)
```

| Property       | Type        | Description                  | Default               |
| -------------- | ----------- | ---------------------------- | --------------------- |
| `title`        | `String`    | Main notification title      | Required              |
| `message`      | `String`    | Notification message content | Required              |
| `icon`         | `IconData?` | Optional leading icon        | `CupertinoIcons.bell` |
| `trailingText` | `String?`   | Optional trailing text       | `null`                |
| `trailing`     | `Widget?`   | Custom trailing widget       | `null`                |

### EasyInAppNotifyOption

Control notification timing and auto-dismiss behavior:

```dart
EasyInAppNotifyOption(
  duration: 5,              // Auto-dismiss duration (must be > 0)
)
```

| Property   | Type  | Description                                    | Default |
| ---------- | ----- | ---------------------------------------------- | ------- |
| `duration` | `int` | Auto-dismiss duration in seconds (must be > 0) | `5`     |

> **⚠️ Important:** In v2.3.0, `duration` must be greater than 0. Use `duration: 1` or higher.
>
> **📝 Note:** `showProgressBar` and `swipeToDismiss` have been moved to `EasyInAppNotifyTheme` for better organization.

### EasyInAppNotifyTheme

Customize visual appearance and styling:

```dart
EasyInAppNotifyTheme(
  color: Colors.blue,         // Primary accent color
  margin: 16.0,              // Margin from screen edges
  radius: 12.0,              // Border radius
  elevation: 8.0,            // Shadow elevation
  blurBackground: true,      // Enable blur effect
  showProgressBar: true,     // Show countdown progress bar
  swipeToDismiss: true,      // Enable swipe gestures
)
```

| Property          | Type     | Description                      | Default             |
| ----------------- | -------- | -------------------------------- | ------------------- |
| `color`           | `Color?` | Primary accent color             | App's primary color |
| `margin`          | `double` | Margin from screen edges         | `5.0`               |
| `padding`         | `double` | Internal padding                 | `10.0`              |
| `radius`          | `double` | Border radius                    | `10.0`              |
| `elevation`       | `double` | Shadow elevation                 | `5.0`               |
| `iconSize`        | `double` | Icon size                        | `20.0`              |
| `blurBackground`  | `bool`   | Enable blur effect               | `true`              |
| `blurColor`       | `Color`  | Blur overlay color               | `Colors.black`      |
| `showProgressBar` | `bool`   | Display countdown progress bar   | `true`              |
| `swipeToDismiss`  | `bool`   | Enable swipe-to-dismiss gestures | `true`              |

---

## 🎨 Advanced Examples

### Interactive Notification with Callbacks

```dart
EasyInAppNotify.show(
  context,
  view: EasyInAppView(
  content: EasyInAppNotifyContent(
      title: "New Message",
      message: "You have received a new message",
      icon: Icons.message,
  ),
  theme: EasyInAppNotifyTheme(
      showProgressBar: true, // Now in theme
      swipeToDismiss: true,  // Now in theme
    ),
    onTap: () {
      // Handle notification tap
      Navigator.pushNamed(context, '/messages');
    },
  ),
  option: EasyInAppNotifyOption(
    duration: 6, // Only timing in options
  ),
  onDismissed: () {
    // Handle dismissal
    print('Notification was dismissed');
  },
);
```

### Custom Themed Notification

```dart
EasyInAppNotify.show(
  context,
  view: EasyInAppView(
  content: EasyInAppNotifyContent(
      title: "Premium Feature",
      message: "Unlock advanced features with Premium",
      icon: Icons.star,
    ),
    theme: EasyInAppNotifyTheme(
      color: Colors.amber,
      margin: 20.0,
      radius: 16.0,
      elevation: 12.0,
      blurBackground: true,
      blurColor: Colors.orange,
      showProgressBar: false, // Visual elements in theme
      swipeToDismiss: true,   // Gesture handling in theme
    ),
  ),
  option: EasyInAppNotifyOption(
    duration: 4, // Only timing configuration
  ),
);
```

### Complex Custom Widget

```dart
EasyInAppNotify.show(
  context,
  view: Container(
    margin: EdgeInsets.all(16),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple, Colors.pink],
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(Icons.celebration, color: Colors.white, size: 32),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Achievement Unlocked!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                "You've completed 100 tasks",
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () => EasyInAppNotify.dismiss(),
          child: Text("Claim"),
        ),
      ],
    ),
  ),
  option: EasyInAppNotifyOption(
    duration: 8,
    swipeToDismiss: true,
  ),
);
```

---

## 🏗️ Using Without Direct Context Access

When you need to show notifications from classes that don't have access to BuildContext (like service classes, static methods, or background tasks), here are several proven patterns:

### 📋 **Table of Contents**

1. [Pass Context as Parameter](#1-pass-context-as-parameter-pattern)
2. [Callback Pattern](#2-callback-pattern)
3. [Navigator Key Pattern](#3-navigator-key-pattern)
4. [Service Locator Pattern](#4-service-locator-pattern)
5. [Provider/State Management](#5-providerstate-management-pattern)

---

### **1. Pass Context as Parameter Pattern**

The simplest approach - pass context to your service methods:

```dart
class NotificationService {
  static void showSuccess(BuildContext context, String message) {
    EasyInAppNotify.show(
      context,
      view: EasyInAppViewView(
      content: EasyInAppNotifyContent(
          title: "Success",
          message: message,
          icon: Icons.check_circle,
        ),
      ),
      option: EasyInAppNotifyOption(duration: 3),
    );
  }

  static void showError(BuildContext context, String message) {
    EasyInAppNotify.show(
      context,
      view: Card(
        margin: EdgeInsets.all(16),
        color: Colors.red.shade50,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.error, color: Colors.red),
              SizedBox(width: 12),
              Expanded(
                child: Text(message, style: TextStyle(color: Colors.red.shade800)),
              ),
            ],
          ),
        ),
      ),
      option: EasyInAppNotifyOption(duration: 4),
    );
  }
}

// Usage in widgets
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Call service method with context
        NotificationService.showSuccess(context, "Operation completed!");
      },
      child: Text("Show Success"),
    );
  }
}
```

---

### **2. Callback Pattern**

Decouple services from UI by using callbacks:

```dart
class ApiService {
  static VoidCallback? _onNotificationRequest;

  // Service registers callback
  static void setNotificationCallback(VoidCallback callback) {
    _onNotificationRequest = callback;
  }

  static Future<void> fetchData() async {
    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      // Trigger notification through callback
      _onNotificationRequest?.call();
    } catch (e) {
      // Handle error
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          // Register notification callback
          ApiService.setNotificationCallback(() {
      EasyInAppNotify.show(
        context,
              view: EasyInAppViewView(
        content: EasyInAppNotifyContent(
                  title: "Data Loaded",
                  message: "Successfully fetched latest data",
                ),
              ),
              option: EasyInAppNotifyOption(duration: 3),
            );
          });

          return MyHomePage();
        },
      ),
    );
  }
}
```

---

### **3. Navigator Key Pattern**

Use a global navigator key for app-wide access:

```dart
// globals.dart
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NotificationManager {
  static void showNotification({
    required String title,
    required String message,
    IconData? icon,
    int duration = 5,
  }) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      EasyInAppNotify.show(
        context,
        view: EasyInAppViewView(
          content: EasyInAppNotifyContent(
            title: title,
            message: message,
            icon: icon ?? Icons.info,
          ),
        ),
        option: EasyInAppNotifyOption(duration: duration),
      );
    }
  }

  static void showCustomNotification(Widget customWidget) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      EasyInAppNotify.show(
        context,
        view: customWidget,
        option: EasyInAppNotifyOption(duration: 4),
      );
    }
  }
}

// main.dart
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // Register global key
  home: MyHomePage(),
    );
  }
}

// Usage anywhere in your app
class BackgroundService {
  static void processData() {
    // Simulate background processing
    Timer(Duration(seconds: 3), () {
      // Show notification from background service
      NotificationManager.showNotification(
        title: "Processing Complete",
        message: "Your data has been processed successfully",
        icon: Icons.done_all,
      );
    });
  }
}
```

---

### **4. Service Locator Pattern**

Use dependency injection for clean architecture:

```dart
// notification_service.dart
abstract class INotificationService {
  void showSuccess(String message);
  void showError(String message);
  void showCustom(Widget widget);
}

class NotificationService implements INotificationService {
  final BuildContext _context;

  NotificationService(this._context);

  @override
  void showSuccess(String message) {
    EasyInAppNotify.show(
      _context,
      view: EasyInAppViewView(
        content: EasyInAppNotifyContent(
          title: "Success",
          message: message,
          icon: Icons.check_circle,
        ),
      ),
      option: EasyInAppNotifyOption(duration: 3),
    );
  }

  @override
  void showError(String message) {
    EasyInAppNotify.show(
      _context,
      view: Card(
        margin: EdgeInsets.all(16),
        color: Colors.red.shade50,
        child: ListTile(
          leading: Icon(Icons.error, color: Colors.red),
          title: Text("Error"),
          subtitle: Text(message),
        ),
      ),
      option: EasyInAppNotifyOption(duration: 5),
    );
  }

  @override
  void showCustom(Widget widget) {
      EasyInAppNotify.show(
      _context,
      view: widget,
      option: EasyInAppNotifyOption(duration: 4),
    );
  }
}

// service_locator.dart
class ServiceLocator {
  static final Map<Type, dynamic> _services = {};

  static void register<T>(T service) {
    _services[T] = service;
  }

  static T get<T>() {
    return _services[T] as T;
  }
}

// Usage
class MyWidget extends StatelessWidget {
@override
Widget build(BuildContext context) {
    // Register service with current context
    ServiceLocator.register<INotificationService>(
      NotificationService(context),
    );

    return Scaffold(
      body: BusinessLogicWidget(),
    );
  }
}

class BusinessLogicWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Use service without direct context access
        final notificationService = ServiceLocator.get<INotificationService>();
notificationService.showSuccess("Operation completed!");
      },
      child: Text("Process Data"),
    );
  }
}
```

---

### **5. Provider/State Management Pattern**

Integrate with popular state management solutions:

#### **Using Provider**

```dart
// notification_provider.dart
class NotificationProvider extends ChangeNotifier {
  BuildContext? _context;

  void setContext(BuildContext context) {
    _context = context;
  }

  void showNotification({
    required String title,
    required String message,
    Widget? customView,
  }) {
    if (_context != null) {
      EasyInAppNotify.show(
        _context!,
        view: customView ?? EasyInAppViewView(
        content: EasyInAppNotifyContent(
            title: title,
            message: message,
          ),
        ),
        option: EasyInAppNotifyOption(duration: 4),
      );
    }
  }
}

// main.dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NotificationProvider(),
      child: MyApp(),
    ),
  );
}

// Usage in widgets
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);

    // Set context on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationProvider.setContext(context);
    });

    return ElevatedButton(
      onPressed: () {
        notificationProvider.showNotification(
          title: "Provider Notification",
          message: "Sent from Provider pattern!",
        );
      },
      child: Text("Show Notification"),
    );
  }
}
```

#### **Using Riverpod**

```dart
// providers.dart
final notificationProvider = StateNotifierProvider<NotificationNotifier, void>(
  (ref) => NotificationNotifier(),
);

class NotificationNotifier extends StateNotifier<void> {
  NotificationNotifier() : super(null);

  BuildContext? _context;

  void setContext(BuildContext context) {
    _context = context;
  }

  void showSuccess(String message) {
    if (_context != null) {
      EasyInAppNotify.show(
        _context!,
        view: EasyInAppViewView(
        content: EasyInAppNotifyContent(
            title: "Success",
            message: message,
            icon: Icons.check,
          ),
        ),
        option: EasyInAppNotifyOption(duration: 3),
      );
    }
  }
}
```

---

### **🎯 Best Practices for Context-less Usage**

1. **Choose the Right Pattern:**

   - **Simple apps**: Pass context as parameter
   - **Service-oriented**: Callback or Navigator Key pattern
   - **Complex apps**: Service Locator or State Management

2. **Context Lifecycle Management:**

   ```dart
   // Always check context validity
   if (context != null && context.mounted) {
     EasyInAppNotify.show(context, view: widget);
   }
   ```

3. **Error Handling:**

   ```dart
   try {
     EasyInAppNotify.show(context, view: widget);
    } catch (e) {
     // Fallback to console logging or other notification method
     print('Failed to show notification: $e');
   }
   ```

4. **Memory Management:**

   ```dart
   // Clear references when appropriate
   class MyService {
     BuildContext? _context;

     void dispose() {
       _context = null;
   }
   }
   ```

```

```

---

## 🔧 API Reference

### Static Methods

#### `show()`

```dart
static void show(
  BuildContext context, {
  required Widget view,
  EasyInAppNotifyOption option = const EasyInAppNotifyOption(),
  VoidCallback? onDismissed,
})
```

Displays a notification with the specified widget and options.

#### `dismiss()`

```dart
static void dismiss()
```

Programmatically dismisses the current notification with animations (v2.3.0+).

#### `hide()`

```dart
static void hide()
```

Immediately hides the current notification without animations.

#### `isShowing`

```dart
static bool get isShowing
```

Returns `true` if a notification is currently displayed.

---

## 🚨 Migration Guide

### Upgrading to v2.3.0

#### Breaking Changes

**Duration Validation:**

```dart
// ❌ No longer allowed (will throw assertion error)
EasyInAppNotifyOption(duration: 0)

// ✅ Use minimum duration of 1 second
EasyInAppNotifyOption(duration: 1)
```

#### New Features

**Universal Dismiss Support:**

```dart
// ✅ Now works with ANY widget type
EasyInAppNotify.dismiss(); // Works with Cards, Containers, custom widgets, etc.
```

**Enhanced Documentation:**

- All classes now have comprehensive documentation
- Better examples and usage patterns
- Improved error messages and debugging information

---

## 🛠️ Best Practices

### 1. **Use Appropriate Durations**

```dart
// Short messages
EasyInAppNotifyOption(duration: 3)

// Longer content that requires reading time
EasyInAppNotifyOption(duration: 6)

// Interactive notifications
EasyInAppNotifyOption(duration: 8)
```

### 2. **Handle Edge Cases**

```dart
// Check if notification is already showing
if (!EasyInAppNotify.isShowing) {
  EasyInAppNotify.show(context, view: myWidget);
}
```

### 3. **Provide User Feedback**

```dart
EasyInAppNotify.show(
  context,
  view: myWidget,
  onDismissed: () {
    // Log analytics, update state, etc.
    analytics.logNotificationDismissed();
  },
);
```

### 4. **Use Consistent Theming**

```dart
// Create app-wide theme
final appNotifyTheme = EasyInAppNotifyTheme(
  color: Theme.of(context).primaryColor,
  radius: 12.0,
  elevation: 6.0,
);

// Use consistently throughout app
EasyInAppNotify.show(
  context,
  view: EasyInAppViewView(
    content: content,
    theme: appNotifyTheme,
  ),
);
```

---

## 🔍 Troubleshooting

### Common Issues

**"Overlay not found" Error:**

- Ensure you're calling `show()` from a context within MaterialApp/WidgetsApp
- The context must have access to an Overlay

**Notifications not dismissing:**

- Check that `duration > 0` in EasyInAppNotifyOption
- Verify you're using `dismiss()` method correctly

**Styling issues:**

- Ensure custom widgets respect Material Design guidelines
- Test themes on different devices and orientations

---

## 📋 Requirements

- **Flutter**: >= 1.17.0
- **Dart**: >= 3.9.0
- **Platforms**: iOS, Android, Web, Desktop

---

## 🤝 Contributing

We welcome contributions! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes with tests
4. Submit a pull request

### Development Setup

```bash
git clone https://github.com/mohamedmaher-dev/easy_in_app_notify.git
cd easy_in_app_notify
flutter pub get
flutter test
```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🔗 Links

- **Package**: [pub.dev/packages/easy_in_app_notify](https://pub.dev/packages/easy_in_app_notify)
- **Repository**: [GitHub](https://github.com/mohamedmaher-dev/easy_in_app_notify)
- **Issues**: [Bug Reports](https://github.com/mohamedmaher-dev/easy_in_app_notify/issues)
- **Documentation**: [API Reference](https://pub.dev/documentation/easy_in_app_notify/latest/)

---

## 🙏 Acknowledgments

Built with ❤️ for the Flutter community.

Special thanks to all contributors and users who help improve this package!

---

<div align="center">

**⭐ If you find this package helpful, please give it a star on GitHub! ⭐**

![Version](https://img.shields.io/badge/Version-2.3.0-blue)
![Flutter](https://img.shields.io/badge/Flutter-Ready-brightgreen)
![MIT License](https://img.shields.io/badge/License-MIT-yellow)

</div>
