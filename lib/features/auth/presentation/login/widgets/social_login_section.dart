import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';
import 'google_icon.dart';

class SocialLoginSection extends StatelessWidget {
  final bool isBengali;
  final VoidCallback onGoogleLogin;

  const SocialLoginSection({
    super.key,
    required this.isBengali,
    required this.onGoogleLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // Divider with text
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: AppColors.surfaceContainerHighest,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  isBengali ? 'অথবা সামাজিক মাধ্যমে প্রবেশ করুন' : 'Or continue with social media',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.outline,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: AppColors.surfaceContainerHighest,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Google Login Button
          InkWell(
            onTap: onGoogleLogin,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColors.surfaceContainerHighest.withValues(alpha: 0.6),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const GoogleIcon(size: 20),
                  const SizedBox(width: 10),
                  Text(
                    isBengali ? 'গুগল দিয়ে প্রবেশ করুন' : 'Continue with Google',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
