import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';

class HomeSearchAndRadiusBox extends StatelessWidget {
  final bool isBengali;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback onVoiceSearchTap;
  final VoidCallback onFilterTap;

  const HomeSearchAndRadiusBox({
    super.key,
    required this.isBengali,
    this.searchController,
    this.onSearchChanged,
    required this.onVoiceSearchTap,
    required this.onFilterTap,
    String? locationArea,
    String? radius,
    VoidCallback? onLocationChangeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: AppColors.surfaceContainerHighest.withValues(alpha: 0.8),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 14, right: 10),
              child: Icon(
                Icons.search_rounded,
                color: AppColors.primary,
                size: 22,
              ),
            ),
            Expanded(
              child: TextField(
                controller: searchController,
                onChanged: onSearchChanged,
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                ),
                decoration: InputDecoration(
                  isCollapsed: true,
                  hintText: isBengali
                      ? 'যা খুঁজছেন লিখুন... (iPhone, বাইক)'
                      : 'Search items... (iPhone, Bike)',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: AppColors.outline.withValues(alpha: 0.75),
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            // Voice search mic button
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onVoiceSearchTap,
                child: Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.mic_none_rounded,
                    color: AppColors.outline,
                    size: 21,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),
            // Filter Button
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: onFilterTap,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.primaryContainer,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.tune_rounded,
                      color: Colors.white,
                      size: 19,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
