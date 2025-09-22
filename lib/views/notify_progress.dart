part of '../easy_in_app_notify.dart';

/// Widget that displays a progress bar showing time remaining until auto-dismiss.
///
/// This widget provides visual feedback to users about how much time is left
/// before the notification automatically disappears. The progress bar fills
/// from 0% to 100% over the duration specified in the notification options.
class _NotifyProgress extends StatelessWidget {
  final EasyInAppNotifyTheme theme;

  /// Animation that drives the progress bar from 0.0 to 1.0 over time.
  final Animation<double> animation;

  /// Creates a new progress indicator widget.
  ///
  /// Requires the animation to coordinate with the notification's countdown timer.
  const _NotifyProgress({required this.animation, required this.theme});

  @override
  Widget build(final BuildContext context) {
    // Get theming from Provider context

    // Create subtle background color for the progress track
    final primaryBackgroundColor = Theme.of(
      context,
    ).colorScheme.primary.withAlpha(kBackgroundColorAlpha);

    return Padding(
      padding: EdgeInsets.all(theme.padding),
      child: AnimatedBuilder(
        animation: animation,
        builder: (final context, final child) => ClipRRect(
          borderRadius: BorderRadius.circular(4.0), // Rounded progress bar
          child: Directionality(
            textDirection: Directionality.of(context), // Support RTL layouts
            child: LinearProgressIndicator(
              value: animation.value, // Progress value from 0.0 to 1.0
              // Background track color using theme or primary color
              backgroundColor: theme.color == null
                  ? primaryBackgroundColor
                  : theme.color!.withAlpha(kBackgroundColorAlpha),
              // Active progress color matching the notification theme
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.color ?? Theme.of(context).colorScheme.primary,
              ),
              minHeight: 4.0, // Consistent progress bar height
            ),
          ),
        ),
      ),
    );
  }
}
