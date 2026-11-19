import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';
import 'package:hate_hate_app/core/utils/app_language.dart';
import 'center_sell_button.dart';
import 'nav_item_widget.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback? onSellTap;
  final bool hasChatNotification;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.onSellTap,
    this.hasChatNotification = true,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppLanguage.isBengali,
      builder: (context, isBengali, _) {
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            // Bottom Navigation Bar Surface Container
            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  height: 64,
                  child: Row(
                    children: [
                      // Item 0: Home / হোম
                      NavItemWidget(
                        icon: Icons.home_outlined,
                        activeIcon: Icons.home_rounded,
                        label: isBengali ? 'হোম' : 'Home',
                        isSelected: currentIndex == 0,
                        onTap: () => onTap(0),
                      ),

                      // Item 1: Category / ক্যাটাগরি
                      NavItemWidget(
                        icon: Icons.category_outlined,
                        activeIcon: Icons.category_rounded,
                        label: isBengali ? 'ক্যাটাগরি' : 'Category',
                        isSelected: currentIndex == 1,
                        onTap: () => onTap(1),
                      ),

                      // Item 2 Spacer for Center Sell Button
                      const SizedBox(width: 68),

                      // Item 3: Chat / চ্যাট (With Notification Badge)
                      NavItemWidget(
                        icon: Icons.chat_bubble_outline_rounded,
                        activeIcon: Icons.chat_bubble_rounded,
                        label: isBengali ? 'চ্যাট' : 'Chat',
                        isSelected: currentIndex == 3,
                        hasNotification: hasChatNotification,
                        onTap: () => onTap(3),
                      ),

                      // Item 4: Profile / প্রোফাইল
                      NavItemWidget(
                        icon: Icons.person_outline_rounded,
                        activeIcon: Icons.person_rounded,
                        label: isBengali ? 'প্রোফাইল' : 'Profile',
                        isSelected: currentIndex == 4,
                        onTap: () => onTap(4),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Elevated Center Sell Button (বিক্রি)
            Positioned(
              top: -16,
              child: CenterSellButton(
                label: isBengali ? 'বিক্রি' : 'Sell',
                onTap: () {
                  if (onSellTap != null) {
                    onSellTap!();
                  } else {
                    onTap(2);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
