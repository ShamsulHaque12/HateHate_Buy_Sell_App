import 'package:flutter/material.dart';

class CategoryItem {
  final String id;
  final String titleBn;
  final String titleEn;
  final IconData icon;

  const CategoryItem({
    required this.id,
    required this.titleBn,
    required this.titleEn,
    required this.icon,
  });
}
