import 'package:flutter/material.dart';
import 'package:motion/_motion_entry.dart';
import 'package:motion/motions/_motion.dart';

class ScaleMotion extends Motion {
  const ScaleMotion({super.child, super.key});

  @override
  MotionState createState() => _ScaleMotionState();

  @override
  MotionEntry call() {
    final globalKey = GlobalKey<MotionState>();
    return MotionEntry(
      builder: (child) => ScaleMotion(
        key: globalKey,
        child: child,
      ),
      state: globalKey,
    );
  }

  @override
  String get name => 'Scale Motion';

}

class _ScaleMotionState extends MotionState {

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) {
        return Transform.scale(
          scale: animation?.value ?? 1,
          child: child,
        );
      },
      child: widget.child,
    );
  }

}
