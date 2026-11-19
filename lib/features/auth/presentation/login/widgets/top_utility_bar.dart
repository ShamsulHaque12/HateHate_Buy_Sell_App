import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';

class TopUtilityBar extends StatelessWidget {
  final bool isBengali;
  final ValueChanged<bool> onLanguageChanged;

  const TopUtilityBar({
    super.key,
    required this.isBengali,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Language Switcher
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLangButton(
                  title: 'বাংলা',
                  isSelected: isBengali,
                  onTap: () => onLanguageChanged(true),
                ),
                _buildLangButton(
                  title: 'EN',
                  isSelected: !isBengali,
                  onTap: () => onLanguageChanged(false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLangButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.surfaceContainerLowest
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected
                ? AppColors.primaryContainer
                : AppColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
