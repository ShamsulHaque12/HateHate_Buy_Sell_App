import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';

class CategoryTrustMetricsBar extends StatelessWidget {
  final bool isBengali;

  const CategoryTrustMetricsBar({
    super.key,
    required this.isBengali,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.surfaceContainerHighest.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Metric 1
            Column(
              children: [
                Text(
                  isBengali ? '১০০% ফ্রি' : '100% Free',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isBengali ? 'বিজ্ঞাপন প্রকাশ' : 'Ad Posting',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            Container(
              width: 1,
              height: 28,
              color: AppColors.surfaceContainerHighest,
            ),

            // Metric 2
            Column(
              children: [
                Text(
                  isBengali ? 'হাতেহাতে' : 'HateHate',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isBengali ? 'ক্যাশ অন ডেলিভারি' : 'Cash On Delivery',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
