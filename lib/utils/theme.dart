// lib/utils/app_theme.dart

import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => _buildTheme(Brightness.light);
  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    
    return ThemeData(
      brightness: brightness,
      useMaterial3: true,
      fontFamily: 'Poppins',
      
      // Color Scheme using AppColors
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.primaryGreen,
        onPrimary: Colors.white,
        secondary: AppColors.secondaryGreen,
        onSecondary: Colors.white,
        surface: isDark ? AppColors.darkCardBackground : AppColors.lightCardBackground,
        onSurface: isDark ? Colors.white : AppColors.textPrimary,
        background: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        onBackground: isDark ? Colors.white : AppColors.textPrimary,
        error: AppColors.errorColor,
        onError: Colors.white,
      ),
      
      scaffoldBackgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      
      // AppBar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: isDark ? AppColors.darkBackground : Colors.transparent,
        foregroundColor: isDark ? Colors.white : AppColors.textPrimary,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 10,
      ),
      
      // Text Theme
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ).apply(
        bodyColor: isDark ? Colors.white : AppColors.textPrimary,
        displayColor: isDark ? Colors.white : AppColors.textPrimary,
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        color: isDark ? AppColors.darkCardBackground : AppColors.lightCardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.darkCardBackground : Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.primaryGreen,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.errorColor,
            width: 1,
          ),
        ),
        prefixIconColor: isDark ? Colors.white54 : Colors.grey.shade600,
        suffixIconColor: isDark ? Colors.white54 : Colors.grey.shade600,
        hintStyle: TextStyle(
          color: isDark ? Colors.white54 : Colors.grey.shade600,
          fontFamily: 'Poppins',
        ),
        labelStyle: TextStyle(
          color: isDark ? Colors.white70 : Colors.grey.shade700,
          fontFamily: 'Poppins',
        ),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
          elevation: 0,
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryGreen,
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? Colors.white : AppColors.textPrimary,
          side: BorderSide(
            color: isDark ? Colors.white24 : Colors.grey.shade400,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Icon Theme
      iconTheme: IconThemeData(
        color: isDark ? Colors.white : AppColors.textPrimary,
      ),
      
      // Progress Indicator Theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primaryGreen,
        linearTrackColor: isDark ? Colors.white12 : Colors.grey.shade200,
      ),
      
      // Divider Theme
      dividerTheme: DividerThemeData(
        color: isDark ? Colors.white12 : Colors.grey.shade200,
        thickness: 1,
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: isDark ? AppColors.darkCardBackground : AppColors.lightCardBackground,
        selectedColor: AppColors.primaryGreen,
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        secondaryLabelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide(
          color: isDark ? Colors.white24 : Colors.grey.shade300,
          width: 1,
        ),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark ? AppColors.darkCardBackground : Colors.white,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: isDark ? Colors.white54 : Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}