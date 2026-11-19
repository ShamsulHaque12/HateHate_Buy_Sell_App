import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';

class CenterSellButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const CenterSellButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 62,
        height: 62,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.surfaceContainerLowest,
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.35),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 24,
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                height: 1.0,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
