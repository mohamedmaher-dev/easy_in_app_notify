/// Example app demonstrating Easy In-App Notify v2.3.0 features
///
/// This example showcases:
/// - Custom widget notifications using Card
/// - Centralized auto-dismiss system
/// - Duration validation (must be > 0)
/// - Universal dismiss support
///
/// Version: 2.3.0
/// Features: Centralized Auto-Dismiss, Universal Dismiss Support, Duration Validation
library;

import 'package:easy_in_app_notify/easy_in_app_notify.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy In-App Notify Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Easy In-App Notify v2.3.0'),
    );
  }
}

/// Demo page showcasing Easy In-App Notify v2.3.0 features
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '📱 Easy In-App Notify Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Tap the button below to show a custom notification',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              '✨ Features v2.3.0:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(
              '• Centralized Auto-Dismiss\n• Universal Dismiss Support\n• Duration Validation',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Demonstrate v2.3.0 features:
          // - Custom Card widget notification
          // - Centralized auto-dismiss system
          // - Duration validation (must be > 0)
          // - Universal dismiss support
          EasyInAppNotify.show(
            context,
            view: Card(
              margin: const EdgeInsets.all(16),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'v2.3.0 Demo Notification',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Auto-dismiss in 3 seconds',
                      style: TextStyle(fontSize: 14),
                    ),
                    const Text(
                      'Universal dismiss support ✨',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            option: const EasyInAppNotifyOption(
              duration: 3, // Duration validation: must be > 0
              showProgressBar: false,
              swipeToDismiss: true,
            ),
            onDismissed: () {
              debugPrint('📱 Notification dismissed via centralized system');
            },
          );
        },
        tooltip: 'Show v2.3.0 Demo',
        label: const Text('Show Notification'),
        icon: const Icon(Icons.notifications_active),
      ),
    );
  }
}
