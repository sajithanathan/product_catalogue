// lib/widgets/main_button.dart

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isDark;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final bool isOutlined;

  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.isDark = false,
    this.width,
    this.height,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.padding,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;
    final bool useDark = isDark || isDarkMode;

    final Color bgColor = backgroundColor ?? 
        (useDark ? AppColors.textLight : AppColors.textPrimary);

    final Color txtColor = textColor ?? 
        (useDark ? AppColors.textPrimary : AppColors.textLight);

    final TextStyle textStyle = theme.textTheme.titleMedium?.copyWith(
      color: txtColor,
      fontSize: fontSize ?? theme.textTheme.titleMedium?.fontSize,
      fontWeight: fontWeight ?? FontWeight.w600,
    ) ?? TextStyle(
      color: txtColor,
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.w600,
    );

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 55,
      child: isOutlined 
          ? OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: txtColor,
                side: BorderSide(
                  color: useDark ? AppColors.getGreyShade(600) : AppColors.getGreyShade(400),
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 28),
                ),
                padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                textStyle: textStyle,
              ),
              onPressed: onPressed,
              child: Text(text, style: textStyle),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: bgColor,
                foregroundColor: txtColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 28),
                ),
                elevation: 0,
                padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                textStyle: textStyle,
              ),
              onPressed: onPressed,
              child: Text(text, style: textStyle),
            ),
    );
  }
}