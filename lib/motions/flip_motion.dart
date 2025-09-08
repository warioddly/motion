import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:motion/_motion_entry.dart';
import 'package:motion/motions/_motion.dart';

class FlipMotion extends Motion {
  const FlipMotion({super.child, super.key});

  @override
  MotionState createState() => _FlipMotionState();

  @override
  MotionEntry call() {
    final globalKey = GlobalKey<MotionState>();
    return MotionEntry(
      builder: (child) => FlipMotion(key: globalKey, child: child),
      state: globalKey,
    );
  }

  @override
  String get name => 'Flip Motion';
}

class _FlipMotionState extends MotionState {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(animation!.value * pi),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}