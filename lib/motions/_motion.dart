import 'package:flutter/material.dart';

final class MotionConfig {
  final Duration duration;
  final double lowerBound;
  final double upperBound;
  final double value;
  final Duration reverseDuration;
  final Curve curve;
  final Curve reverseCurve;

  const MotionConfig({
    required this.duration,
    required this.lowerBound,
    required this.upperBound,
    required this.value,
    required this.reverseDuration,
    required this.curve,
    required this.reverseCurve,
  });

  factory MotionConfig.defaultConfig() {
    return MotionConfig(
      duration: Durations.medium3,
      reverseDuration: Durations.medium3,
      lowerBound: 0.0,
      upperBound: 1.0,
      value: 0.0,
      curve: Curves.linear,
      reverseCurve: Curves.linear,
    );
  }

  MotionConfig copyWith({
    Duration? duration,
    double? lowerBound,
    double? upperBound,
    double? value,
    Duration? reverseDuration,
    Curve? curve,
    Curve? reverseCurve,
  }) {
    return MotionConfig(
      duration: duration ?? this.duration,
      reverseDuration: reverseDuration ?? this.reverseDuration,
      lowerBound: lowerBound ?? this.lowerBound,
      upperBound: upperBound ?? this.upperBound,
      value: value ?? this.value,
      curve: curve ?? this.curve,
      reverseCurve: reverseCurve ?? this.reverseCurve,
    );
  }
}

final class MotionEntry {

  final GlobalKey<MotionState> state;
  final Motion Function(Widget child) builder;

  MotionEntry({required this.builder, required this.state});

  Widget wrap(Widget child) => builder(child);

}

abstract class Motion extends StatefulWidget {
  const Motion({
    this.child,
    super.key,
  });

  MotionEntry call();

  final Widget? child;
}

abstract class MotionState extends State<Motion> with SingleTickerProviderStateMixin {

  String get name;

  @protected
  AnimationController? controller;

  @protected
  Animation<double>? animation;

  MotionConfig _config = MotionConfig.defaultConfig();

  MotionConfig get config => _config;

  @override
  void initState() {
    super.initState();
    _init(_config);
  }

  void _init(MotionConfig config) {

    controller ??= AnimationController(
        vsync: this,
      );

    controller
      ?..duration = config.duration
      ..reverseDuration = config.reverseDuration
      ..value = config.value;

    animation = CurvedAnimation(
      parent: controller!,
      curve: config.curve,
      reverseCurve: config.reverseCurve,
    );

    controller?.repeat(period: config.duration);

  }

  void updateConfig(MotionConfig config) => _init(_config = config);

  Widget buildControlPanel(BuildContext context, MotionEntry entry);

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

}
