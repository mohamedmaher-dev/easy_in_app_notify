import 'package:flutter/material.dart';
import 'package:easy_in_app_notify/easy_in_app_notify.dart';

void main() {
  runApp(const MyApp());
}

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
      home: const MyHomePage(title: 'Easy In-App Notify v3.1.0'),
      builder: EasyInAppNotify.init(), // Initialize the notification system
    );
  }
}

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
        actions: [
          // Clear all notifications button
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              EasyInAppNotify.dismissAll();
            },
            tooltip: 'Clear All Notifications',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            const Text(
              '🔔 Easy In-App Notify Demo',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Explore beautiful, customizable in-app notifications',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Quick Actions Section
            _buildSection(
              title: '🚀 Quick Actions',
              children: [
                _buildActionRow([
                  _buildDemoButton(
                    'Success',
                    Colors.green,
                    Icons.check_circle,
                    () => _showSuccessNotification(),
                  ),
                  _buildDemoButton(
                    'Error',
                    Colors.red,
                    Icons.error,
                    () => _showErrorNotification(),
                  ),
                ]),
                const SizedBox(height: 12),
                _buildActionRow([
                  _buildDemoButton(
                    'Warning',
                    Colors.orange,
                    Icons.warning,
                    () => _showWarningNotification(),
                  ),
                  _buildDemoButton(
                    'Info',
                    Colors.blue,
                    Icons.info,
                    () => _showInfoNotification(),
                  ),
                ]),
              ],
            ),

            const SizedBox(height: 24),

            // Positioning Section
            _buildSection(
              title: '📍 Positioning',
              children: [
                _buildActionRow([
                  _buildDemoButton(
                    'Top',
                    Colors.purple,
                    Icons.keyboard_arrow_up,
                    () => _showTopNotification(),
                  ),
                  _buildDemoButton(
                    'Bottom',
                    Colors.indigo,
                    Icons.keyboard_arrow_down,
                    () => _showBottomNotification(),
                  ),
                ]),
                const SizedBox(height: 12),
                _buildActionRow([
                  _buildDemoButton(
                    'Center',
                    Colors.teal,
                    Icons.center_focus_strong,
                    () => _showCenterNotification(),
                  ),
                  _buildDemoButton(
                    'Custom',
                    Colors.brown,
                    Icons.star,
                    () => _showCustomNotification(),
                  ),
                ]),
              ],
            ),

            const SizedBox(height: 24),

            // Advanced Features Section
            _buildSection(
              title: '⚡ Advanced Features',
              children: [
                _buildActionRow([
                  _buildDemoButton(
                    'Progress Bar',
                    Colors.pink,
                    Icons.timer,
                    () => _showProgressNotification(),
                  ),
                  _buildDemoButton(
                    'Blur Background',
                    Colors.cyan,
                    Icons.blur_on,
                    () => _showBlurNotification(),
                  ),
                ]),
                const SizedBox(height: 12),
                _buildActionRow([
                  _buildDemoButton(
                    'Persistent',
                    Colors.deepOrange,
                    Icons.push_pin,
                    () => _showPersistentNotification(),
                  ),
                  _buildDemoButton(
                    'Interactive',
                    Colors.lime,
                    Icons.touch_app,
                    () => _showInteractiveNotification(),
                  ),
                ]),
              ],
            ),

            const SizedBox(height: 24),

            // Animation Section
            _buildSection(
              title: '🎭 Animations',
              children: [
                _buildActionRow([
                  _buildDemoButton(
                    'Slide',
                    Colors.amber,
                    Icons.swipe,
                    () => _showSlideAnimation(),
                  ),
                  _buildDemoButton(
                    'Fade',
                    Colors.lightGreen,
                    Icons.opacity,
                    () => _showFadeAnimation(),
                  ),
                ]),
                const SizedBox(height: 12),
                _buildActionRow([
                  _buildDemoButton(
                    'Scale',
                    Colors.deepPurple,
                    Icons.zoom_in,
                    () => _showScaleAnimation(),
                  ),
                  _buildDemoButton(
                    'Multiple',
                    Colors.red,
                    Icons.layers,
                    () => _showMultipleNotifications(),
                  ),
                ]),
              ],
            ),

            const SizedBox(height: 32),

            // Footer
            const Text(
              'Tap any button to see the notification in action!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildActionRow(List<Widget> buttons) {
    return Row(
      children: buttons
          .expand(
            (button) => [Expanded(child: button), const SizedBox(width: 12)],
          )
          .take(buttons.length * 2 - 1)
          .toList(),
    );
  }

  Widget _buildDemoButton(
    String text,
    Color color,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // Notification methods
  void _showSuccessNotification() {
    EasyInAppNotify.show(
      content: const NotificationContent(
        title: 'Success!',
        message: 'Your operation completed successfully.',
        icon: Icons.check_circle,
      ),
      style: const NotificationStyle(primaryColor: Colors.green),
    );
  }

  void _showErrorNotification() {
    EasyInAppNotify.showError(
      title: 'Error Occurred',
      message: 'Something went wrong. Please try again.',
    );
  }

  void _showWarningNotification() {
    EasyInAppNotify.showWarning(
      title: 'Warning',
      message: 'Please check your input before proceeding.',
    );
  }

  void _showInfoNotification() {
    EasyInAppNotify.showInfo(
      title: 'Information',
      message: 'Here is some useful information for you.',
    );
  }

  void _showTopNotification() {
    EasyInAppNotify.show(
      content: const NotificationContent(
        title: 'Top Notification',
        message: 'This notification appears at the top of the screen.',
        icon: Icons.keyboard_arrow_up,
      ),
      style: const NotificationStyle(
        primaryColor: Colors.purple,
        position: NotificationPosition.top,
      ),
    );
  }

  void _showBottomNotification() {
    EasyInAppNotify.show(
      content: const NotificationContent(
        title: 'Bottom Notification',
        message: 'This notification appears at the bottom of the screen.',
        icon: Icons.keyboard_arrow_down,
      ),
      style: const NotificationStyle(
        primaryColor: Colors.indigo,
        position: NotificationPosition.bottom,
      ),
    );
  }

  void _showCenterNotification() {
    EasyInAppNotify.show(
      content: const NotificationContent(
        title: 'Center Notification',
        message: 'This notification appears in the center of the screen.',
        icon: Icons.center_focus_strong,
      ),
      style: const NotificationStyle(
        primaryColor: Colors.teal,
        position: NotificationPosition.center,
      ),
    );
  }

  void _showCustomNotification() {
    EasyInAppNotify.show(
      content: const NotificationContent(
        title: 'Custom Styled',
        message: 'Golden notification with rounded corners and high elevation.',
        icon: Icons.star,
      ),
      style: const NotificationStyle(
        primaryColor: Colors.brown,
        backgroundColor: Colors.amber,
        textColor: Colors.brown,
        borderRadius: 24,
        elevation: 16,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(20),
        maxWidth: 300,
      ),
      config: const NotificationConfig(duration: 6),
    );
  }

  void _showProgressNotification() {
    EasyInAppNotify.show(
      content: const NotificationContent(
        title: 'Progress Timer',
        message:
            'Watch the pink progress bar countdown below. Auto-dismiss in 8 seconds.',
        icon: Icons.timer,
      ),
      style: const NotificationStyle(
        primaryColor: Colors.pink,
        backgroundColor: Color(0xFFFCE4EC),
        showProgressBar: true,
        borderRadius: 12,
        elevation: 6,
      ),
      config: const NotificationConfig(duration: 8),
    );
  }

  void _showBlurNotification() {
    EasyInAppNotify.show(
      content: const NotificationContent(
        title: 'Blur Effect Demo',
        message:
            'Notice the beautiful blur effect behind this cyan notification with dark background.',
        icon: Icons.blur_on,
      ),
      style: const NotificationStyle(
        primaryColor: Colors.cyan,
        backgroundColor: Colors.white,
        enableBackgroundBlur: true,
        backgroundBlurOpacity: 0.4,
        position: NotificationPosition.center,
        borderRadius: 16,
        elevation: 8,
      ),
      config: const NotificationConfig(duration: 5),
    );
  }

  void _showPersistentNotification() {
    EasyInAppNotify.show(
      content: const NotificationContent(
        title: 'Persistent Alert',
        message:
            'This orange notification stays forever until manually dismissed. Swipe or tap somewhere else.',
        icon: Icons.push_pin,
      ),
      style: const NotificationStyle(
        primaryColor: Colors.deepOrange,
        backgroundColor: Color(0xFFFFF3E0),
        borderRadius: 8,
        elevation: 4,
      ),
      config: const NotificationConfig.persistent(dismissOnTap: false),
    );
  }

  void _showInteractiveNotification() {
    EasyInAppNotify.show(
      content: const NotificationContent(
        title: 'Tap to Interact!',
        message:
            'This green notification will show a snackbar when tapped and then dismiss.',
        icon: Icons.touch_app,
      ),
      style: const NotificationStyle(
        primaryColor: Colors.lime,
        backgroundColor: Color(0xFFF9FBE7),
        borderRadius: 12,
        elevation: 6,
      ),
      config: NotificationConfig(
        duration: 6,
        dismissOnTap: true,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('🎉 Interactive notification was tapped!'),
              backgroundColor: Colors.green,
            ),
          );
        },
      ),
    );
  }

  void _showSlideAnimation() {
    EasyInAppNotify.show(
      content: const NotificationContent(
        title: 'Slide Animation',
        message: 'This notification slides in smoothly from the top.',
        icon: Icons.swipe,
      ),
      style: const NotificationStyle(
        primaryColor: Colors.amber,
        backgroundColor: Color(0xFFFFF8E1),
        animation: NotificationAnimation.slide,
        animationDuration: Duration(milliseconds: 500),
        showProgressBar: true,
      ),
      config: const NotificationConfig(duration: 4),
    );
  }

  void _showFadeAnimation() {
    EasyInAppNotify.show(
      content: const NotificationContent(
        title: 'Fade Animation',
        message: 'This notification fades in elegantly with opacity.',
        icon: Icons.opacity,
      ),
      style: const NotificationStyle(
        primaryColor: Colors.lightGreen,
        backgroundColor: Color(0xFFF1F8E9),
        animation: NotificationAnimation.fade,
        animationDuration: Duration(milliseconds: 600),
        position: NotificationPosition.center,
        enableBackgroundBlur: true,
      ),
      config: const NotificationConfig(duration: 5),
    );
  }

  void _showScaleAnimation() {
    EasyInAppNotify.show(
      content: const NotificationContent(
        title: 'Scale Animation',
        message: 'This notification scales in beautifully from small to large.',
        icon: Icons.zoom_in,
      ),
      style: const NotificationStyle(
        primaryColor: Colors.deepPurple,
        backgroundColor: Color(0xFFEDE7F6),
        animation: NotificationAnimation.scale,
        animationDuration: Duration(milliseconds: 400),
        position: NotificationPosition.bottom,
        borderRadius: 20,
        elevation: 12,
      ),
      config: const NotificationConfig(duration: 3),
    );
  }

  void _showMultipleNotifications() {
    // Show multiple notifications in sequence
    for (int i = 1; i <= 3; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        EasyInAppNotify.show(
          content: NotificationContent(
            title: 'Notification $i',
            message: 'This is notification number $i of 3.',
            icon: Icons.layers,
          ),
          style: NotificationStyle(
            primaryColor: [Colors.red, Colors.green, Colors.blue][i - 1],
            position: [
              NotificationPosition.top,
              NotificationPosition.center,
              NotificationPosition.bottom,
            ][i - 1],
          ),
          config: const NotificationConfig(allowMultiple: true, duration: 4),
        );
      });
    }
  }
}
