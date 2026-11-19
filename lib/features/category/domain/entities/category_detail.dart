import 'package:flutter/material.dart';

class SubCategory {
  final String id;
  final String nameBn;
  final String nameEn;
  final String countBn;
  final String countEn;

  const SubCategory({
    required this.id,
    required this.nameBn,
    required this.nameEn,
    required this.countBn,
    required this.countEn,
  });
}

class CategoryDetail {
  final String id;
  final String nameBn;
  final String nameEn;
  final String countBn;
  final String countEn;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String? badgeBn;
  final String? badgeEn;
  final List<SubCategory> subCategories;

  const CategoryDetail({
    required this.id,
    required this.nameBn,
    required this.nameEn,
    required this.countBn,
    required this.countEn,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    this.badgeBn,
    this.badgeEn,
    required this.subCategories,
  });
}

class TrendingCategory {
  final String id;
  final String rankBn;
  final String rankEn;
  final String titleBn;
  final String titleEn;
  final String countBn;
  final String countEn;
  final String imageUrl;
  final Color rankColor;

  const TrendingCategory({
    required this.id,
    required this.rankBn,
    required this.rankEn,
    required this.titleBn,
    required this.titleEn,
    required this.countBn,
    required this.countEn,
    required this.imageUrl,
    required this.rankColor,
  });
}
