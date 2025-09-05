import 'package:flutter/material.dart';
import 'package:motion/shared/ui/previews/preview_overlay.dart';


class CurvePreview extends StatefulWidget {
  const CurvePreview({super.key, required this.curve, this.onComplete});

  final Curve curve;
  final VoidCallback? onComplete;

  static final overlay = PreviewOverlay();

  static show(BuildContext context, Curve curve) {
    overlay.dispose();
    overlay.show(context,
        CurvePreview(
          curve: curve,
          onComplete: () => overlay.dispose(),
        )
    );
  }

  @override
  State<CurvePreview> createState() => _CurvePreviewState();
}

class _CurvePreviewState extends State<CurvePreview> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late CurvedAnimation curvedAnimation;

  Duration duration = const Duration(seconds: 1);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration);

    curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: widget.curve,
    );

    controller.forward();

    curvedAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Durations.medium2, widget.onComplete?.call);
      }
    });

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          width: 300,
          height: 200,
          padding: EdgeInsets.all(12),
          child: AnimatedBuilder(
            animation: curvedAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: _DrawCurve(
                  curve: widget.curve,
                  t: curvedAnimation.value,
                ),
                child: SizedBox.square(),
              );
            },
          ),
        ),
      ),
    );
  }
}


class _DrawCurve extends CustomPainter {
  final Curve curve;
  final double t;

  _DrawCurve({required this.t, required this.curve});

  final _axisPaint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;

  final _gridPaint = Paint()
    ..color = Colors.grey
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.5;

  final _ballPaint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  final _linePaint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;

    for (double x = 0; x <= width; x++) {
      final t = x / width;
      final y = height * (1 - curve.transform(t));
      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, _linePaint);

    final x = width * t;
    final y = height * (1 - curve.transform(t.clamp(0, 1)));

    canvas.drawCircle(Offset(x, y), 6, _ballPaint);

    for (double i = 0; i <= width; i += 20) {
      canvas.drawLine(Offset(i, 0), Offset(i, height), _gridPaint);
    }

    for (double i = 0; i <= height; i += 20) {
      canvas.drawLine(Offset(0, i), Offset(width, i), _gridPaint);
    }

    canvas
      ..drawLine(Offset(0, height), Offset(width, height), _axisPaint)
      ..drawLine(Offset(0, 0), Offset(0, height), _axisPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is _DrawCurve && oldDelegate.curve != curve ||
        oldDelegate is _DrawCurve && oldDelegate.t != t;
  }
}