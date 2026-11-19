import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';

class SignupTrustFootnote extends StatelessWidget {
  final bool isBengali;

  const SignupTrustFootnote({
    super.key,
    required this.isBengali,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shield_outlined,
                size: 14,
                color: AppColors.primaryContainer,
              ),
              const SizedBox(width: 6),
              Text(
                isBengali ? 'নিরাপদ সুরক্ষা' : 'Secure Protection',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            isBengali
                ? 'আপনার ব্যক্তিগত তথ্য সম্পূর্ণ নিরাপদ ও সুরক্ষিত থাকবে।'
                : 'Your personal data remains completely safe and confidential.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
