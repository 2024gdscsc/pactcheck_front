import 'package:flutter/material.dart';

class HighlightPainter extends CustomPainter {
  final List<Rect> highlights;

  HighlightPainter({required this.highlights});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    for (var rect in highlights) {
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
