import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion/_motion_manager.dart';
import 'package:motion/motions/_motion.dart';
import 'package:motion/motions/_motion_config.dart';
import 'package:motion/shared/ui/constants/dimensions.dart';
import 'package:motion/shared/ui/forms/ui_checkbox.dart';
import 'package:motion/shared/ui/forms/ui_curve_picker.dart';
import 'package:motion/shared/ui/forms/ui_textfield.dart';

abstract class MotionControl<T extends Motion, Config extends MotionConfig> extends StatelessWidget {
  const MotionControl(this.state, {super.key});

  final MotionState<T, Config> state;

  Config get config => state.config;

  void updateConfig(Config config) => state.updateConfig(config);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Insets.sm.copyWith(bottom: 0),
      child: Padding(
        padding: Insets.sm,
        child: Column(
          spacing: Dimensions.s,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            ...fields(context),
            ListenableBuilder(
              listenable: state.listenable,
              builder: (_, __) => LinearProgressIndicator(
                value: state.listenable.value.clamp(0.0, 1.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> fields(BuildContext context);

  Widget buildHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          state.widget.name,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Spacer(),
        IconButton(
          tooltip: 'Hide',
          visualDensity: VisualDensity.compact,
          onPressed: () {
            state.pause();
          },
          icon: Icon(CupertinoIcons.eye_slash),
        ),
        IconButton(
          tooltip: "Delete",
          visualDensity: VisualDensity.compact,
          onPressed: () {
            MotionManager.instance.unregister(state);
          },
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}

class MotionDefaultControl extends MotionControl {
  const MotionDefaultControl(super.state, {super.key});

  @override
  List<Widget> fields(BuildContext context) {
    return [
      UiTextfield(
        initialText: config.duration.inMilliseconds.toString(),
        labelText: 'Duration (ms)',
        onChanged: (value) {
          final ms = int.tryParse(value);
          if (ms != null) {
            state.updateConfig(config.copyWith(duration: Duration(milliseconds: ms)));
          }
        },
      ),
      UiTextfield(
        initialText: config.startDelay.inMilliseconds.toString(),
        labelText: 'Start Delay Duration (ms)',
        onChanged: (value) {
          final ms = int.tryParse(value);
          if (ms != null) {
            state.updateConfig(config.copyWith(startDelay: Duration(milliseconds: ms)));
          }
        },
      ),
      UICurvePicker(
        selected: config.curve,
        onChanged: (curve) {
          state.updateConfig(config.copyWith(curve: curve));
        },
      ),
      UICheckbox(
        value: config.reverse,
        label: Text("Reverse"),
        onChanged: (bool value) {
          state.updateConfig(config.copyWith(reverse: !config.reverse));
        },
      ),
      UICheckbox(
        value: config.repeat,
        label: Text("Repeat"),
        onChanged: (bool value) {
          state.updateConfig(config.copyWith(repeat: !config.repeat));
        },
      ),
    ];
  }
}
