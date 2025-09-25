import 'package:flutter/material.dart' show Durations, Curve, Curves;

class MotionConfig {
  final Duration duration;
  final Duration startDelay;
  final double lowerBound;
  final double upperBound;
  final double value;
  final Duration reverseDuration;
  final Curve curve;
  final Curve reverseCurve;
  final bool repeat;
  final bool reverse;

  const MotionConfig({
    required this.duration,
    required this.startDelay,
    required this.lowerBound,
    required this.upperBound,
    required this.value,
    required this.reverseDuration,
    required this.curve,
    required this.reverseCurve,
    this.repeat = false,
    this.reverse = false,
  });

  factory MotionConfig.defaultConfig() {
    return MotionConfig(
      duration: Durations.medium3,
      startDelay: Duration.zero,
      reverseDuration: Durations.medium3,
      lowerBound: 0.0,
      upperBound: 1.0,
      value: 0.0,
      curve: Curves.linear,
      reverseCurve: Curves.linear,
      repeat: false,
      reverse: false,
    );
  }

  MotionConfig copyWith({
    Duration? duration,
    Duration? startDelay,
    double? lowerBound,
    double? upperBound,
    double? value,
    Duration? reverseDuration,
    Curve? curve,
    Curve? reverseCurve,
    bool? repeat,
    bool? reverse,
  }) {
    return MotionConfig(
      duration: duration ?? this.duration,
      startDelay: startDelay ?? this.startDelay,
      reverseDuration: reverseDuration ?? this.reverseDuration,
      lowerBound: lowerBound ?? this.lowerBound,
      upperBound: upperBound ?? this.upperBound,
      value: value ?? this.value,
      curve: curve ?? this.curve,
      reverseCurve: reverseCurve ?? this.reverseCurve,
      repeat: repeat ?? this.repeat,
      reverse: reverse ?? this.reverse,
    );
  }
}
