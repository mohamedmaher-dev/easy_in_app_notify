# Changelog

All notable changes to the Easy In-App Notify package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.1] - 2024-01-XX

### 🎉 Initial Release

This is the first release of Easy In-App Notify, providing a complete solution for beautiful Firebase Cloud Messaging (FCM) in-app notifications in Flutter applications.

### ✨ Added

#### Core Features

- **Firebase Integration**: Perfect for Firebase Cloud Messaging (FCM) notifications
- **Foreground Notifications**: Show FCM messages when app is active/foreground
- **Overlay Notifications**: Non-blocking notifications that appear over app content
- **Auto-Dismiss**: Configurable duration with automatic dismissal
- **Manual Dismiss**: Swipe-to-dismiss functionality for user control
- **Sound Support**: Built-in notification sound playback
- **Single Notification Policy**: Ensures only one notification is shown at a time

#### Animation System

- **Smooth Slide Animation**: Notifications slide in from the top with easing curves
- **Progress Animation**: Visual countdown with linear progress indicator
- **Coordinated Timing**: Synchronized animations for professional appearance

#### Customization Options

- **Content Configuration**: Title, message, icon, and trailing text
- **Behavioral Options**: Duration, progress bar visibility, swipe dismissal
- **Visual Theming**: Colors, spacing, dimensions, elevation, and border radius
- **Material Design**: Automatic integration with app's Material theme

#### User Experience

- **Safe Area Awareness**: Respects device safe areas and notches
- **RTL Support**: Full right-to-left language support
- **Responsive Design**: Adapts to different screen sizes and orientations
- **Accessibility**: Follows Flutter accessibility guidelines

#### Technical Implementation

- **Provider Pattern**: Efficient state management and data distribution
- **Part Files**: Clean modular architecture for maintainability
- **Resource Management**: Proper disposal of animations and timers
- **Memory Optimization**: Prevents memory leaks with careful cleanup

### 🏗️ Architecture

#### Data Models

- `EasyInAppNotifyContent`: Notification content configuration
- `EasyInAppNotifyOption`: Behavior and interaction settings
- `EasyInAppNotifyTheme`: Visual styling and appearance

#### View Components

- `_NotifyView`: Root notification widget with lifecycle management
- `_NotifyContainer`: Positioning, animations, and user interactions
- `_NotifyCard`: Material card structure and layout
- `_NotificationContent`: Text content and icon display
- `_NotificationIcon`: Styled icon with background container
- `_NotifyProgress`: Animated progress bar indicator

#### Controllers

- `_AnimManger`: Animation coordination and timing management
- `EasyInAppNotify`: Global notification controller and API

### 📦 Dependencies

- **flutter**: SDK framework (>=1.17.0)
- **provider**: State management (^6.1.5+1)
- **flutter_ringtone_player**: Notification sounds (^4.0.0+4)

### 🔧 Requirements

- **Dart**: ^3.9.0
- **Flutter**: >=1.17.0

### 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

### 📋 API Reference

#### Main API

```dart
// Initialize notification service (call in initState)
EasyInAppNotify.init(BuildContext context)

// Show notification
EasyInAppNotify.show({
  required EasyInAppNotifyContent content,
  EasyInAppNotifyOption? option,
  EasyInAppNotifyTheme? theme,
})
```

#### Initialization Pattern

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(), // StatefulWidget AFTER MaterialApp
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // Initialize AFTER MaterialApp is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      EasyInAppNotify.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(/* your content */);
  }
}
```

#### Content Configuration

```dart
EasyInAppNotifyContent({
  required String title,
  required String message,
  IconData? icon,
  String? trailingText,
})
```

#### Options Configuration

```dart
EasyInAppNotifyOption({
  int duration = 5,
  bool showProgressBar = true,
  bool swipeToDismiss = true,
})
```

#### Theme Configuration

```dart
EasyInAppNotifyTheme({
  Color? color,
  double margin = 5,
  double padding = 10,
  double radius = 10,
  double elevation = 5,
  double iconSize = 20,
})
```

### 🎯 Use Cases

Perfect for displaying:

- 🔥 **Firebase Cloud Messaging** notifications
- 💬 **Chat messages** from FCM
- 📢 **Push notifications** when app is foreground
- 🛍️ **Promotional messages** from Firebase
- ⚠️ **Alert notifications** via FCM
- ✅ Success confirmations
- ❌ Error messages
- ℹ️ Information updates
- 📱 Status notifications
- 🔔 Event announcements
- 🎯 Achievement unlocks

### 🚀 Performance

- **Lightweight**: Minimal memory footprint
- **Efficient**: Optimized animations and rendering
- **Responsive**: Smooth 60fps animations
- **Resource-Aware**: Proper cleanup prevents memory leaks

---

## Future Releases

### Planned Features for v0.1.0

- Custom animation curves
- Multiple notification queue support
- Tap-to-action callbacks
- Custom widget content support
- Position configuration options

### Roadmap

- **v0.2.0**: Enhanced customization and interaction options
- **v0.3.0**: Advanced animation effects and transitions
- **v1.0.0**: Stable API with comprehensive testing

---

_This changelog follows the [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format._
