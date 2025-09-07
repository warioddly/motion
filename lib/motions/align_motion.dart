import 'package:flutter/material.dart';
import 'package:motion/editor/panel/widgets/motion_action_control.dart';
import 'package:motion/motions/_motion.dart';
import 'package:motion/shared/ui/forms/curve_picker.dart';
import 'package:motion/shared/ui/forms/ui_textfield.dart';

class AlignMotionConfig extends MotionConfig {
  final double dx;
  final double dy;

  const AlignMotionConfig({
    required super.duration,
    required super.lowerBound,
    required super.upperBound,
    required super.value,
    required super.reverseDuration,
    required super.curve,
    required super.reverseCurve,
    required this.dx,
    required this.dy,
  });

  factory AlignMotionConfig.defaultConfig() {
    return AlignMotionConfig(
      duration: Durations.medium3,
      reverseDuration: Durations.medium3,
      lowerBound: 0.0,
      upperBound: 1.0,
      value: 0.0,
      curve: Curves.linear,
      reverseCurve: Curves.linear,
      dx: 0.0,
      dy: 0.0,
    );
  }

  @override
  AlignMotionConfig copyWith({
    Duration? duration,
    double? lowerBound,
    double? upperBound,
    double? value,
    Duration? reverseDuration,
    Curve? curve,
    Curve? reverseCurve,
    double? dx,
    double? dy,
  }) {
    return AlignMotionConfig(
      duration: duration ?? this.duration,
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

class AlignMotion extends Motion {
  const AlignMotion({super.child, super.key});

  @override
  MotionState createState() => _AlignMotionState();

  @override
  String get name => 'Align Motion';

  @override
  MotionEntry call() {
    final globalKey = GlobalKey<MotionState>();
    return MotionEntry(
      builder: (child) => AlignMotion(
        key: globalKey,
        child: child,
      ),
      state: globalKey,
    );
  }
}

class _AlignMotionState extends MotionState {
  @override
  AlignMotionConfig config = AlignMotionConfig.defaultConfig();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            animation!.value * config.dx,
            animation!.value * config.dy,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  Widget buildControlPanel(BuildContext context, MotionEntry entry) {
    return Card(
      margin: EdgeInsets.all(12).copyWith(bottom: 0),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MotionActionControl(entry: entry),
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
            Row(
              spacing: 8,
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
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
