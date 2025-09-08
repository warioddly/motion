import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion/_motion_config.dart';
import 'package:motion/_motion_manager.dart';
import 'package:motion/motions/_motion.dart';
import 'package:motion/shared/ui/forms/ui_curve_picker.dart';
import 'package:motion/shared/ui/forms/ui_checkbox.dart';
import 'package:motion/shared/ui/forms/ui_textfield.dart';

class MotionDefaultControl extends StatelessWidget {
  const MotionDefaultControl(this.state, {super.key});

  final MotionState state;

  MotionConfig get _config => state.config;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12).copyWith(bottom: 0),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
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
            ),
            UiTextfield(
              initialText: _config.duration.inMilliseconds.toString(),
              labelText: 'Duration (ms)',
              onChanged: (value) {
                final ms = int.tryParse(value);
                if (ms != null) {
                  state.updateConfig(
                    _config.copyWith(duration: Duration(milliseconds: ms)),
                  );
                }
              },
            ),
            TextField(
              controller: TextEditingController()
                ..text = _config.startDelay.inMilliseconds.toString(),
              decoration: const InputDecoration(labelText: 'Start Delay Duration (ms)'),
              onChanged: (value) {
                final ms = int.tryParse(value);
                if (ms != null) {
                  state.updateConfig(
                    _config.copyWith(
                      duration: Duration(milliseconds: ms),
                    ),
                  );
                }
              },
            ),
            UICurvePicker(
              selected: _config.curve,
              onChanged: (curve) {
                state.updateConfig(_config.copyWith(curve: curve));
              },
            ),
            UICheckbox(
              size: 16,
              value: true,
              label: Text("Repeat"),
              onChanged: (bool value) {},
            ),
            ListenableBuilder(
              listenable: state.listenable,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: state.listenable.value.clamp(0.0, 1.0),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
