# Easy In-App Notify Examples 📱🔥

This directory contains comprehensive examples demonstrating how to use the Easy In-App Notify package for beautiful in-app notifications.

## 📁 Examples Included

### 1. **Basic Usage** (`lib/basic_example.dart`)

- Simple notification display
- Basic initialization
- Different notification types
- Success, error, warning, and info notifications

### 2. **Remote Integration** (`lib/remote_example.dart`)

- Simulated remote notifications
- Message routing and handling
- Different notification categories
- Integration patterns

### 3. **Advanced Usage** (`lib/advanced_example.dart`)

- Custom notification types
- Complex styling and theming
- Helper classes and utilities
- Sequential notifications

### 4. **FCM Integration** (`lib/fcm_example.dart`)

- Firebase Cloud Messaging integration
- Background message handling patterns
- Navigator key usage without BuildContext
- Real-world FCM scenarios

### 5. **Helper Classes** (`lib/helpers/`)

- Notification helper utilities
- Theme configurations
- Reusable notification patterns

## 🚀 Quick Start

### Basic Setup

1. **Install the package**:

   ```bash
   flutter pub add easy_in_app_notify
   ```

2. **Show notifications**:
   ```dart
   EasyInAppNotify.show(
     context, // Pass your BuildContext
     content: EasyInAppNotifyContent(
       title: "Success!",
       message: "Your operation completed successfully.",
       icon: Icons.check_circle,
     ),
   );
   ```

## 📖 Usage Examples

### 1. **Basic Notification**

```dart
EasyInAppNotify.show(
  context,
  content: EasyInAppNotifyContent(
    title: "Hello!",
    message: "This is a basic notification.",
  ),
);
```

### 2. **Remote Message Handling**

```dart
// No initialization needed!
void handleRemoteMessage(Map<String, dynamic> message) {
  EasyInAppNotify.show(
    context,
    content: EasyInAppNotifyContent(
      title: message['title'] ?? 'Notification',
      message: message['body'] ?? '',
      icon: Icons.notifications,
      trailingText: 'Now',
    ),
    option: EasyInAppNotifyOption(
      duration: 5,
      showProgressBar: true,
      swipeToDismiss: true,
    ),
    theme: EasyInAppNotifyTheme(
      color: Colors.blue,
      elevation: 8,
    ),
  );
}
```

### 3. **Custom Styling**

```dart
EasyInAppNotify.show(
  context,
  content: EasyInAppNotifyContent(
    title: "Custom Style",
    message: "This notification has custom styling.",
    icon: Icons.star,
  ),
  theme: EasyInAppNotifyTheme(
    color: Colors.purple,
    elevation: 12,
    cardBorderRadius: 16,
    iconSize: 32,
  ),
  option: EasyInAppNotifyOption(
    duration: 8,
    showProgressBar: true,
  ),
);
```

## 🎯 Integration Patterns

### Message Routing

```dart
void routeMessage(String type, String title, String body) {
  switch (type) {
    case 'chat':
      NotificationHelper.showChatMessage(
        senderName: title,
        message: body,
      );
      break;
    case 'alert':
      NotificationHelper.showError(title, body);
      break;
    default:
      NotificationHelper.showInfo(title, body);
  }
}
```

### Helper Usage

```dart
// Using the NotificationHelper class
NotificationHelper.showSuccess("Saved!", "Your changes have been saved.");
NotificationHelper.showError("Error", "Something went wrong.");
NotificationHelper.showWarning("Warning", "Please check your input.");
```

## 📱 Running the Examples

1. **Clone or download** this example project
2. **Navigate** to the example directory:
   ```bash
   cd example
   ```
3. **Install dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the app**:
   ```bash
   flutter run
   ```

## 🎨 Customization

The examples demonstrate various customization options:

- **Colors and Themes**: Different color schemes for different notification types
- **Icons**: Custom icons for different message categories
- **Duration**: Variable display times based on importance
- **Progress Bars**: Visual countdown indicators
- **Animations**: Smooth slide-in/slide-out transitions
- **Dismissal**: Swipe gestures and auto-dismiss functionality

## 📁 Project Structure

```
example/
├── lib/
│   ├── main.dart                    # Main app entry point
│   ├── basic_example.dart           # Basic usage examples
│   ├── remote_example.dart          # Remote notification integration
│   ├── advanced_example.dart        # Advanced features
│   └── helpers/
│       ├── notification_helper.dart # Utility methods
│       └── theme_config.dart        # Theme configurations
├── pubspec.yaml                     # Dependencies
└── README.md                        # This file
```

## 🔧 Integration Tips

1. **Initialization**: Always initialize after MaterialApp is built
2. **Context**: Use a valid BuildContext from within the MaterialApp widget tree
3. **Lifecycle**: Handle app state changes appropriately
4. **Performance**: Avoid showing too many notifications simultaneously
5. **User Experience**: Consider notification frequency and importance

## 🐛 Troubleshooting

1. **Notifications not showing**: Verify initialization is called properly
2. **Context errors**: Ensure context is from within MaterialApp
3. **Animation issues**: Check if app is in foreground when showing notifications

## 📄 License

This example project is licensed under the same license as the main package.

## 🤝 Contributing

Feel free to submit issues and contribute to improving these examples!
