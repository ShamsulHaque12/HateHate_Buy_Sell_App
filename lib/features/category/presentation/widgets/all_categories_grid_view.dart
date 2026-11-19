import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';
import '../../domain/entities/category_model.dart';
import 'category_sell_cta_banner.dart';

class AllCategoriesGridView extends StatelessWidget {
  final bool isBengali;
  final List<CategoryItemData> categories;
  final ValueChanged<int> onCategoryCardTap;
  final VoidCallback onPostAdTap;

  const AllCategoriesGridView({
    super.key,
    required this.isBengali,
    required this.categories,
    required this.onCategoryCardTap,
    required this.onPostAdTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Heading
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isBengali ? 'সকল ক্যাটাগরি ব্রাউজ করুন' : 'Browse All Categories',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              Text(
                '${categories.length} ${isBengali ? 'টি বিভাগ' : 'Categories'}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 2-Column Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.95,
            ),
            itemBuilder: (context, index) {
              final cat = categories[index];
              final title = isBengali ? cat.titleBn : cat.titleEn;
              final totalAds = isBengali ? cat.totalAdsBn : cat.totalAdsEn;

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => onCategoryCardTap(index + 1), // switch to tab index
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.surfaceContainerHighest.withValues(alpha: 0.7),
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: cat.lightBgColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                cat.icon,
                                color: cat.themeColor,
                                size: 24,
                              ),
                            ),
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerLow,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward_rounded,
                                size: 14,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              totalAds,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),

                        // Subcategory preview pills
                        if (cat.subcategories.isNotEmpty)
                          Text(
                            cat.subcategories
                                .take(2)
                                .map((s) => isBengali ? s.nameBn : s.nameEn)
                                .join(' • '),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.outline,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          // Sell CTA Banner
          CategorySellCtaBanner(
            isBengali: isBengali,
            onPostAdTap: onPostAdTap,
          ),
        ],
      ),
    );
  }
}
