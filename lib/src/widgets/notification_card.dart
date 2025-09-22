import 'package:flutter/material.dart';
import '../models/notification_content.dart';
import '../models/notification_style.dart';

/// The main card widget that displays notification content.
///
/// This widget creates the visual structure for the notification, including
/// the card background, content layout, and styling.
class NotificationCard extends StatelessWidget {
  /// The content to display in the notification.
  final NotificationContent content;

  /// The styling configuration for the notification.
  final NotificationStyle style;

  /// Optional progress animation for the progress bar.
  final Animation<double>? progressAnimation;

  /// Creates a new notification card.
  const NotificationCard({
    super.key,
    required this.content,
    required this.style,
    this.progressAnimation,
  });

  @override
  Widget build(final BuildContext context) => Container(
    constraints: style.maxWidth != null
        ? BoxConstraints(maxWidth: style.maxWidth!)
        : null,
    child: Card(
      elevation: style.elevation,
      color: style.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(style.borderRadius),
      ),
      margin: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main content
          Padding(
            padding: style.padding,
            child: content.customContent ?? _buildDefaultContent(),
          ),

          // Progress bar
          if (style.showProgressBar && progressAnimation != null)
            _buildProgressBar(),
        ],
      ),
    ),
  );

  /// Builds the default content layout with icon, text, and trailing widget.
  Widget _buildDefaultContent() => Row(
    children: [
      // Icon
      if (content.icon != null) ...[_buildIcon(), const SizedBox(width: 12)],

      // Text content
      Expanded(child: _buildTextContent()),

      // Trailing widget
      if (content.trailing != null) ...[
        const SizedBox(width: 12),
        content.trailing!,
      ],
    ],
  );

  /// Builds the icon with appropriate styling.
  Widget _buildIcon() => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: style.effectiveIconColor.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Icon(content.icon, color: style.effectiveIconColor, size: 24),
  );

  /// Builds the text content (title and message).
  Widget _buildTextContent() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      // Title
      Text(
        content.title,
        style: TextStyle(
          color: style.textColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),

      // Message
      if (content.message != null && content.message!.isNotEmpty) ...[
        const SizedBox(height: 4),
        Text(
          content.message!,
          style: TextStyle(
            color: style.textColor.withValues(alpha: 0.8),
            fontSize: 14,
            height: 1.3,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ],
  );

  /// Builds the progress bar indicator.
  Widget _buildProgressBar() => AnimatedBuilder(
    animation: progressAnimation!,
    builder: (final context, final child) => Container(
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(style.borderRadius),
          bottomRight: Radius.circular(style.borderRadius),
        ),
      ),
      child: LinearProgressIndicator(
        value: progressAnimation!.value,
        backgroundColor: style.primaryColor.withValues(alpha: 0.2),
        valueColor: AlwaysStoppedAnimation<Color>(style.primaryColor),
      ),
    ),
  );
}
