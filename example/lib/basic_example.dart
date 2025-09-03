import 'package:flutter/material.dart';
import 'package:easy_in_app_notify/easy_in_app_notify.dart';

/// Basic examples demonstrating different notification types and styling
class BasicExamplePage extends StatelessWidget {
  const BasicExamplePage({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Basic Examples'),
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildSectionHeader('Message Types'),
          _buildNotificationButton(
            title: 'Success Message',
            description: 'Green theme for success notifications',
            icon: Icons.check_circle,
            color: Colors.green,
            onPressed: () => _showSuccessNotification(),
          ),
          _buildNotificationButton(
            title: 'Error Message',
            description: 'Red theme for error notifications',
            icon: Icons.error,
            color: Colors.red,
            onPressed: () => _showErrorNotification(),
          ),
          _buildNotificationButton(
            title: 'Warning Message',
            description: 'Orange theme for warning notifications',
            icon: Icons.warning,
            color: Colors.orange,
            onPressed: () => _showWarningNotification(),
          ),
          _buildNotificationButton(
            title: 'Info Message',
            description: 'Blue theme for informational notifications',
            icon: Icons.info,
            color: Colors.blue,
            onPressed: () => _showInfoNotification(),
          ),

          const SizedBox(height: 24),
          _buildSectionHeader('Customization Options'),

          _buildNotificationButton(
            title: 'Custom Duration',
            description: 'Notification that stays for 8 seconds',
            icon: Icons.timer,
            color: Colors.purple,
            onPressed: () => _showCustomDurationNotification(),
          ),
          _buildNotificationButton(
            title: 'No Progress Bar',
            description: 'Notification without countdown progress',
            icon: Icons.notifications_off,
            color: Colors.grey,
            onPressed: () => _showNoProgressNotification(),
          ),
          _buildNotificationButton(
            title: 'No Swipe Dismiss',
            description: 'Notification that cannot be swiped away',
            icon: Icons.lock,
            color: Colors.brown,
            onPressed: () => _showNoSwipeNotification(),
          ),
          _buildNotificationButton(
            title: 'Custom Styling',
            description: 'Notification with custom elevation and radius',
            icon: Icons.style,
            color: Colors.teal,
            onPressed: () => _showCustomStyledNotification(),
          ),

          const SizedBox(height: 24),
          _buildSectionHeader('Content Variations'),

          _buildNotificationButton(
            title: 'With Trailing Text',
            description: 'Notification with timestamp or action hint',
            icon: Icons.access_time,
            color: Colors.indigo,
            onPressed: () => _showTrailingTextNotification(),
          ),
          _buildNotificationButton(
            title: 'Long Message',
            description: 'Notification with longer content',
            icon: Icons.text_fields,
            color: Colors.cyan,
            onPressed: () => _showLongMessageNotification(),
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

  Widget _buildNotificationButton({
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
      trailing: const Icon(Icons.play_arrow),
      onTap: onPressed,
    ),
  );

  void _showSuccessNotification() {
    EasyInAppNotify.show(
      content: const EasyInAppNotifyContent(
        title: 'Success! ✅',
        message: 'Your action was completed successfully.',
        icon: Icons.check_circle,
      ),
      theme: const EasyInAppNotifyTheme(color: Colors.green),
    );
  }

  void _showErrorNotification() {
    EasyInAppNotify.show(
      content: const EasyInAppNotifyContent(
        title: 'Error Occurred ❌',
        message: 'Something went wrong. Please try again.',
        icon: Icons.error,
      ),
      theme: const EasyInAppNotifyTheme(color: Colors.red),
    );
  }

  void _showWarningNotification() {
    EasyInAppNotify.show(
      content: const EasyInAppNotifyContent(
        title: 'Warning ⚠️',
        message: 'Please check your internet connection.',
        icon: Icons.warning,
      ),
      theme: const EasyInAppNotifyTheme(color: Colors.orange),
    );
  }

  void _showInfoNotification() {
    EasyInAppNotify.show(
      content: const EasyInAppNotifyContent(
        title: 'Information ℹ️',
        message: 'New features are available in settings.',
        icon: Icons.info,
      ),
      theme: const EasyInAppNotifyTheme(color: Colors.blue),
    );
  }

  void _showCustomDurationNotification() {
    EasyInAppNotify.show(
      content: const EasyInAppNotifyContent(
        title: 'Long Duration',
        message: 'This notification will stay for 8 seconds.',
        icon: Icons.timer,
      ),
      option: const EasyInAppNotifyOption(
        duration: 8, // 8 seconds instead of default 5
      ),
      theme: const EasyInAppNotifyTheme(color: Colors.purple),
    );
  }

  void _showNoProgressNotification() {
    EasyInAppNotify.show(
      content: const EasyInAppNotifyContent(
        title: 'No Progress Bar',
        message: 'This notification has no countdown progress.',
        icon: Icons.notifications_off,
      ),
      option: const EasyInAppNotifyOption(
        showProgressBar: false, // Hide progress bar
      ),
      theme: const EasyInAppNotifyTheme(color: Colors.grey),
    );
  }

  void _showNoSwipeNotification() {
    EasyInAppNotify.show(
      content: const EasyInAppNotifyContent(
        title: 'Cannot Swipe',
        message: 'This notification cannot be dismissed by swiping.',
        icon: Icons.lock,
      ),
      option: const EasyInAppNotifyOption(
        swipeToDismiss: false, // Disable swipe to dismiss
      ),
      theme: const EasyInAppNotifyTheme(color: Colors.brown),
    );
  }

  void _showCustomStyledNotification() {
    EasyInAppNotify.show(
      content: const EasyInAppNotifyContent(
        title: 'Custom Style',
        message: 'This notification has custom elevation and radius.',
        icon: Icons.style,
      ),
      theme: const EasyInAppNotifyTheme(
        color: Colors.teal,
        elevation: 15, // Higher elevation
        radius: 20, // More rounded corners
        margin: 12, // Larger margins
        padding: 16, // More internal padding
        iconSize: 28, // Larger icon
      ),
    );
  }

  void _showTrailingTextNotification() {
    EasyInAppNotify.show(
      content: const EasyInAppNotifyContent(
        title: 'New Message',
        message: 'You have received a new message from John.',
        icon: Icons.message,
        trailingText: '2m ago', // Timestamp
      ),
      theme: const EasyInAppNotifyTheme(color: Colors.indigo),
    );
  }

  void _showLongMessageNotification() {
    EasyInAppNotify.show(
      content: const EasyInAppNotifyContent(
        title: 'System Update Available',
        message:
            'A new system update is available for download. This update includes security improvements, bug fixes, and new features that will enhance your app experience.',
        icon: Icons.system_update,
        trailingText: 'Update',
      ),
      option: const EasyInAppNotifyOption(
        duration: 7, // Longer duration for more content
      ),
      theme: const EasyInAppNotifyTheme(color: Colors.cyan),
    );
  }
}
