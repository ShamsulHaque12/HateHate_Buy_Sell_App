import 'package:flutter/material.dart';
import 'package:hate_hate_app/core/constants/app_colors.dart';

class ValuePropositionCards extends StatelessWidget {
  final bool isBengali;

  const ValuePropositionCards({
    super.key,
    required this.isBengali,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          // Card 1
          Expanded(
            child: _buildCard(
              icon: Icons.handshake_outlined,
              title: isBengali ? 'সরাসরি লেনদেন' : 'Direct Trade',
              subtitle: isBengali ? 'জিরো হিডেন চার্জ বা কমিশন' : 'Zero hidden charges',
            ),
          ),
          const SizedBox(width: 10),
          // Card 2
          Expanded(
            child: _buildCard(
              icon: Icons.security,
              title: isBengali ? 'নিরাপদ এসক্রো' : 'Secure Escrow',
              subtitle: isBengali ? 'পণ্য হাতে পেয়ে পেমেন্ট' : 'Pay after receipt',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: AppColors.surfaceContainerHighest.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 20,
              color: AppColors.primaryContainer,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppColors.onSurfaceVariant,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}
