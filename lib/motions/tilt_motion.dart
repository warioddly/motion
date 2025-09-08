import 'package:flutter/material.dart';
import 'package:motion/_motion_entry.dart';
import 'package:motion/motions/_motion.dart';


class TiltMotion extends Motion {
  const TiltMotion({super.child, super.key});

  @override
  MotionState createState() => _TiltMotionState();

  @override
  MotionEntry call() {
    final globalKey = GlobalKey<MotionState>();
    return MotionEntry(
      builder: (child) => TiltMotion(key: globalKey, child: child),
      state: globalKey,
    );
  }

  @override
  String get name => 'Tilt Motion';
}

class _TiltMotionState extends MotionState {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) {
        final angleX = (animation!.value - 0.5) * 0.5;
        final angleY = (animation!.value - 0.5) * 0.5;
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(angleX)
            ..rotateY(angleY),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}