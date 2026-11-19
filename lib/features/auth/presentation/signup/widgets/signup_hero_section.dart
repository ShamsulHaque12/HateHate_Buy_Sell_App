import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';

class SignupHeroSection extends StatelessWidget {
  final bool isBengali;

  const SignupHeroSection({
    super.key,
    required this.isBengali,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Navigation Bar (Back button only - no 100% verified, no language toggle)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                color: AppColors.onSurface,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),

        const SizedBox(height: 6),

        // Elevated Logo Disc with Verified Badge
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: 78,
              height: 78,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: const BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.handshake_rounded,
                          color: AppColors.primaryContainer,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isBengali ? 'হাতেহাতে' : 'HateHate',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Floating Verified Check Disc
            Positioned(
              bottom: -2,
              right: -2,
              child: Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  color: AppColors.primaryContainer,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.verified,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        // Title and P2P Trust Pill
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              isBengali ? 'হাতেহাতে' : 'HateHate',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.onSurface,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.primaryFixed,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isBengali ? 'P2P ট্রাস্ট' : 'P2P Trust',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onPrimaryFixedVariant,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        // Tagline
        Text(
          isBengali
              ? 'নতুন অ্যাকাউন্ট খুলুন — সহজে কেনাবেচা শুরু করুন'
              : 'Create new account — start trading easily',
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.onSurfaceVariant,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
