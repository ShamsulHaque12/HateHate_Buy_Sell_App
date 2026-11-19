import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';

class NavItemWidget extends StatelessWidget {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final bool isSelected;
  final bool hasNotification;
  final VoidCallback onTap;

  const NavItemWidget({
    super.key,
    required this.icon,
    this.activeIcon,
    required this.label,
    required this.isSelected,
    this.hasNotification = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIcon = isSelected ? (activeIcon ?? icon) : icon;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Container with Active Pill & Notification Badge
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Active Pill Indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  width: isSelected ? 56 : 32,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryFixed.withValues(alpha: 0.38)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Icon(
                      effectiveIcon,
                      size: 22,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.onSurfaceVariant,
                    ),
                  ),
                ),

                // Red Notification Dot (e.g. for unread Chat messages)
                if (hasNotification)
                  Positioned(
                    top: 2,
                    right: isSelected ? 10 : -2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.surfaceContainerLowest,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 3),

            // Label Text
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? AppColors.primary
                    : AppColors.onSurfaceVariant,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
