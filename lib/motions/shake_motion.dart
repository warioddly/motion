import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:motion/_motion_entry.dart';
import 'package:motion/motions/_motion.dart';

class ShakeMotion extends Motion {
  const ShakeMotion({super.child, super.key});

  @override
  MotionState createState() => _ShakeMotionState();

  @override
  MotionEntry call() {
    final globalKey = GlobalKey<MotionState>();
    return MotionEntry(
      builder: (child) => ShakeMotion(
        key: globalKey,
        child: child,
      ),
      state: globalKey,
    );
  }

  @override
  String get name => 'Shake Motion';

}

class _ShakeMotionState extends MotionState {

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) {
        double offset = math.sin((animation?.value ?? 1) * 2 * math.pi * 4) * 8;
        return Transform.translate(
          offset: Offset(offset, 0),
          child: child,
        );
      },
      child: widget.child,
    );
  }

}
