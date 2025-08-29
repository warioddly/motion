import 'dart:math' as math;

import 'package:flutter/material.dart';


enum MotionType {
  shake,
  fade,
  slide,
  scale,
  rotate;

  Widget createMotion(Widget child) {
    return switch (this) {
      MotionType.shake  => ShakeMotion(child: child),
      MotionType.fade   => FadeMotion(child: child),
      MotionType.slide  => SlideMotion(child: child),
      MotionType.scale  => ScaleMotion(child: child),
      MotionType.rotate => RotateMotion(child: child),
    };
  }
}

abstract class Motion extends StatefulWidget {
  const Motion({required this.child, super.key});

  final Widget child;
}

abstract class _MotionState extends State<Motion> with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    // controller = AnimationController(
    //   vsync: this,
    //   duration: config.duration,
    //   lowerBound: config.lowerBound,
    //   upperBound: config.upperBound,
    //   value: config.lowerBound,
    //   reverseDuration: config.duration,
    // );
    //
    // controller.repeat(
    //   reverse: true,
    //   period: config.duration,
    // );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class ShakeMotion extends Motion {
  const ShakeMotion({required super.child, super.key});

  @override
  _ShakeMotionState createState() => _ShakeMotionState();
}

class _ShakeMotionState extends _MotionState {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: super.controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            10 *
                (super.controller.value - 0.5).abs() *
                (super.controller.value < 0.5 ? -1 : 1),
            0,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class FadeMotion extends Motion {
  const FadeMotion({required super.child, super.key});

  @override
  _FadeMotionState createState() => _FadeMotionState();
}

class _FadeMotionState extends _MotionState {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: super.controller,
      builder: (context, child) {
        return Opacity(
          opacity: super.controller.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class SlideMotion extends Motion {
  const SlideMotion({required super.child, super.key});

  @override
  _SlideMotionState createState() => _SlideMotionState();
}

class _SlideMotionState extends _MotionState {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: super.controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            200 * super.controller.value,
            0,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class ScaleMotion extends Motion {
  const ScaleMotion({required super.child, super.key});

  @override
  _ScaleMotionState createState() => _ScaleMotionState();
}

class _ScaleMotionState extends _MotionState {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: super.controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 + super.controller.value * 0.5,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class RotateMotion extends Motion {
  const RotateMotion({required super.child, super.key});

  @override
  _RotateMotionState createState() => _RotateMotionState();
}

class _RotateMotionState extends _MotionState {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: super.controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: super.controller.value * 2 * math.pi,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}