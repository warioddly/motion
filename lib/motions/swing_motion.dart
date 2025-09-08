import 'dart:math';

import 'package:flutter/material.dart';
import 'package:motion/_motion_entry.dart';
import 'package:motion/motions/_motion.dart';


class SwingMotion extends Motion {
  const SwingMotion({super.child, super.key});

  @override
  MotionState createState() => _SwingMotionState();

  @override
  MotionEntry call() {
    final globalKey = GlobalKey<MotionState>();
    return MotionEntry(
      builder: (child) => SwingMotion(key: globalKey, child: child),
      state: globalKey,
    );
  }

  @override
  String get name => 'Swing Motion';
}

class _SwingMotionState extends MotionState {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) {
        final angle = sin(animation!.value * pi) * 0.2;
        return Transform.rotate(angle: angle, child: child);
      },
      child: widget.child,
    );
  }
}