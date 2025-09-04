import 'package:flutter/material.dart';
import 'package:easy_in_app_notify/easy_in_app_notify.dart';
import 'remote_example.dart';
import 'basic_example.dart';
import 'advanced_example.dart';
import 'fcm_example.dart';

void main() {
  runApp(const MyApp());
}

/// Main example app demonstrating Easy In-App Notify package
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp(
    title: 'Easy In-App Notify Examples',
    theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
    home: const ExampleHomePage(),
  );
}

/// Home page showing different example categories
class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  // No initialization needed! EasyInAppNotify works automatically

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Easy In-App Notify Examples'),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(
                    Icons.notifications_active,
                    size: 48,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Easy In-App Notify',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Text(
                    'Comprehensive Integration Examples',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Quick Demo
          _buildQuickDemo(),
          const SizedBox(height: 24),

          // Example Categories
          Expanded(
            child: ListView(
              children: [
                _buildExampleCard(
                  title: 'Basic Examples',
                  description:
                      'Simple notifications with different types and styling',
                  icon: Icons.star,
                  color: Colors.green,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (final context) => const BasicExamplePage(),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _buildExampleCard(
                  title: 'Remote Integration',
                  description:
                      'Remote message handling and foreground notifications',
                  icon: Icons.cloud,
                  color: Colors.orange,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (final context) => const RemoteExamplePage(),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _buildExampleCard(
                  title: 'Advanced Features',
                  description:
                      'Custom themes, animations, and complex scenarios',
                  icon: Icons.settings,
                  color: Colors.purple,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (final context) => const AdvancedExamplePage(),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _buildExampleCard(
                  title: 'FCM Integration',
                  description: 'Firebase Cloud Messaging without BuildContext',
                  icon: Icons.cloud_queue,
                  color: Colors.blue,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (final context) => const FCMExamplePage(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildQuickDemo() => Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Quick Demo', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              EasyInAppNotify.show(
                context,
                content: const EasyInAppNotifyContent(
                  title: 'Welcome! 👋',
                  message:
                      'This is your first Easy In-App Notify notification!',
                  icon: Icons.celebration,
                  trailingText: 'Demo',
                ),
                theme: const EasyInAppNotifyTheme(
                  color: Colors.blue,
                  elevation: 8,
                ),
              );
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Show Demo Notification'),
          ),
        ],
      ),
    ),
  );

  Widget _buildExampleCard({
    required final String title,
    required final String description,
    required final IconData icon,
    required final Color color,
    required final VoidCallback onTap,
  }) => Card(
    child: InkWell(
      onTap: onTap,
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
              child: Icon(icon, color: color, size: 32),
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
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    ),
  );
}
