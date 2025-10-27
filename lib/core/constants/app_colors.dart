import 'package:flutter/material.dart';

/// App Colors - Material Design 3 기반
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF1976D2); // Blue 700
  static const Color primaryLight = Color(0xFF42A5F5); // Blue 400
  static const Color primaryDark = Color(0xFF0D47A1); // Blue 900

  // Secondary Colors
  static const Color secondary = Color(0xFF26A69A); // Teal 400
  static const Color secondaryLight = Color(0xFF4DB6AC); // Teal 300
  static const Color secondaryDark = Color(0xFF00695C); // Teal 800

  // Neutral Colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  static const Color background = Color(0xFFFAFAFA);
  static const Color onSurface = Color(0xFF1C1B1F);
  static const Color onBackground = Color(0xFF1C1B1F);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);

  // Border & Divider
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);

  // Status Colors
  static const Color success = Color(0xFF4CAF50); // Green 500
  static const Color warning = Color(0xFFFFA726); // Orange 400
  static const Color error = Color(0xFFEF5350); // Red 400
  static const Color info = Color(0xFF29B6F6); // Light Blue 400

  // Tag Colors (for note tags)
  static const List<Color> tagColors = [
    Color(0xFFEF5350), // Red
    Color(0xFFEC407A), // Pink
    Color(0xFFAB47BC), // Purple
    Color(0xFF7E57C2), // Deep Purple
    Color(0xFF5C6BC0), // Indigo
    Color(0xFF42A5F5), // Blue
    Color(0xFF29B6F6), // Light Blue
    Color(0xFF26C6DA), // Cyan
    Color(0xFF26A69A), // Teal
    Color(0xFF66BB6A), // Green
    Color(0xFF9CCC65), // Light Green
    Color(0xFFD4E157), // Lime
    Color(0xFFFFEE58), // Yellow
    Color(0xFFFFCA28), // Amber
    Color(0xFFFFA726), // Orange
    Color(0xFFFF7043), // Deep Orange
  ];

  // Dark Mode Colors
  static const Color darkSurface = Color(0xFF1C1B1F);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkOnSurface = Color(0xFFE6E1E5);
  static const Color darkOnBackground = Color(0xFFE6E1E5);

  // Helper method to get tag color by index
  static Color getTagColor(int index) {
    return tagColors[index % tagColors.length];
  }

  // Helper method to get contrasting text color
  static Color getContrastingTextColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }
}
