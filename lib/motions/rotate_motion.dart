import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:motion/_motion_entry.dart';
import 'package:motion/motions/_motion.dart';

class RotateMotion extends Motion {
  const RotateMotion({super.child, super.key});

  @override
  MotionState createState() => _RotateMotionState();

  @override
  MotionEntry call() {
    final globalKey = GlobalKey<MotionState>();
    return MotionEntry(
      builder: (child) => RotateMotion(
        key: globalKey,
        child: child,
      ),
      state: globalKey,
    );
  }

  @override
  String get name => 'Rotate Motion';
}

class _RotateMotionState extends MotionState {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) {
        return Transform.rotate(
          angle: (animation?.value ?? 1) * 2 * math.pi,
          child: child,
        );
      },
      child: widget.child,
    );
  }

}
