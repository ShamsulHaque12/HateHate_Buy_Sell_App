import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';
import 'package:hate_hate_app/core/utils/app_language.dart';
import 'package:hate_hate_app/core/utils/helpers.dart';
import 'package:hate_hate_app/features/category/presentation/screens/category_screen.dart';
import 'package:hate_hate_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:hate_hate_app/features/home/presentation/screens/home_screen.dart';
import 'package:hate_hate_app/features/profile/presentation/screens/profile_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;

  const MainNavigationScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;

  final List<Widget> _screens = const [
    HomeScreen(),
    CategoryScreen(),
    SizedBox.shrink(), // Center Sell is an action
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabSelected(int index) {
    if (index == 2) {
      _showSellBottomSheet();
      return;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  void _showSellBottomSheet() {
    final isBengali = AppLanguage.current;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: AppColors.primaryFixed,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_shopping_cart_rounded,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                isBengali ? 'পণ্য বিক্রির বিজ্ঞাপন দিন' : 'Post an Ad for Sale',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                isBengali
                    ? 'আপনার ব্যবহৃত বা নতুন পণ্য সহজে ও দ্রুত বিক্রি করুন।'
                    : 'Sell your used or new items easily and quickly.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Helpers.showSnackBar(
                      context,
                      isBengali
                          ? 'বিজ্ঞাপন তৈরির পেজ শীঘ্রই আসছে...'
                          : 'Ad creation page coming soon...',
                    );
                  },
                  icon: const Icon(Icons.add_rounded, color: Colors.white),
                  label: Text(
                    isBengali ? 'বিজ্ঞাপন শুরু করুন' : 'Start Posting',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex == 2 ? 0 : _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        onSellTap: _showSellBottomSheet,
        hasChatNotification: true,
      ),
    );
  }
}
