

import 'package:flutter/material.dart';

class GridBackground extends StatelessWidget {
  final double cellSize;
  final Color lineColor;
  final double lineWidth;

  final Widget child;

  const GridBackground({
    this.cellSize = 20,
    this.lineColor = Colors.white,
    this.lineWidth = 0.5,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _GridPainter(
        cellSize: cellSize,
        lineColor: lineColor,
        lineWidth: lineWidth,
      ),
      child: child,
    );
  }
}

class _GridPainter extends CustomPainter {
  final double cellSize;
  final Color lineColor;
  final double lineWidth;

  _GridPainter({
    required this.cellSize,
    required this.lineColor,
    required this.lineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.grey,
    );

    for (double x = 0; x <= size.width; x += cellSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += cellSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.cellSize != cellSize ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.lineWidth != lineWidth;
  }
}
