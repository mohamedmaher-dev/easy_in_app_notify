import 'package:flutter/material.dart';
import 'package:easy_in_app_notify/easy_in_app_notify.dart';

/// Predefined theme configurations for different use cases
class ThemeConfig {
  /// Corporate/Professional theme - clean and business-appropriate
  static const EasyInAppNotifyTheme corporate = EasyInAppNotifyTheme(
    color: Color(0xFF1565C0), // Professional blue
    margin: 8,
    padding: 16,
    radius: 4, // Sharp corners for corporate look
    elevation: 2, // Subtle shadow
    iconSize: 24,
  );

  /// Gaming theme - vibrant and energetic
  static const EasyInAppNotifyTheme gaming = EasyInAppNotifyTheme(
    color: Color(0xFFE91E63), // Vibrant pink
    margin: 4,
    padding: 12,
    radius: 16, // Very rounded for fun look
    elevation: 12, // High elevation for dramatic effect
    iconSize: 28, // Larger icons
  );

  /// Minimal theme - clean and understated
  static const EasyInAppNotifyTheme minimal = EasyInAppNotifyTheme(
    color: Color(0xFF424242), // Neutral gray
    margin: 12,
    padding: 8,
    radius: 8, // Moderate rounding
    elevation: 1, // Very subtle shadow
  );

  /// E-commerce theme - trustworthy and conversion-focused
  static const EasyInAppNotifyTheme ecommerce = EasyInAppNotifyTheme(
    color: Color(0xFF4CAF50), // Trust-building green
    margin: 6,
    padding: 14,
    radius: 12,
    elevation: 6,
    iconSize: 22,
  );

  /// Healthcare theme - calming and professional
  static const EasyInAppNotifyTheme healthcare = EasyInAppNotifyTheme(
    color: Color(0xFF00ACC1), // Calming teal
    margin: 10,
    padding: 16,
    radius: 8,
    elevation: 4,
    iconSize: 24,
  );

  /// Education theme - friendly and approachable
  static const EasyInAppNotifyTheme education = EasyInAppNotifyTheme(
    color: Color(0xFFFF9800), // Warm orange
    margin: 8,
    padding: 12,
    iconSize: 26,
  );

  /// News/Media theme - authoritative and attention-grabbing
  static const EasyInAppNotifyTheme news = EasyInAppNotifyTheme(
    color: Color(0xFFD32F2F), // News red
    padding: 14,
    radius: 6,
    elevation: 8,
    iconSize: 24,
  );

  /// Social media theme - trendy and engaging
  static const EasyInAppNotifyTheme social = EasyInAppNotifyTheme(
    color: Color(0xFF7B1FA2), // Social purple
    margin: 6,
    padding: 12,
    radius: 14,
    elevation: 7,
    iconSize: 25,
  );

  /// Finance theme - secure and trustworthy
  static const EasyInAppNotifyTheme finance = EasyInAppNotifyTheme(
    color: Color(0xFF2E7D32), // Money green
    margin: 10,
    padding: 16,
    radius: 6,
    elevation: 3,
    iconSize: 22,
  );

  /// Travel theme - adventurous and inspiring
  static const EasyInAppNotifyTheme travel = EasyInAppNotifyTheme(
    color: Color(0xFF0277BD), // Sky blue
    margin: 8,
    padding: 14,
    radius: 12,
    elevation: 6,
    iconSize: 26,
  );

  /// Food/Restaurant theme - appetizing and warm
  static const EasyInAppNotifyTheme food = EasyInAppNotifyTheme(
    color: Color(0xFFFF5722), // Appetizing orange-red
    margin: 7,
    padding: 12,
    radius: 15,
    elevation: 9,
    iconSize: 24,
  );

  /// Fitness theme - energetic and motivating
  static const EasyInAppNotifyTheme fitness = EasyInAppNotifyTheme(
    color: Color(0xFF388E3C), // Energetic green
    margin: 6,
    padding: 14,
    iconSize: 28,
  );

  /// Dark mode theme - optimized for dark interfaces
  static const EasyInAppNotifyTheme dark = EasyInAppNotifyTheme(
    color: Color(0xFF90CAF9), // Light blue for dark backgrounds
    margin: 8,
    padding: 14,
    elevation: 12, // Higher elevation needed for dark themes
    iconSize: 24,
  );

  /// High contrast theme - for accessibility
  static const EasyInAppNotifyTheme highContrast = EasyInAppNotifyTheme(
    color: Color(0xFF000000), // Pure black for maximum contrast
    margin: 12,
    padding: 18,
    radius: 4, // Sharp corners for clarity
    elevation: 15, // High elevation for clear separation
    iconSize: 30, // Larger icons for visibility
  );

  /// Success-specific theme variations
  static const EasyInAppNotifyTheme successTheme = EasyInAppNotifyTheme(
    color: Color(0xFF4CAF50), // Success green
    margin: 6,
    padding: 12,
    radius: 8,
    elevation: 4,
    iconSize: 22,
  );

  /// Error-specific theme variations
  static const EasyInAppNotifyTheme errorTheme = EasyInAppNotifyTheme(
    color: Color(0xFFE53935), // Error red
    margin: 8,
    padding: 14,
    radius: 6,
    elevation: 8, // Higher elevation for errors
    iconSize: 24,
  );

  /// Warning-specific theme variations
  static const EasyInAppNotifyTheme warningTheme = EasyInAppNotifyTheme(
    color: Color(0xFFFF9800), // Warning orange
    margin: 7,
    padding: 13,
    radius: 7,
    elevation: 6,
    iconSize: 23,
  );

  /// Info-specific theme variations
  static const EasyInAppNotifyTheme infoTheme = EasyInAppNotifyTheme(
    color: Color(0xFF2196F3), // Info blue
    margin: 6,
    padding: 12,
    radius: 8,
    elevation: 4,
    iconSize: 22,
  );

  /// Get theme by name (useful for configuration from external sources)
  static EasyInAppNotifyTheme? getThemeByName(final String name) {
    switch (name.toLowerCase()) {
      case 'corporate':
        return corporate;
      case 'gaming':
        return gaming;
      case 'minimal':
        return minimal;
      case 'ecommerce':
        return ecommerce;
      case 'healthcare':
        return healthcare;
      case 'education':
        return education;
      case 'news':
        return news;
      case 'social':
        return social;
      case 'finance':
        return finance;
      case 'travel':
        return travel;
      case 'food':
        return food;
      case 'fitness':
        return fitness;
      case 'dark':
        return dark;
      case 'high_contrast':
        return highContrast;
      case 'success':
        return successTheme;
      case 'error':
        return errorTheme;
      case 'warning':
        return warningTheme;
      case 'info':
        return infoTheme;
      default:
        return null;
    }
  }

  /// Get all available theme names
  static List<String> get availableThemes => [
    'corporate',
    'gaming',
    'minimal',
    'ecommerce',
    'healthcare',
    'education',
    'news',
    'social',
    'finance',
    'travel',
    'food',
    'fitness',
    'dark',
    'high_contrast',
    'success',
    'error',
    'warning',
    'info',
  ];

  /// Create a custom theme with specific color and default styling
  static EasyInAppNotifyTheme createCustomTheme({
    required final Color color,
    final String style = 'standard',
  }) {
    switch (style.toLowerCase()) {
      case 'minimal':
        return EasyInAppNotifyTheme(
          color: color,
          margin: 12,
          padding: 8,
          radius: 8,
          elevation: 1,
        );
      case 'dramatic':
        return EasyInAppNotifyTheme(
          color: color,
          margin: 4,
          padding: 16,
          radius: 16,
          elevation: 15,
          iconSize: 30,
        );
      case 'corporate':
        return EasyInAppNotifyTheme(
          color: color,
          margin: 8,
          padding: 16,
          radius: 4,
          elevation: 2,
          iconSize: 24,
        );
      default: // standard
        return EasyInAppNotifyTheme(
          color: color,
          margin: 6,
          padding: 12,
          iconSize: 22,
        );
    }
  }

  /// Apply device-specific optimizations
  static EasyInAppNotifyTheme optimizeForDevice(
    final EasyInAppNotifyTheme theme,
  ) {
    // This is a simplified example - in a real app, you might check:
    // - Screen size/density
    // - Platform (iOS/Android)
    // - Accessibility settings
    // - User preferences

    return theme; // Return as-is for this example
  }
}
