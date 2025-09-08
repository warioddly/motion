import 'dart:math';

import 'package:flutter/material.dart';
import 'package:motion/_motion_entry.dart';
import 'package:motion/motions/_motion.dart';


class WaveMotion extends Motion {
  const WaveMotion({super.child, super.key});

  @override
  MotionState createState() => _WaveMotionState();

  @override
  MotionEntry call() {
    final globalKey = GlobalKey<MotionState>();
    return MotionEntry(
      builder: (child) => WaveMotion(key: globalKey, child: child),
      state: globalKey,
    );
  }

  @override
  String get name => 'Wave Motion';
}

class _WaveMotionState extends MotionState {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) {
        final offsetY = sin(animation!.value * 2 * pi) * 10; // ±10 пикселей
        return Transform.translate(
          offset: Offset(0, offsetY),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}