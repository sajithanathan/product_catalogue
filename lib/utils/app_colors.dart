// lib/utils/app_colors.dart

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ============================================================
  // Primary Brand Colors
  // ============================================================
  static const Color primaryGreen = Color(0xFF68B604);
  static const Color secondaryGreen = Color(0xFF557C2E);
  static const Color darkGreen = Color(0xFF2C4A1D);
  static const Color lightGreen = Color(0xFFEDF8D9);
  

  static const Color green568224 = Color(0xFF568224);

  // ============================================================
  // Background Colors
  // ============================================================
  static const Color lightBackground = Colors.white;
  static const Color darkBackground = Color(0xFF121212);
  static const Color lightCardBackground = Color(0xFFF9F9F9);
  static const Color darkCardBackground = Color(0xFF1E1E1E);

  // ============================================================
  // Card & Image Specific Colors
  // ============================================================
  static const Color productCardDark = Color(0xFF2C2C2C);
  static const Color imagePlaceholderLight = Color(0xFFFFEEDD);
  static const Color imageErrorDark = Color(0xFF424242);

  // ============================================================
  // Text Colors
  // ============================================================
  static const Color textPrimary = Colors.black87;
  static const Color textDarkGreen = Color(0xFF2C4A1D);
  static const Color textLight = Colors.white;

  // ============================================================
  // UI Element Colors
  // ============================================================
  static const Color darkElement = Color(0xFF33373E);
  static const Color favoriteColor = Colors.red;
  static const Color favoriteBorderColor = Color(0xFFE0E0E0);
  static const Color errorColor = Colors.red;
  static const Color categoryLabelText = Color(0xFF424242);
  static const Color promoTextColor = Colors.black87;

  // ============================================================
  // Shadow Colors
  // ============================================================
  static const Color cardShadow = Colors.black;
  static const Color bottomShadow = Colors.grey;

  // ============================================================
  // Helper Methods
  // ============================================================
  static Color getBackgroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? darkBackground : lightBackground;
  }
  
  static Color getCardBackgroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? darkCardBackground : lightCardBackground;
  }
  
  static Color getProductCardColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? productCardDark : lightBackground;
  }
  
  static Color getImagePlaceholderColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? darkCardBackground : imagePlaceholderLight;
  }
  
  static Color getImageErrorColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? imageErrorDark : Colors.grey.shade200;
  }
  
  static Color getTextColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.white : textPrimary;
  }
  
  static Color getSurfaceColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? darkCardBackground : lightCardBackground;
  }
  
  static Color getPrimaryColor(BuildContext context) => primaryGreen;
  static Color getSecondaryColor(BuildContext context) => secondaryGreen;
  
  static Color getFavoriteColor(bool isFavourite) {
    return isFavourite ? favoriteColor : textPrimary;
  }
  
  static Color getFavoriteContainerColor(BuildContext context) => Colors.white;
  
  static Color getCardBorderColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark 
        ? Colors.white.withOpacity(0.1) 
        : Colors.grey.withOpacity(0.1);
  }

  static Color getShadowColor(double opacity) {
    return Colors.black.withOpacity(opacity);
  }
  
  static Color getGreyShade(int shade) {
    switch (shade) {
      case 100: return Colors.grey.shade100;
      case 200: return Colors.grey.shade200;
      case 300: return Colors.grey.shade300;
      case 400: return Colors.grey.shade400;
      case 500: return Colors.grey.shade500;
      case 600: return Colors.grey.shade600;
      case 700: return Colors.grey.shade700;
      case 800: return Colors.grey.shade800;
      default: return Colors.grey.shade600;
    }
  }
}

extension AppColorsExtension on BuildContext {
  Color get backgroundColor => AppColors.getBackgroundColor(this);
  Color get cardBackgroundColor => AppColors.getCardBackgroundColor(this);
  Color get productCardColor => AppColors.getProductCardColor(this);
  Color get imagePlaceholderColor => AppColors.getImagePlaceholderColor(this);
  Color get imageErrorColor => AppColors.getImageErrorColor(this);
  Color get textColor => AppColors.getTextColor(this);
  Color get surfaceColor => AppColors.getSurfaceColor(this);
  Color get primaryColor => AppColors.getPrimaryColor(this);
  Color get secondaryColor => AppColors.getSecondaryColor(this);
  Color get cardBorderColor => AppColors.getCardBorderColor(this);
  Color get favoriteContainerColor => AppColors.getFavoriteContainerColor(this);
}