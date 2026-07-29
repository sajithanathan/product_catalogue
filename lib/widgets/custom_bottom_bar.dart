// lib/widgets/custom_bottom_bar.dart

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool isDark;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBackground : AppColors.lightBackground,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.getShadowColor(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildBarItem(context, 0, Icons.home_rounded, "Home"),
            _buildBarItem(context, 1, Icons.local_drink_outlined, "Products"),
            _buildBarItem(context, 2, Icons.favorite_border_rounded, "Favorites"),
            _buildBarItem(context, 3, Icons.person_outline_rounded, "Profile"),
          ],
        ),
      ),
    );
  }

  Widget _buildBarItem(BuildContext context, int index, IconData icon, String label) {
    final theme = Theme.of(context);
    final bool isSelected = currentIndex == index;

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 14 : 8,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: _getIconColor(isSelected),
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: AppColors.textLight,
                  fontWeight: FontWeight.w600,
                ) ?? const TextStyle(
                  color: AppColors.textLight,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getIconColor(bool isSelected) {
    if (isSelected) {
      return AppColors.textLight;
    }
    return isDark 
        ? AppColors.getGreyShade(400) 
        : AppColors.textPrimary.withOpacity(0.7);
  }
}