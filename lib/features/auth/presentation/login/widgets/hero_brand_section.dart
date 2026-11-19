import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';

class HeroBrandSection extends StatelessWidget {
  final bool isBengali;

  const HeroBrandSection({
    super.key,
    required this.isBengali,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        // Brand Logo Container with Glow & Badge
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Ambient soft glow behind
            Container(
              width: 86,
              height: 86,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryContainer.withValues(alpha: 0.18),
                    blurRadius: 16,
                    spreadRadius: 4,
                  ),
                ],
              ),
            ),

            // Main logo container
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
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
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.handshake_rounded,
                          color: AppColors.primaryContainer,
                          size: 32,
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

            // Verified Badge (Bottom right)
            Positioned(
              bottom: -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
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
                  size: 18,
                  color: AppColors.primaryContainer,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Title and P2P Trust Pill
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              isBengali ? 'হাতেহাতে' : 'HateHate',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.onSurface,
                letterSpacing: -0.5,
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
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        // Tagline
        Text(
          isBengali ? 'সহজে কিনুন, নিরাপদে বেচুন' : 'Buy easily, sell safely',
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.onSurfaceVariant,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
