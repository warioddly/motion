import 'package:flutter/material.dart';
import 'package:motion/motion_manager.dart';
import 'package:motion/shared/ui/forms/curve_picker.dart';

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

abstract class Motion extends StatefulWidget {
  const Motion({
    this.child,
    super.key,
  });

  MotionEntry call();

  final Widget? child;

  String get name;

}

abstract class MotionState extends State<Motion> with SingleTickerProviderStateMixin {


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
            CurvePicker(
              selected: config.curve,
              onChanged: (curve) {
                updateConfig(config.copyWith(curve: curve));
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

}
