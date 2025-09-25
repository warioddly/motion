import 'package:flutter/material.dart';
import 'package:motion/_motion_entry.dart';
import 'package:motion/motions/_motion.dart';
import 'package:motion/motions/_motion_control.dart';
import 'package:motion/shared/ui/constants/dimensions.dart';
import 'package:motion/shared/ui/forms/ui_curve_picker.dart';
import 'package:motion/shared/ui/forms/ui_textfield.dart';

class ScaleMotion extends Motion {
  const ScaleMotion({super.child, super.key});

  @override
  MotionState createState() => _ScaleMotionState();

  @override
  MotionEntry call() {
    final globalKey = GlobalKey<MotionState>();
    return MotionEntry(
      builder: (child) => ScaleMotion(
        key: globalKey,
        child: child,
      ),
      state: globalKey,
    );
  }

  @override
  String get name => 'Scale Motion';
}

class _ScaleMotionState extends MotionState {
  @override
  MotionControl get controlPanel => ScaleMotionControl(this);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: Tween<double>(
            begin: config.lowerBound,
            end: config.upperBound,
          ).animate(animation).value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class ScaleMotionControl extends MotionControl {
  const ScaleMotionControl(super.state, {super.key});

  @override
  List<Widget> fields(BuildContext context) {
    return [
      UiTextfield(
        initialText: config.duration.inMilliseconds.toString(),
        labelText: 'Duration (ms)',
        onChanged: (value) {
          final ms = int.tryParse(value);
          if (ms != null) {
            updateConfig(config.copyWith(duration: Duration(milliseconds: ms)));
          }
        },
      ),
      UiTextfield(
        initialText: config.startDelay.inMilliseconds.toString(),
        labelText: 'Start Delay Duration (ms)',
        onChanged: (value) {
          final ms = int.tryParse(value);
          if (ms != null) {
            updateConfig(config.copyWith(startDelay: Duration(milliseconds: ms)));
          }
        },
      ),
      Row(
        children: [
          Flexible(
            child: UiTextfield(
              initialText: config.lowerBound.toString(),
              labelText: 'From',
              onChanged: (value) {
                state.updateConfig(
                  config.copyWith(
                    lowerBound: double.tryParse(value),
                  ),
                );
              },
            ),
          ),
          Spaces.s,
          Flexible(
            child: UiTextfield(
              initialText: config.upperBound.toString(),
              labelText: 'To',
              onChanged: (value) {
                updateConfig(
                  config.copyWith(
                    upperBound: double.tryParse(value),
                  ),
                );
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
