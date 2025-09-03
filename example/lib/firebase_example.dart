import 'package:flutter/material.dart';
import 'package:easy_in_app_notify/easy_in_app_notify.dart';
// Uncomment for real Firebase integration:
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

/// Firebase integration examples for FCM notifications
class FirebaseExamplePage extends StatefulWidget {
  const FirebaseExamplePage({super.key});

  @override
  State<FirebaseExamplePage> createState() => _FirebaseExamplePageState();
}

class _FirebaseExamplePageState extends State<FirebaseExamplePage> {
  bool _isFirebaseInitialized = false;
  final String _deviceToken = 'Not available (Firebase not configured)';

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    // Uncomment for real Firebase integration:
    /*
    try {
      await Firebase.initializeApp();
      setState(() {
        _isFirebaseInitialized = true;
      });
      
      // Setup FCM
      await _setupFirebaseMessaging();
    } catch (e) {
      print('Firebase initialization error: $e');
    }
    */

    // For demo purposes, simulate Firebase initialization
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isFirebaseInitialized = true;
    });
  }

  Future<void> _setupFirebaseMessaging() async {
    // Uncomment for real Firebase integration:
    /*
    final messaging = FirebaseMessaging.instance;
    
    // Request permission
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    }
    
    // Get device token
    String? token = await messaging.getToken();
    setState(() {
      _deviceToken = token ?? 'Unable to get token';
    });
    
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
    });
    
    // Handle background messages when app is opened
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleBackgroundMessage(message);
    });
    */
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Firebase Examples'),
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildFirebaseStatus(),
          const SizedBox(height: 24),

          _buildSectionHeader('Simulated FCM Messages'),
          _buildMessageButton(
            title: 'Chat Message',
            description: 'Simulate incoming chat notification',
            icon: Icons.chat,
            color: Colors.green,
            onPressed: () => _simulateChatMessage(),
          ),
          _buildMessageButton(
            title: 'Promotional Message',
            description: 'Simulate promotional notification',
            icon: Icons.local_offer,
            color: Colors.orange,
            onPressed: () => _simulatePromotionalMessage(),
          ),
          _buildMessageButton(
            title: 'Alert Message',
            description: 'Simulate urgent alert notification',
            icon: Icons.warning,
            color: Colors.red,
            onPressed: () => _simulateAlertMessage(),
          ),
          _buildMessageButton(
            title: 'Order Update',
            description: 'Simulate order status notification',
            icon: Icons.shopping_bag,
            color: Colors.blue,
            onPressed: () => _simulateOrderMessage(),
          ),
          _buildMessageButton(
            title: 'News Update',
            description: 'Simulate breaking news notification',
            icon: Icons.newspaper,
            color: Colors.purple,
            onPressed: () => _simulateNewsMessage(),
          ),

          const SizedBox(height: 24),
          _buildSectionHeader('Message Routing Examples'),

          _buildMessageButton(
            title: 'Dynamic Message Routing',
            description: 'Show different notifications based on type',
            icon: Icons.route,
            color: Colors.teal,
            onPressed: () => _demonstrateMessageRouting(),
          ),

          const SizedBox(height: 24),
          _buildFirebaseSetupInstructions(),
        ],
      ),
    ),
  );

  Widget _buildFirebaseStatus() => Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _isFirebaseInitialized ? Icons.check_circle : Icons.error,
                color: _isFirebaseInitialized ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 8),
              Text(
                'Firebase Status',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _isFirebaseInitialized
                ? 'Firebase initialized (Demo Mode)'
                : 'Firebase not initialized',
          ),
          const SizedBox(height: 8),
          const Text(
            'Device Token:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            _deviceToken,
            style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
          ),
        ],
      ),
    ),
  );

  Widget _buildSectionHeader(final String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    ),
  );

  Widget _buildMessageButton({
    required final String title,
    required final String description,
    required final IconData icon,
    required final Color color,
    required final VoidCallback onPressed,
  }) => Card(
    margin: const EdgeInsets.only(bottom: 8),
    child: ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title),
      subtitle: Text(description),
      trailing: const Icon(Icons.send),
      onTap: onPressed,
    ),
  );

  Widget _buildFirebaseSetupInstructions() => Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Real Firebase Setup',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            '1. Add firebase_core and firebase_messaging to pubspec.yaml\n'
            '2. Configure Firebase project in console\n'
            '3. Add google-services.json (Android) and GoogleService-Info.plist (iOS)\n'
            '4. Uncomment Firebase code in this file\n'
            '5. Test with Firebase Console or FCM API',
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => _showFirebaseCodeExample(),
            icon: const Icon(Icons.code),
            label: const Text('View Integration Code'),
          ),
        ],
      ),
    ),
  );

  // Simulate different types of FCM messages
  void _simulateChatMessage() {
    _handleSimulatedMessage({
      'type': 'chat',
      'title': 'New Message from Sarah',
      'body': 'Hey! Are you coming to the meeting today?',
      'userId': '123',
      'chatId': 'chat_456',
    });
  }

  void _simulatePromotionalMessage() {
    _handleSimulatedMessage({
      'type': 'promotion',
      'title': 'Special Offer! 🎉',
      'body': 'Get 50% off on all premium features. Limited time offer!',
      'promoCode': 'SAVE50',
      'validUntil': '2024-12-31',
    });
  }

  void _simulateAlertMessage() {
    _handleSimulatedMessage({
      'type': 'alert',
      'title': 'Security Alert',
      'body': 'Unusual login detected from new device. Please verify.',
      'severity': 'high',
      'actionRequired': 'true',
    });
  }

  void _simulateOrderMessage() {
    _handleSimulatedMessage({
      'type': 'order',
      'title': 'Order Updated',
      'body': 'Your order #12345 has been shipped and is on the way!',
      'orderId': '12345',
      'status': 'shipped',
    });
  }

  void _simulateNewsMessage() {
    _handleSimulatedMessage({
      'type': 'news',
      'title': 'Breaking News',
      'body': 'Major app update released with exciting new features.',
      'category': 'app_updates',
      'priority': 'medium',
    });
  }

  void _demonstrateMessageRouting() {
    final messageTypes = ['chat', 'promotion', 'alert', 'order', 'news'];
    final randomType =
        messageTypes[DateTime.now().millisecond % messageTypes.length];

    switch (randomType) {
      case 'chat':
        _simulateChatMessage();
        break;
      case 'promotion':
        _simulatePromotionalMessage();
        break;
      case 'alert':
        _simulateAlertMessage();
        break;
      case 'order':
        _simulateOrderMessage();
        break;
      case 'news':
        _simulateNewsMessage();
        break;
    }
  }

  void _handleSimulatedMessage(final Map<String, dynamic> data) {
    final messageType = data['type'] as String;
    final title = data['title'] as String;
    final body = data['body'] as String;

    switch (messageType) {
      case 'chat':
        EasyInAppNotify.show(
          content: EasyInAppNotifyContent(
            title: title,
            message: body,
            icon: Icons.chat,
            trailingText: 'Chat',
          ),
          theme: const EasyInAppNotifyTheme(color: Colors.green),
          option: const EasyInAppNotifyOption(duration: 6),
        );
        break;

      case 'promotion':
        EasyInAppNotify.show(
          content: EasyInAppNotifyContent(
            title: title,
            message: body,
            icon: Icons.local_offer,
            trailingText: 'Limited Time',
          ),
          theme: const EasyInAppNotifyTheme(color: Colors.orange),
          option: const EasyInAppNotifyOption(duration: 8),
        );
        break;

      case 'alert':
        EasyInAppNotify.show(
          content: EasyInAppNotifyContent(
            title: title,
            message: body,
            icon: Icons.warning,
            trailingText: 'Urgent',
          ),
          theme: const EasyInAppNotifyTheme(color: Colors.red, elevation: 12),
          option: const EasyInAppNotifyOption(
            duration: 10,
            swipeToDismiss: false, // Important alerts can't be swiped away
          ),
        );
        break;

      case 'order':
        EasyInAppNotify.show(
          content: EasyInAppNotifyContent(
            title: title,
            message: body,
            icon: Icons.shopping_bag,
            trailingText: 'Order',
          ),
          theme: const EasyInAppNotifyTheme(color: Colors.blue),
        );
        break;

      case 'news':
        EasyInAppNotify.show(
          content: EasyInAppNotifyContent(
            title: title,
            message: body,
            icon: Icons.newspaper,
            trailingText: 'News',
          ),
          theme: const EasyInAppNotifyTheme(color: Colors.purple),
        );
        break;

      default:
        EasyInAppNotify.show(
          content: EasyInAppNotifyContent(
            title: title,
            message: body,
            icon: Icons.notifications,
          ),
        );
    }
  }

  void _showFirebaseCodeExample() {
    showDialog(
      context: context,
      builder: (final context) => AlertDialog(
        title: const Text('Firebase Integration Code'),
        content: const SingleChildScrollView(
          child: Text('''
// Initialize Firebase
await Firebase.initializeApp();

// Setup FCM
final messaging = FirebaseMessaging.instance;

// Request permission
await messaging.requestPermission();

// Handle foreground messages
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  EasyInAppNotify.show(
    content: EasyInAppNotifyContent(
      title: message.notification?.title ?? "New Message",
      message: message.notification?.body ?? "",
      icon: Icons.notifications,
    ),
  );
});

// Handle message routing
void handleMessage(RemoteMessage message) {
  String? type = message.data['type'];
  
  switch (type) {
    case 'chat':
      // Show chat notification
      break;
    case 'promotion':
      // Show promotional notification
      break;
    // Add more cases...
  }
}
'''),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Uncomment for real Firebase integration:
  /*
  void _handleForegroundMessage(RemoteMessage message) {
    print('Foreground message: ${message.messageId}');
    
    // Extract message data
    String? messageType = message.data['type'];
    String title = message.notification?.title ?? 'New Message';
    String body = message.notification?.body ?? '';
    
    // Route message based on type
    _routeFirebaseMessage(messageType, title, body, message.data);
  }
  
  void _handleBackgroundMessage(RemoteMessage message) {
    print('Background message opened: ${message.messageId}');
    // Handle background message tap
  }
  
  void _routeFirebaseMessage(String? type, String title, String body, Map<String, dynamic> data) {
    switch (type) {
      case 'chat':
        EasyInAppNotify.show(
          content: EasyInAppNotifyContent(
            title: title,
            message: body,
            icon: Icons.chat,
            trailingText: "Chat",
          ),
          theme: const EasyInAppNotifyTheme(color: Colors.green),
        );
        break;
        
      // Add more message types...
      
      default:
        EasyInAppNotify.show(
          content: EasyInAppNotifyContent(
            title: title,
            message: body,
            icon: Icons.notifications,
          ),
        );
    }
  }
  */
}
