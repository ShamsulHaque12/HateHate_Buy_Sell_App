import 'package:flutter/material.dart';

class GoogleIcon extends StatelessWidget {
  final double size;

  const GoogleIcon({super.key, this.size = 20.0});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _GoogleLogoPainter(),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final center = Offset(w / 2, h / 2);
    final radius = w / 2;

    // Paints
    final redPaint = Paint()..color = const Color(0xFFEA4335);
    final bluePaint = Paint()..color = const Color(0xFF4285F4);
    final yellowPaint = Paint()..color = const Color(0xFFFBBC05);
    final greenPaint = Paint()..color = const Color(0xFF34A853);

    final rect = Rect.fromCircle(center: center, radius: radius);

    // Blue section (Right & Bar)
    final bluePath = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(rect, -0.7, 1.4, false)
      ..close();
    canvas.drawPath(bluePath, bluePaint);

    // Green section (Bottom)
    final greenPath = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(rect, 0.7, 1.4, false)
      ..close();
    canvas.drawPath(greenPath, greenPaint);

    // Yellow section (Left)
    final yellowPath = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(rect, 2.1, 1.4, false)
      ..close();
    canvas.drawPath(yellowPath, yellowPaint);

    // Red section (Top)
    final redPath = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(rect, 3.5, 1.4, false)
      ..close();
    canvas.drawPath(redPath, redPaint);

    // Inner cutout circle
    final cutoutPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, radius * 0.58, cutoutPaint);

    // Blue horizontal bar
    final barPaint = Paint()..color = const Color(0xFF4285F4);
    final barRect = Rect.fromLTWH(
      center.dx - 1,
      center.dy - radius * 0.22,
      radius + 1,
      radius * 0.44,
    );
    canvas.drawRect(barRect, barPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
