import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion/editor/panel/widgets/motion_default_control.dart';
import 'package:motion/motion_manager.dart';
import 'package:motion/shared/ui/forms/curve_picker.dart';
import 'package:motion/shared/ui/forms/ui_checkbox.dart';
import 'package:motion/shared/ui/forms/ui_textfield.dart';

class MotionConfig {
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

extension MotionEntryExtension on MotionEntry {
  MotionState? get currentState => state.currentState;
  String? get name => currentState?.widget.name;
}

abstract class Motion extends StatefulWidget {
  const Motion({
    this.child,
    super.key,
  });

  MotionEntry call();

  final Widget? child;

  String get name;
}

abstract class MotionState extends State<Motion>
    with SingleTickerProviderStateMixin {
  @protected
  AnimationController? controller;

  @protected
  Animation<double>? animation;

  MotionConfig _config = MotionConfig.defaultConfig();

  MotionConfig get config => _config;

  set config(covariant MotionConfig value) => _config = value;

  @override
  void initState() {
    super.initState();
    _initialize(config);
  }

  void _initialize(MotionConfig config) {
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

  void updateConfig(MotionConfig config) => _initialize(this.config = config);

  Widget buildControlPanel(BuildContext context, MotionEntry entry) =>
      MotionDefaultControl(entry: entry);

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
