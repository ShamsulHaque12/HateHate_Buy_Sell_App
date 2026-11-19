import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';

class TrustLegalFooter extends StatelessWidget {
  final bool isBengali;
  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;

  const TrustLegalFooter({
    super.key,
    required this.isBengali,
    required this.onTermsTap,
    required this.onPrivacyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          // Legal disclaimer with clickable links
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                isBengali
                    ? 'পরবর্তী ধাপে অগ্রসর হওয়ার মাধ্যমে আপনি হাতেহাতে-এর '
                    : 'By continuing, you agree to HateHate\'s ',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.outline,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                onTap: onTermsTap,
                child: Text(
                  isBengali ? 'শর্তাবলী' : 'Terms of Service',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryContainer,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Text(
                isBengali ? ' ও ' : ' & ',
                style: const TextStyle(fontSize: 11, color: AppColors.outline),
              ),
              GestureDetector(
                onTap: onPrivacyTap,
                child: Text(
                  isBengali ? 'গোপনীয়তা নীতি' : 'Privacy Policy',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryContainer,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Text(
                isBengali ? ' মেনে নিচ্ছেন।' : '.',
                style: const TextStyle(fontSize: 11, color: AppColors.outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
