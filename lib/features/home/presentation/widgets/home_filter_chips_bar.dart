import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';

class HomeFilterChipsBar extends StatelessWidget {
  final bool isBengali;
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  const HomeFilterChipsBar({
    super.key,
    required this.isBengali,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      {'id': 'all', 'bn': 'সব পণ্য', 'en': 'All Products'},
      {'id': 'verified', 'bn': 'যাচাইকৃত বিক্রেতা', 'en': 'Verified Sellers'},
      {'id': 'urgent', 'bn': 'জরুরী বিক্রি', 'en': 'Urgent Sale'},
      {'id': 'negotiable', 'bn': '৳ দরদাম হবে', 'en': 'Negotiable'},
    ];

    return SizedBox(
      height: 38,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = filters[index];
          final isSelected = selectedFilter == item['id'];
          return GestureDetector(
            onTap: () => onFilterSelected(item['id']!),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                isBengali ? item['bn']! : item['en']!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
