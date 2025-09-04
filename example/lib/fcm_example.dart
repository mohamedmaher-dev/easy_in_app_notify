import 'package:flutter/material.dart';
import 'package:easy_in_app_notify/easy_in_app_notify.dart';

/// Example showing how to integrate EasyInAppNotify with Firebase Cloud Messaging (FCM)
/// This demonstrates handling FCM messages without direct BuildContext access
class FCMExamplePage extends StatefulWidget {
  const FCMExamplePage({super.key});

  @override
  State<FCMExamplePage> createState() => _FCMExamplePageState();
}

class _FCMExamplePageState extends State<FCMExamplePage> {
  @override
  void initState() {
    super.initState();
    // Setup FCM service with navigator key
    FCMService.setNavigatorKey(context);
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('FCM Integration Example'),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildInfoCard(),
          const SizedBox(height: 24),
          _buildSimulationSection(),
          const SizedBox(height: 24),
          _buildIntegrationCodeExample(),
        ],
      ),
    ),
  );

  Widget _buildInfoCard() => Card(
    color: Colors.blue.shade50,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.cloud_queue, color: Colors.blue.shade700, size: 32),
              const SizedBox(width: 12),
              Text(
                'FCM Integration',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'This example shows how to use EasyInAppNotify with Firebase Cloud Messaging '
            'when you don\'t have direct access to BuildContext in FCM handlers.',
          ),
          const SizedBox(height: 8),
          const Text(
            '🔑 Key Pattern: Use Navigator Key to access context from FCM handlers',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );

  Widget _buildSimulationSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Simulate FCM Messages',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const SizedBox(height: 16),
      _buildSimulationButton(
        title: 'Chat Message',
        description: 'Simulate FCM chat notification',
        icon: Icons.chat,
        color: Colors.green,
        onPressed: () => FCMService.simulateChatMessage(),
      ),
      const SizedBox(height: 12),
      _buildSimulationButton(
        title: 'Order Update',
        description: 'Simulate FCM order status update',
        icon: Icons.shopping_cart,
        color: Colors.orange,
        onPressed: () => FCMService.simulateOrderUpdate(),
      ),
      const SizedBox(height: 12),
      _buildSimulationButton(
        title: 'Promotion',
        description: 'Simulate FCM promotional notification',
        icon: Icons.local_offer,
        color: Colors.purple,
        onPressed: () => FCMService.simulatePromotion(),
      ),
      const SizedBox(height: 12),
      _buildSimulationButton(
        title: 'System Alert',
        description: 'Simulate FCM system notification',
        icon: Icons.notifications_active,
        color: Colors.red,
        onPressed: () => FCMService.simulateSystemAlert(),
      ),
    ],
  );

  Widget _buildSimulationButton({
    required final String title,
    required final String description,
    required final IconData icon,
    required final Color color,
    required final VoidCallback onPressed,
  }) => Card(
    child: InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const Icon(Icons.play_arrow, size: 20),
          ],
        ),
      ),
    ),
  );

  Widget _buildIntegrationCodeExample() => Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Integration Code',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Text('''// 1. Create FCM Service with Navigator Key
class FCMService {
  static GlobalKey<NavigatorState>? _navigatorKey;
  
  static void setNavigatorKey(BuildContext context) {
    _navigatorKey = Navigator.of(context).widget.key 
        as GlobalKey<NavigatorState>?;
  }
  
  static void handleFCMMessage(RemoteMessage message) {
    final context = _navigatorKey?.currentContext;
    if (context != null) {
      EasyInAppNotify.show(
        context,
        content: EasyInAppNotifyContent(
          title: message.notification?.title ?? 'FCM',
          message: message.notification?.body ?? '',
        ),
      );
    }
  }
}

// 2. Initialize in main()
void main() async {
  await Firebase.initializeApp();
  FirebaseMessaging.onMessage.listen(FCMService.handleFCMMessage);
  runApp(MyApp());
}

// 3. Setup in your app
MaterialApp(
  navigatorKey: GlobalKey<NavigatorState>(),
  home: MyHomePage(),
)''', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

/// Simulated FCM Service for demonstration purposes
/// In real apps, this would be replaced with actual Firebase messaging
class FCMService {
  static GlobalKey<NavigatorState>? _navigatorKey;
  static int _messageId = 1;

  static void setNavigatorKey(final BuildContext context) {
    // In a real app, you'd use the actual navigator key from MaterialApp
    _navigatorKey =
        Navigator.of(context).widget.key as GlobalKey<NavigatorState>?;
  }

  static void simulateChatMessage() {
    final context = _getContext();
    if (context != null) {
      EasyInAppNotify.show(
        context,
        content: const EasyInAppNotifyContent(
          title: 'New Message from Sarah',
          message: 'Hey! Are you free for coffee later?',
          icon: Icons.chat,
          trailingText: 'Just now',
        ),
        theme: const EasyInAppNotifyTheme(color: Colors.green),
        option: const EasyInAppNotifyOption(duration: 6),
      );
    }
  }

  static void simulateOrderUpdate() {
    final context = _getContext();
    if (context != null) {
      final statuses = ['confirmed', 'shipped', 'delivered'];
      final status = statuses[_messageId % statuses.length];

      EasyInAppNotify.show(
        context,
        content: EasyInAppNotifyContent(
          title: 'Order ${status.toUpperCase()}',
          message: 'Your order #${1000 + _messageId} has been $status.',
          icon: _getOrderIcon(status),
          trailingText: '#${1000 + _messageId}',
        ),
        theme: EasyInAppNotifyTheme(color: _getOrderColor(status)),
        option: const EasyInAppNotifyOption(),
      );
      _messageId++;
    }
  }

  static void simulatePromotion() {
    final context = _getContext();
    if (context != null) {
      final discounts = ['20%', '30%', '50%'];
      final discount = discounts[_messageId % discounts.length];

      EasyInAppNotify.show(
        context,
        content: EasyInAppNotifyContent(
          title: 'Special Offer - $discount OFF!',
          message: 'Limited time offer on all items. Don\'t miss out!',
          icon: Icons.local_offer,
          trailingText: 'SAVE$discount',
        ),
        theme: const EasyInAppNotifyTheme(color: Colors.purple, elevation: 10),
        option: const EasyInAppNotifyOption(duration: 8),
      );
      _messageId++;
    }
  }

  static void simulateSystemAlert() {
    final context = _getContext();
    if (context != null) {
      final alerts = [
        'Security update available',
        'Maintenance scheduled',
        'New features released',
      ];
      final alert = alerts[_messageId % alerts.length];

      EasyInAppNotify.show(
        context,
        content: EasyInAppNotifyContent(
          title: 'System Alert',
          message: alert,
          icon: Icons.notifications_active,
          trailingText: 'SYSTEM',
        ),
        theme: const EasyInAppNotifyTheme(color: Colors.red),
        option: const EasyInAppNotifyOption(
          duration: 7,
          swipeToDismiss: false, // Important system alerts
        ),
      );
      _messageId++;
    }
  }

  static BuildContext? _getContext() => _navigatorKey?.currentContext;

  static IconData _getOrderIcon(final String status) {
    switch (status) {
      case 'confirmed':
        return Icons.check_circle;
      case 'shipped':
        return Icons.local_shipping;
      case 'delivered':
        return Icons.done_all;
      default:
        return Icons.shopping_cart;
    }
  }

  static Color _getOrderColor(final String status) {
    switch (status) {
      case 'confirmed':
        return Colors.green;
      case 'shipped':
        return Colors.blue;
      case 'delivered':
        return Colors.purple;
      default:
        return Colors.orange;
    }
  }
}
