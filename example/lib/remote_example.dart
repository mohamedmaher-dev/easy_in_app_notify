import 'package:flutter/material.dart';
import 'package:easy_in_app_notify/easy_in_app_notify.dart';
import 'helpers/notification_helper.dart';

/// Remote notification examples for simulated push notifications
class RemoteExamplePage extends StatefulWidget {
  const RemoteExamplePage({super.key});

  @override
  State<RemoteExamplePage> createState() => _RemoteExamplePageState();
}

class _RemoteExamplePageState extends State<RemoteExamplePage> {
  bool _isServiceInitialized = false;
  final String _deviceToken = 'demo-device-token-12345';

  @override
  void initState() {
    super.initState();
    _initializeService();
  }

  Future<void> _initializeService() async {
    // Simulate service initialization
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isServiceInitialized = true;
    });
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Remote Examples'),
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildServiceStatus(),
          const SizedBox(height: 20),
          _buildSectionHeader('Simulated Remote Messages'),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
              children: [
                _buildNotificationCard(
                  'Chat Message',
                  Icons.chat,
                  Colors.green,
                  () => _simulateRemoteMessage(
                    'chat',
                    'New Message',
                    'You have a new chat message',
                  ),
                ),
                _buildNotificationCard(
                  'Promotion',
                  Icons.local_offer,
                  Colors.orange,
                  () => _simulateRemoteMessage(
                    'promotion',
                    'Special Offer!',
                    'Limited time discount available',
                  ),
                ),
                _buildNotificationCard(
                  'Alert',
                  Icons.warning,
                  Colors.red,
                  () => _simulateRemoteMessage(
                    'alert',
                    'Important Alert',
                    'System maintenance scheduled',
                  ),
                ),
                _buildNotificationCard(
                  'News Update',
                  Icons.newspaper,
                  Colors.blue,
                  () => _simulateRemoteMessage(
                    'news',
                    'Breaking News',
                    'Latest updates available',
                  ),
                ),
                _buildNotificationCard(
                  'Reminder',
                  Icons.alarm,
                  Colors.purple,
                  () => _simulateRemoteMessage(
                    'reminder',
                    'Don\'t Forget!',
                    'You have a meeting in 15 minutes',
                  ),
                ),
                _buildNotificationCard(
                  'System',
                  Icons.settings,
                  Colors.grey,
                  () => _simulateRemoteMessage(
                    'system',
                    'System Update',
                    'App updated to latest version',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildSetupInstructions(),
        ],
      ),
    ),
  );

  Widget _buildServiceStatus() => Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                _isServiceInitialized ? Icons.check_circle : Icons.error,
                color: _isServiceInitialized ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 8),
              Text(
                'Service Status',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _isServiceInitialized
                ? 'Remote notification service ready'
                : 'Service not initialized',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Device Token: $_deviceToken',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildSectionHeader(final String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.orange,
      ),
    ),
  );

  Widget _buildNotificationCard(
    final String title,
    final IconData icon,
    final Color color,
    final VoidCallback onTap,
  ) => Card(
    elevation: 2,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );

  Widget _buildSetupInstructions() => Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Integration Instructions',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            '1. Initialize EasyInAppNotify in your app\n'
            '2. Set up your remote notification service\n'
            '3. Route incoming messages to EasyInAppNotify\n'
            '4. Customize notification appearance and behavior',
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => _showIntegrationCodeExample(),
            child: const Text('View Integration Code'),
          ),
        ],
      ),
    ),
  );

  // Simulate different types of remote messages
  void _simulateRemoteMessage(
    final String type,
    final String title,
    final String body,
  ) {
    final Map<String, dynamic> data = {
      'type': type,
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
    };

    _routeRemoteMessage(type, title, body, data);
  }

  void _routeRemoteMessage(
    final String? type,
    final String title,
    final String body,
    final Map<String, dynamic> data,
  ) {
    switch (type) {
      case 'chat':
        NotificationHelper.showSuccess(title, body);
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
          theme: const EasyInAppNotifyTheme(color: Colors.red),
          option: const EasyInAppNotifyOption(
            duration: 10,
            swipeToDismiss: false, // Prevent dismissal for important alerts
          ),
        );
        break;

      case 'news':
        EasyInAppNotify.show(
          content: EasyInAppNotifyContent(
            title: title,
            message: body,
            icon: Icons.newspaper,
            trailingText: 'Breaking',
          ),
          theme: const EasyInAppNotifyTheme(color: Colors.blue),
        );
        break;

      case 'reminder':
        EasyInAppNotify.show(
          content: EasyInAppNotifyContent(
            title: title,
            message: body,
            icon: Icons.alarm,
            trailingText: 'Reminder',
          ),
          theme: const EasyInAppNotifyTheme(color: Colors.purple),
          option: const EasyInAppNotifyOption(),
        );
        break;

      case 'system':
        EasyInAppNotify.show(
          content: EasyInAppNotifyContent(
            title: title,
            message: body,
            icon: Icons.settings,
            trailingText: 'System',
          ),
          theme: const EasyInAppNotifyTheme(color: Colors.grey),
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

  void _showIntegrationCodeExample() {
    showDialog(
      context: context,
      builder: (final context) => AlertDialog(
        title: const Text('Integration Code Example'),
        content: const SingleChildScrollView(
          child: Text('''
// Initialize EasyInAppNotify
EasyInAppNotify.init(context);

// Handle incoming remote notifications
void handleRemoteMessage(Map<String, dynamic> message) {
  EasyInAppNotify.show(
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

// Example with different message types
void routeMessage(String type, String title, String body) {
  switch (type) {
    case 'chat':
      // Show chat-style notification
      break;
    case 'alert':
      // Show urgent alert
      break;
    default:
      // Show default notification
  }
}
'''),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
