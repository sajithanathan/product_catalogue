// lib/widgets/search_bar.dart

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: context.textColor,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        hintText: 'Search fresh juices...',
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: isDark ? AppColors.getGreyShade(400) : const Color(0xFFA8B0A6),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12, right: 8),
          child: Icon(
            Icons.search,
            color: isDark ? AppColors.getGreyShade(400) : const Color(0xFF6B7268),
            size: 20,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: Icon(
                  Icons.clear,
                  size: 18,
                  color: isDark ? AppColors.getGreyShade(400) : const Color(0xFF6B7268),
                ),
                onPressed: onClear,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 30,
                  minHeight: 30,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: isDark ? AppColors.getGreyShade(700) : const Color(0xFFDDE3EA),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: isDark ? AppColors.getGreyShade(400) : const Color(0xFFBCC6D0),
            width: 1.2,
          ),
        ),
        filled: true,
        fillColor: isDark ? AppColors.darkCardBackground : AppColors.lightBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        isDense: true,
      ),
    );
  }
}