import 'dart:math';

import 'package:flutter/material.dart';
import 'package:motion/_motion_entry.dart';
import 'package:motion/motions/_motion.dart';
import 'package:motion/motions/_motion_config.dart';
import 'package:motion/motions/_motion_control.dart';
import 'package:motion/shared/ui/constants/dimensions.dart';
import 'package:motion/shared/ui/forms/ui_curve_picker.dart';
import 'package:motion/shared/ui/forms/ui_textfield.dart';

class WaveMotionConfig extends MotionConfig {
  final double dx;
  final double dy;

  const WaveMotionConfig({
    required super.duration,
    required super.startDelay,
    required super.lowerBound,
    required super.upperBound,
    required super.value,
    required super.reverseDuration,
    required super.curve,
    required super.reverseCurve,
    required this.dx,
    required this.dy,
  });

  factory WaveMotionConfig.defaultConfig() {
    return WaveMotionConfig(
      duration: Durations.medium3,
      startDelay: Duration.zero,
      reverseDuration: Durations.medium3,
      lowerBound: 0.0,
      upperBound: 1.0,
      value: 0.0,
      curve: Curves.linear,
      reverseCurve: Curves.linear,
      dx: 0.0,
      dy: 12.0,
    );
  }

  @override
  WaveMotionConfig copyWith({
    Duration? duration,
    Duration? startDelay,
    double? lowerBound,
    double? upperBound,
    double? value,
    Duration? reverseDuration,
    Curve? curve,
    Curve? reverseCurve,
    double? dx,
    double? dy,
  }) {
    return WaveMotionConfig(
      duration: duration ?? this.duration,
      startDelay: startDelay ?? this.startDelay,
      reverseDuration: reverseDuration ?? this.reverseDuration,
      lowerBound: lowerBound ?? this.lowerBound,
      upperBound: upperBound ?? this.upperBound,
      value: value ?? this.value,
      curve: curve ?? this.curve,
      reverseCurve: reverseCurve ?? this.reverseCurve,
      dx: dx ?? this.dx,
      dy: dy ?? this.dy,
    );
  }
}

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
  WaveMotionConfig config = WaveMotionConfig.defaultConfig();

  @override
  MotionControl get controlPanel => WaveMotionControl(this);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) {
        final dy = sin(animation!.value * 2 * pi) * config.dy;
        final dx = cos(animation!.value * 2 * pi) * config.dx;
        return Transform.translate(
          offset: Offset(dx, dy),
          child: child,
        );
      },
      child: widget.child,
    );
  }

}

class WaveMotionControl extends MotionControl {
  const WaveMotionControl(super.state, {super.key});

  @override
  WaveMotionConfig get config => state.config as WaveMotionConfig;

  @override
  List<Widget> fields(BuildContext context) {
    return [
      UiTextfield(
        initialText: config.duration.inMilliseconds.toString(),
        labelText: 'Duration (ms)',
        onChanged: (value) {
          final ms = int.tryParse(value);
          if (ms != null) {
            updateConfig(
              config.copyWith(
                duration: Duration(milliseconds: ms),
              ),
            );
          }
        },
      ),
      UiTextfield(
        initialText: config.startDelay.inMilliseconds.toString(),
        labelText: 'Start Delay Duration (ms)',
        onChanged: (value) {
          final ms = int.tryParse(value);
          if (ms != null) {
            updateConfig(
              config.copyWith(
                duration: Duration(milliseconds: ms),
              ),
            );
          }
        },
      ),
      Row(
        children: [
          Flexible(
            child: UiTextfield(
              initialText: config.dx.toString(),
              labelText: 'X',
              onChanged: (value) {
                final dx = double.tryParse(value);
                updateConfig(config.copyWith(dx: dx));
              },
            ),
          ),
          Spaces.s,
          Flexible(
            child: UiTextfield(
              initialText: config.dy.toString(),
              labelText: 'Y',
              onChanged: (value) {
                final dy = double.tryParse(value);
                updateConfig(config.copyWith(dy: dy));
              },
            ),
          ),
        ],
      ),
      UICurvePicker(
        selected: config.curve,
        onChanged: (curve) {
          updateConfig(config.copyWith(curve: curve));
        },
      ),
    ];
  }
}
