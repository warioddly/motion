import 'package:flutter/material.dart';
import 'package:motion/_motion_entry.dart';
import 'package:motion/motions/_motion.dart';

class OpacityMotion extends Motion {
  const OpacityMotion({super.child, super.key});

  @override
  MotionState createState() => _OpacityMotionState();

  @override
  MotionEntry call() {
    final globalKey = GlobalKey<MotionState>();
    return MotionEntry(
      builder: (child) => OpacityMotion(
        key: globalKey,
        child: child,
      ),
      state: globalKey,
    );
  }

  @override
  String get name => 'Opacity Motion';

}

class _OpacityMotionState extends MotionState {

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) {
        return Opacity(
          opacity: (animation?.value ?? 1),
          child: child,
        );
      },
      child: widget.child,
    );
  }

}
