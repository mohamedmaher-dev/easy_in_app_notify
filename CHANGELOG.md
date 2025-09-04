# Changelog

All notable changes to the Easy In-App Notify package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2025-01-09

### 🚨 BREAKING CHANGES

This release introduces significant API changes that simplify usage but require code updates.

#### Removed Methods and Requirements

- **REMOVED**: `EasyInAppNotify.init()` method - No longer needed!
- **REMOVED**: `navigatorKey` requirement in MaterialApp - No longer needed!
- **REMOVED**: All initialization steps and setup requirements
- **REMOVED**: `flutter_ringtone_player` dependency - Replaced with built-in Flutter SystemSound

#### API Changes

- **CHANGED**: `EasyInAppNotify.show()` now requires `BuildContext` as first parameter
- **CHANGED**: Simplified from 2-step setup to direct usage
- **CHANGED**: Error handling updated to reflect no setup needed

### ✨ Added

#### Zero Configuration API

- **Direct Usage**: Call `EasyInAppNotify.show(context, ...)` immediately without setup
- **Simplified Integration**: No MaterialApp modifications required
- **Zero Dependencies**: No navigator keys or initialization needed

#### Comprehensive Documentation

- **Context-less Usage Patterns**: 5 detailed patterns for using without direct BuildContext access
  - Pass Context as Parameter pattern
  - Callback Pattern for service decoupling
  - Navigator Key Pattern for global access
  - Service Locator Pattern for dependency injection
  - Provider/State Management integration
- **Firebase Cloud Messaging (FCM) Integration**: Complete FCM documentation and examples
  - Background message handling
  - Foreground notification display
  - Custom message type routing
  - Advanced FCM scenarios with real-world examples

#### New Examples

- **FCM Integration Example** (`example/lib/fcm_example.dart`): Interactive FCM simulation
  - Chat message notifications
  - Order update notifications
  - Promotional offer notifications
  - System alert notifications
- **Integration Code Snippets**: Copy-paste ready code for various scenarios
- **Interactive Demos**: Hands-on testing environment for all patterns

### 🔧 Changed

#### API Simplification

```dart
// OLD (v1.x) - Required setup
MaterialApp(
  builder: EasyInAppNotify.init(),
  home: MyHomePage(),
)

EasyInAppNotify.show(content: ...);

// NEW (v2.0) - Direct usage
MaterialApp(
  home: MyHomePage(),
)

EasyInAppNotify.show(context, content: ...);
```

#### Enhanced Error Handling

- **Updated Error Messages**: Now focus on context availability rather than setup issues
- **Clearer Guidance**: Better error messages for troubleshooting
- **Context Validation**: Improved overlay context detection

#### Dependency Reduction

- **Removed External Dependencies**: Replaced `flutter_ringtone_player` with Flutter's built-in `SystemSound`
- **Platform-Optimized Sounds**: Smart platform detection for best sound compatibility (based on Flutter's official platform support)
  - **Desktop (macOS/Windows/Linux)**: Uses `SystemSoundType.alert` (proper notification sound)
  - **Mobile (iOS/Android)**: Uses `SystemSoundType.click` (brief button press sound)
  - **Web**: Attempts `SystemSoundType.click` (may work in some browsers, gracefully ignored if not supported)
- **Universal Platform Support**: System sounds now work consistently across all Flutter platforms
- **Enhanced Error Handling**: Better handling of silent mode and disabled system sounds
- **Reduced Package Size**: Fewer dependencies mean smaller app bundle size
- **Better Reliability**: Built-in system sounds are more stable and consistent

#### Documentation Overhaul

- **Simplified Setup Instructions**: Reduced from multi-step to single-call usage
- **Real-world Patterns**: Production-ready code examples for complex scenarios
- **Platform Integration**: Detailed guides for FCM, services, and background tasks
- **Complete API Documentation**: All code examples updated to include context parameter
- **Sound Implementation Details**: Comprehensive platform-specific sound behavior documentation

### 🏗️ Architecture Improvements

#### Streamlined Initialization

- **Removed Static State**: Eliminated global navigator key management
- **Context-based Access**: Direct overlay access through BuildContext
- **Simplified Lifecycle**: No initialization or disposal requirements

#### Enhanced Flexibility

- **Multiple Usage Patterns**: Support for various architectural approaches
- **Service Integration**: Patterns for API services, background tasks, and event handlers
- **State Management**: Integration examples for Provider, Riverpod, and others

### 📖 Updated Examples

#### Example App Enhancements

- **New FCM Section**: Added fourth example category for Firebase integration
- **Interactive Simulations**: Real-time FCM message simulation with different types
- **Updated Navigation**: Enhanced example app with FCM integration showcase

#### Documentation Updates

- **All Code Examples**: Updated to use new v2.0 API
- **README Overhaul**: Comprehensive usage patterns and integration guides
- **Example README**: Added FCM integration section and updated setup instructions

### 🎯 Migration Guide

#### From v1.x to v2.0

**1. Remove Setup Code**

```dart
// REMOVE these lines from MaterialApp
builder: EasyInAppNotify.init(),
navigatorKey: EasyInAppNotify.navigatorKey,
```

**2. Update Show Calls**

```dart
// OLD
EasyInAppNotify.show(content: ...);

// NEW
EasyInAppNotify.show(context, content: ...);
```

**3. For Service Classes**
Choose from 5 documented patterns based on your architecture:

- Pass context as parameter (recommended for most cases)
- Use callbacks for clean separation
- Navigator key pattern for global access
- Service locator for dependency injection
- State management integration

### 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## [1.0.1] - 2024-01-XX

### ✨ Added

- **Screenshots**: Added visual examples to README showcasing notification UI
- **Documentation**: Enhanced README with side-by-side screenshot layout

### 🔥 Removed

- **Firebase Dependencies**: Removed Firebase-specific code and dependencies
- **Platform Lock-in**: Eliminated Firebase-only focus for broader compatibility

### 🔧 Changed

- **Package Scope**: Transformed from Firebase-specific to generic notification package
- **Topics**: Updated package topics from Firebase-focused to general notifications
- **Examples**: Converted Firebase examples to generic remote notification examples
- **Code Style**: Improved formatting and consistency across example files
- **Dependencies**: Updated example to use published package instead of git dependency

### 📖 Documentation

- **README**: Completely updated to be platform-agnostic
- **CHANGELOG**: Updated use cases to reflect generic notification support
- **Examples**: Renamed `firebase_example.dart` to `remote_example.dart`

## [1.0.0] - 2024-01-XX

### 🎉 First Stable Release

This is the first release of Easy In-App Notify, providing a complete solution for beautiful in-app notifications in Flutter applications.

### ✨ Added

#### Core Features

- **In-App Overlays**: Perfect for any notification system integration
- **Foreground Notifications**: Show notifications when app is active/foreground
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
- ~~**flutter_ringtone_player**: Notification sounds (^4.0.0+4)~~ _Removed in v2.0.0_

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

- 🔔 **Remote notifications** from any service
- 💬 **Chat messages** from messaging systems
- 📢 **Push notifications** when app is foreground
- 🛍️ **Promotional messages** from marketing services
- ⚠️ **Alert notifications** from any backend
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
