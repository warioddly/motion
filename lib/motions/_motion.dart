import 'dart:developer';

import 'package:flutter/material.dart';

final class MotionConfig {
  final Duration duration;
  final double lowerBound;
  final double upperBound;
  final double value;
  final Duration reverseDuration;

  const MotionConfig({
    required this.duration,
    required this.lowerBound,
    required this.upperBound,
    required this.value,
    required this.reverseDuration,
  });

  factory MotionConfig.defaultConfig() {
    return MotionConfig(
      duration: Durations.medium3,
      reverseDuration: Durations.medium3,
      lowerBound: 0.0,
      upperBound: 1.0,
      value: 0.0,
    );
  }

  MotionConfig copyWith({
    Duration? duration,
    double? lowerBound,
    double? upperBound,
    double? value,
    Duration? reverseDuration,
  }) {
    return MotionConfig(
      duration: duration ?? this.duration,
      reverseDuration: reverseDuration ?? this.reverseDuration,
      lowerBound: lowerBound ?? this.lowerBound,
      upperBound: upperBound ?? this.upperBound,
      value: value ?? this.value,
    );
  }
}

class MotionEntry {

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

  MotionEntry create();

  final Widget? child;
}

abstract class MotionState extends State<Motion> with SingleTickerProviderStateMixin {
  AnimationController? controller;

  final config = ValueNotifier(MotionConfig.defaultConfig());

  @override
  void initState() {
    super.initState();
    _init(config.value);
  }

  void _init(MotionConfig config) {

    final oldController = controller;

    controller = AnimationController(
      vsync: this,
      duration: config.duration,
      reverseDuration: config.reverseDuration,
      lowerBound: config.lowerBound,
      upperBound: config.upperBound,
      value: config.value,
    );

    oldController?.dispose();

    controller?.repeat(
      reverse: true,
      period: config.duration,
    );

  }


  void updateConfig(MotionConfig config) {
    this.config.value = config;
    log('awdawdawdawd');
    _init(config);
    setState(() { });

  }

  @override
  void dispose() {
    controller?.dispose();
    config.dispose();
    super.dispose();
  }
}
