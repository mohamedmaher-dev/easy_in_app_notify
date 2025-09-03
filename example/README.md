# Easy In-App Notify Examples 📱🔥

This directory contains comprehensive examples demonstrating how to use the Easy In-App Notify package with Firebase Cloud Messaging (FCM) integration.

## 📁 Examples Included

### 1. **Basic Usage** (`lib/basic_example.dart`)
- Simple notification display
- Basic initialization
- Different notification types

### 2. **Firebase Integration** (`lib/firebase_example.dart`)
- Complete FCM integration
- Foreground message handling
- Background to foreground transition

### 3. **Advanced Usage** (`lib/advanced_example.dart`)
- Custom notification types
- Message routing based on data
- Complex styling and theming

### 4. **Helper Classes** (`lib/helpers/`)
- Notification helper utilities
- Firebase message handler
- Theme configurations

## 🚀 Running the Examples

### Prerequisites

1. **Firebase Setup** (for Firebase examples):
   ```bash
   # Install Firebase CLI
   npm install -g firebase-tools
   
   # Login to Firebase
   firebase login
   
   # Create Firebase project or use existing one
   ```

2. **Flutter Setup**:
   ```bash
   # Get dependencies
   flutter pub get
   
   # Run the example app
   flutter run
   ```

### Firebase Configuration

1. **Android Setup**:
   - Add your `google-services.json` to `android/app/`
   - Configure `android/app/build.gradle`

2. **iOS Setup**:
   - Add your `GoogleService-Info.plist` to `ios/Runner/`
   - Configure `ios/Runner/Info.plist`

## 📱 Example Scenarios

### Basic Notifications
- Success messages
- Error alerts  
- Information updates
- Warning notifications

### Firebase Integration
- Chat message notifications
- Promotional messages
- System alerts
- Order updates
- News notifications

### Advanced Features
- Custom animations
- Themed notifications
- Progress indicators
- User interactions

## 🎯 Key Learning Points

### 1. **Proper Initialization**
```dart
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      EasyInAppNotify.init(context);
    });
  }
}
```

### 2. **Firebase Message Handling**
```dart
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  EasyInAppNotify.show(
    content: EasyInAppNotifyContent(
      title: message.notification?.title ?? "New Message",
      message: message.notification?.body ?? "",
    ),
  );
});
```

### 3. **Custom Styling**
```dart
EasyInAppNotify.show(
  content: EasyInAppNotifyContent(/* ... */),
  theme: EasyInAppNotifyTheme(
    color: Colors.blue,
    elevation: 8,
    radius: 12,
  ),
  option: EasyInAppNotifyOption(
    duration: 5,
    showProgressBar: true,
  ),
);
```

## 🔧 Testing

### Test Firebase Messaging

1. **Using Firebase Console**:
   - Go to Firebase Console → Cloud Messaging
   - Send test message to your device token

2. **Using FCM API**:
   ```bash
   curl -X POST https://fcm.googleapis.com/fcm/send \
     -H "Authorization: key=YOUR_SERVER_KEY" \
     -H "Content-Type: application/json" \
     -d '{
       "to": "DEVICE_TOKEN",
       "notification": {
         "title": "Test Notification",
         "body": "This is a test message"
       },
       "data": {
         "type": "chat",
         "userId": "123"
       }
     }'
   ```

## 📝 Code Structure

```
example/
├── lib/
│   ├── main.dart              # Main example app
│   ├── basic_example.dart     # Basic usage examples
│   ├── firebase_example.dart  # Firebase integration
│   ├── advanced_example.dart  # Advanced features
│   └── helpers/
│       ├── notification_helper.dart  # Utility functions
│       ├── firebase_handler.dart     # FCM message handler
│       └── theme_config.dart         # Theme configurations
├── android/
│   └── app/
│       └── google-services.json     # Firebase config (add your own)
├── ios/
│   └── Runner/
│       └── GoogleService-Info.plist # Firebase config (add your own)
└── pubspec.yaml
```

## 🚨 Important Notes

1. **Firebase Setup Required**: Most examples require Firebase project setup
2. **Platform Configuration**: Don't forget to configure both Android and iOS
3. **Permissions**: Ensure notification permissions are granted
4. **Testing**: Test on real devices for best results

## 🆘 Troubleshooting

### Common Issues

1. **Notifications not showing**: Check if `init()` is called correctly
2. **Firebase not working**: Verify `google-services.json` and `GoogleService-Info.plist`
3. **Permissions denied**: Request notification permissions in your app
4. **Overlay not appearing**: Ensure context is from within MaterialApp

### Debug Tips

- Use `flutter run --verbose` for detailed logs
- Check Firebase console for message delivery status
- Verify device token registration
- Test with simple notifications first

---

Happy coding with Easy In-App Notify! 🚀
