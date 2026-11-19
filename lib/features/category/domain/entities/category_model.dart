import 'package:flutter/material.dart';

class SubCategoryData {
  final String id;
  final String nameBn;
  final String nameEn;
  final String countBn;
  final String countEn;
  final IconData icon;

  const SubCategoryData({
    required this.id,
    required this.nameBn,
    required this.nameEn,
    required this.countBn,
    required this.countEn,
    required this.icon,
  });
}

class CategoryItemData {
  final String id;
  final String titleBn;
  final String titleEn;
  final String totalAdsBn;
  final String totalAdsEn;
  final IconData icon;
  final Color themeColor;
  final Color lightBgColor;
  final String bannerImage;
  final List<SubCategoryData> subcategories;
  final List<String> popularTagsBn;
  final List<String> popularTagsEn;

  const CategoryItemData({
    required this.id,
    required this.titleBn,
    required this.titleEn,
    required this.totalAdsBn,
    required this.totalAdsEn,
    required this.icon,
    required this.themeColor,
    required this.lightBgColor,
    required this.bannerImage,
    required this.subcategories,
    required this.popularTagsBn,
    required this.popularTagsEn,
  });
}
