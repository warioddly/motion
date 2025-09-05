import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion/motion_manager.dart';
import 'package:motion/motions/_motion.dart';
import 'package:motion/shared/ui/forms/curve_picker.dart';

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

  @override
  String get name => 'Align Motion';
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
              animation!.value * config.dx, animation!.value * config.dy),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  widget.name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                IconButton(
                  tooltip: 'Hide animation',
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    MotionManager.instance.unregister(entry);
                  },
                  icon: const Icon(CupertinoIcons.eye_slash, size: 16),
                ),
                IconButton(
                  tooltip: 'Delete',
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    MotionManager.instance.unregister(entry);
                  },
                  icon: const Icon(Icons.close, size: 16),
                ),
              ],
            ),
            SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              controller: TextEditingController()
                ..text = config.duration.inMilliseconds.toString(),
              decoration: const InputDecoration(labelText: 'Duration (ms)'),
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
            SizedBox(height: 8),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: TextEditingController()..text = config.dx.toString(),
                    decoration: const InputDecoration(labelText: 'X'),
                    onChanged: (value) {
                      final dx = double.tryParse(value);
                      updateConfig(config.copyWith(dx: dx));
                    },
                  ),
                ),
                SizedBox(width: 8),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: TextEditingController()..text = config.dy.toString(),
                    decoration: const InputDecoration(labelText: 'Y'),
                    onChanged: (value) {
                      final dy = double.tryParse(value);
                      updateConfig(config.copyWith(dy: dy));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            UICurvePicker(
              selected: config.curve,
              onChanged: (curve) {
                updateConfig(config.copyWith(curve: curve));
                setState(() { });
              },
            ),
          ],
        ),
      ),
    );
  }
}
