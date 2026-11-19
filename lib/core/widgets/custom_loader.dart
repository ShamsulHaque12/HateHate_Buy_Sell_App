import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomLoader extends StatelessWidget {
  final double size;
  final Color? color;
  final double strokeWidth;

  const CustomLoader({
    super.key,
    this.size = 24.0,
    this.color,
    this.strokeWidth = 2.5,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? AppColors.primary,
          ),
        ),
      ),
    );
  }
}
