import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';

class PasswordStrengthBar extends StatelessWidget {
  final String password;
  final bool isBengali;

  const PasswordStrengthBar({
    super.key,
    required this.password,
    required this.isBengali,
  });

  int get _strengthScore {
    if (password.isEmpty) return 0;
    if (password.length >= 8) return 3;
    if (password.length >= 5) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final score = _strengthScore;
    final isStrong = score >= 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 6),
        // 3-Segment Progress Bar
        Row(
          children: [
            Expanded(
              child: Container(
                height: 5,
                decoration: BoxDecoration(
                  color: score >= 1 ? AppColors.primaryContainer : AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Container(
                height: 5,
                decoration: BoxDecoration(
                  color: score >= 2 ? AppColors.primaryContainer : AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Container(
                height: 5,
                decoration: BoxDecoration(
                  color: score >= 3 ? AppColors.primaryContainer : AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        // Strength status row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  isStrong ? Icons.verified : Icons.shield_outlined,
                  size: 13,
                  color: isStrong ? AppColors.primaryContainer : AppColors.outline,
                ),
                const SizedBox(width: 4),
                Text(
                  isStrong
                      ? (isBengali ? 'নিরাপদ পাসওয়ার্ড' : 'Secure password')
                      : (isBengali ? 'সাধারণ পাসওয়ার্ড' : 'Standard password'),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isStrong ? AppColors.primaryContainer : AppColors.outline,
                  ),
                ),
              ],
            ),
            Text(
              isBengali ? 'কমপক্ষে ৮ অক্ষর' : 'Min 8 characters',
              style: TextStyle(
                fontSize: 10,
                color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
