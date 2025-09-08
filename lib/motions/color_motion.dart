import 'package:flutter/material.dart';
import 'package:motion/_motion_entry.dart';
import 'package:motion/motions/_motion.dart';

class ColorMotion extends Motion {
  const ColorMotion({super.child, super.key});

  @override
  MotionState createState() => _ColorMotionState();

  @override
  MotionEntry call() {
    final globalKey = GlobalKey<MotionState>();
    return MotionEntry(
      builder: (child) => ColorMotion(
        key: globalKey,
        child: child,
      ),
      state: globalKey,
    );
  }

  @override
  String get name => 'Color Motion';

}

class _ColorMotionState extends MotionState {

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) {
        final color = ColorTween(
          begin: Colors.green,
          end: Colors.red,
        ).animate(animation!);
        return ColoredBox(
          color: color.value ?? Colors.transparent,
          child: child,
        );
      },
      child: widget.child,
    );
  }

}
