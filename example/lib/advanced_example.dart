import 'package:flutter/material.dart';
import 'package:easy_in_app_notify/easy_in_app_notify.dart';
import 'helpers/notification_helper.dart';
import 'helpers/theme_config.dart';

/// Advanced examples demonstrating complex scenarios and custom implementations
class AdvancedExamplePage extends StatefulWidget {
  const AdvancedExamplePage({super.key});

  @override
  State<AdvancedExamplePage> createState() => _AdvancedExamplePageState();
}

class _AdvancedExamplePageState extends State<AdvancedExamplePage> {
  int _notificationCount = 0;
  NotificationType _selectedType = NotificationType.info;

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Advanced Examples'),
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildNotificationCounter(),
          const SizedBox(height: 24),

          _buildSectionHeader('Helper Class Examples'),
          _buildHelperButton(
            title: 'Success Helper',
            description: 'Using NotificationHelper.showSuccess()',
            icon: Icons.check_circle,
            color: Colors.green,
            onPressed: () => NotificationHelper.showSuccess(
              'Operation Successful',
              'Your data has been saved successfully.',
            ),
          ),
          _buildHelperButton(
            title: 'Error Helper',
            description: 'Using NotificationHelper.showError()',
            icon: Icons.error,
            color: Colors.red,
            onPressed: () => NotificationHelper.showError(
              'Operation Failed',
              'Unable to save data. Please check your connection.',
            ),
          ),
          _buildHelperButton(
            title: 'Loading Helper',
            description: 'Using NotificationHelper.showLoading()',
            icon: Icons.hourglass_empty,
            color: Colors.blue,
            onPressed: () => NotificationHelper.showLoading(
              'Processing Request',
              'Please wait while we process your data...',
            ),
          ),

          const SizedBox(height: 24),
          _buildSectionHeader('Theme Configurations'),

          _buildThemeButton(
            title: 'Corporate Theme',
            description: 'Professional business-style notification',
            theme: ThemeConfig.corporate,
            onPressed: () => _showThemedNotification(
              'Corporate Update',
              'Quarterly reports are now available for review.',
              ThemeConfig.corporate,
            ),
          ),
          _buildThemeButton(
            title: 'Gaming Theme',
            description: 'Fun gaming-style notification',
            theme: ThemeConfig.gaming,
            onPressed: () => _showThemedNotification(
              'Achievement Unlocked! 🏆',
              'You have reached level 25! Keep going!',
              ThemeConfig.gaming,
            ),
          ),
          _buildThemeButton(
            title: 'Minimal Theme',
            description: 'Clean minimal-style notification',
            theme: ThemeConfig.minimal,
            onPressed: () => _showThemedNotification(
              'Update Available',
              'A new version is ready to install.',
              ThemeConfig.minimal,
            ),
          ),

          const SizedBox(height: 24),
          _buildSectionHeader('Interactive Examples'),

          _buildCustomizationCard(),
          const SizedBox(height: 16),
          _buildSequentialNotifications(),
          const SizedBox(height: 16),
          _buildConditionalNotifications(),
        ],
      ),
    ),
  );

  Widget _buildNotificationCounter() => Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Notifications Shown',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            '$_notificationCount',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => setState(() => _notificationCount = 0),
            child: const Text('Reset Counter'),
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

  Widget _buildHelperButton({
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
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title),
      subtitle: Text(description),
      trailing: const Icon(Icons.play_arrow),
      onTap: () {
        onPressed();
        _incrementCounter();
      },
    ),
  );

  Widget _buildThemeButton({
    required final String title,
    required final String description,
    required final EasyInAppNotifyTheme theme,
    required final VoidCallback onPressed,
  }) => Card(
    margin: const EdgeInsets.only(bottom: 8),
    child: ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (theme.color ?? Colors.blue).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(theme.radius),
        ),
        child: Icon(
          Icons.palette,
          color: theme.color ?? Colors.blue,
          size: theme.iconSize,
        ),
      ),
      title: Text(title),
      subtitle: Text(description),
      trailing: const Icon(Icons.style),
      onTap: () {
        onPressed();
        _incrementCounter();
      },
    ),
  );

  Widget _buildCustomizationCard() => Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Dynamic Customization',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<NotificationType>(
            initialValue: _selectedType,
            decoration: const InputDecoration(
              labelText: 'Notification Type',
              border: OutlineInputBorder(),
            ),
            items: NotificationType.values
                .map(
                  (final type) => DropdownMenuItem(
                    value: type,
                    child: Text(type.name.toUpperCase()),
                  ),
                )
                .toList(),
            onChanged: (final value) {
              setState(() {
                _selectedType = value!;
              });
            },
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => _showDynamicNotification(),
            icon: const Icon(Icons.dynamic_form),
            label: const Text('Show Dynamic Notification'),
          ),
        ],
      ),
    ),
  );

  Widget _buildSequentialNotifications() => Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Sequential Notifications',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'Show multiple notifications with delays (demonstrates single notification policy)',
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => _showSequentialNotifications(),
            icon: const Icon(Icons.queue),
            label: const Text('Start Sequence'),
          ),
        ],
      ),
    ),
  );

  Widget _buildConditionalNotifications() => Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Conditional Logic',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text('Show different notifications based on current time'),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => _showTimeBasedNotification(),
            icon: const Icon(Icons.access_time),
            label: const Text('Time-Based Notification'),
          ),
        ],
      ),
    ),
  );

  void _incrementCounter() {
    setState(() {
      _notificationCount++;
    });
  }

  void _showThemedNotification(
    final String title,
    final String message,
    final EasyInAppNotifyTheme theme,
  ) {
    EasyInAppNotify.show(
      content: EasyInAppNotifyContent(
        title: title,
        message: message,
        icon: Icons.style,
      ),
      theme: theme,
    );
  }

  void _showDynamicNotification() {
    NotificationHelper.showTypedNotification(
      _selectedType,
      'Dynamic Notification',
      'This notification was created based on your selection: ${_selectedType.name}',
    );
    _incrementCounter();
  }

  void _showSequentialNotifications() {
    // Show first notification immediately
    NotificationHelper.showInfo(
      'Sequence Started',
      'This is the first notification in the sequence.',
    );
    _incrementCounter();

    // Show second notification after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      NotificationHelper.showWarning(
        'Sequence Continuing',
        'This is the second notification (previous one was replaced).',
      );
      _incrementCounter();
    });

    // Show third notification after 6 seconds
    Future.delayed(const Duration(seconds: 6), () {
      NotificationHelper.showSuccess(
        'Sequence Complete',
        'This is the final notification in the sequence.',
      );
      _incrementCounter();
    });
  }

  void _showTimeBasedNotification() {
    final now = DateTime.now();
    final hour = now.hour;

    String title;
    String message;
    NotificationType type;

    if (hour >= 5 && hour < 12) {
      // Morning
      title = 'Good Morning! ☀️';
      message = 'Start your day with a fresh perspective.';
      type = NotificationType.info;
    } else if (hour >= 12 && hour < 17) {
      // Afternoon
      title = 'Good Afternoon! 🌤️';
      message = 'Hope you\'re having a productive day.';
      type = NotificationType.success;
    } else if (hour >= 17 && hour < 21) {
      // Evening
      title = 'Good Evening! 🌅';
      message = 'Time to wind down and relax.';
      type = NotificationType.warning;
    } else {
      // Night
      title = 'Good Night! 🌙';
      message = 'It\'s late! Consider getting some rest.';
      type = NotificationType.error;
    }

    NotificationHelper.showTypedNotification(type, title, message);
    _incrementCounter();
  }
}
