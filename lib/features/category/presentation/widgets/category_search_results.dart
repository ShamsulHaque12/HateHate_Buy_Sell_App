import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';
import '../../domain/entities/category_model.dart';

class CategorySearchResults extends StatelessWidget {
  final bool isBengali;
  final String query;
  final List<CategoryItemData> categories;
  final ValueChanged<CategoryItemData> onCategoryTap;
  final ValueChanged<SubCategoryData> onSubCategoryTap;

  const CategorySearchResults({
    super.key,
    required this.isBengali,
    required this.query,
    required this.categories,
    required this.onCategoryTap,
    required this.onSubCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    final q = query.toLowerCase();

    // Filter categories that match or have subcategories that match
    final matchedCategories = categories.where((cat) {
      final nameMatches = cat.titleBn.toLowerCase().contains(q) ||
          cat.titleEn.toLowerCase().contains(q);
      final subMatches = cat.subcategories.any((sub) =>
          sub.nameBn.toLowerCase().contains(q) ||
          sub.nameEn.toLowerCase().contains(q));
      return nameMatches || subMatches;
    }).toList();

    if (matchedCategories.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.search_off_rounded,
                  size: 32,
                  color: AppColors.outline,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                isBengali
                    ? '"$query" এর জন্য কোনো ফলাফল নেই'
                    : 'No results found for "$query"',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                isBengali
                    ? 'বানান সঠিক আছে কিনা নিশ্চিত করুন বা অন্য নাম লিখুন'
                    : 'Check your spelling or try another keyword',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      physics: const BouncingScrollPhysics(),
      itemCount: matchedCategories.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final cat = matchedCategories[index];
        final title = isBengali ? cat.titleBn : cat.titleEn;
        final totalAds = isBengali ? cat.totalAdsBn : cat.totalAdsEn;

        // Subcategories that match the query
        final matchedSubs = cat.subcategories.where((sub) {
          return sub.nameBn.toLowerCase().contains(q) ||
              sub.nameEn.toLowerCase().contains(q);
        }).toList();

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.surfaceContainerHighest.withValues(alpha: 0.6),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Header
              InkWell(
                onTap: () => onCategoryTap(cat),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: cat.lightBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(cat.icon, color: cat.themeColor, size: 22),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            totalAds,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: AppColors.outline,
                    ),
                  ],
                ),
              ),

              // Subcategories matching tags
              if (matchedSubs.isNotEmpty) ...[
                const SizedBox(height: 10),
                const Divider(height: 1, color: AppColors.surfaceContainerHighest),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: matchedSubs.map((sub) {
                    final subName = isBengali ? sub.nameBn : sub.nameEn;
                    final subCount = isBengali ? sub.countBn : sub.countEn;

                    return GestureDetector(
                      onTap: () => onSubCategoryTap(sub),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              subName,
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '($subCount)',
                              style: const TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
