

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion/motion_manager.dart';
import 'package:motion/motions/_motion.dart';
import 'package:motion/shared/ui/forms/curve_picker.dart';
import 'package:motion/shared/ui/forms/ui_checkbox.dart';
import 'package:motion/shared/ui/forms/ui_textfield.dart';

class MotionDefaultControl extends StatelessWidget {
  const MotionDefaultControl({super.key, required this.entry});

  final MotionEntry entry;

  @override
  Widget build(BuildContext context) {
    final currentState = entry.currentState;
    assert(currentState != null, 'MotionState is null');
    final config = currentState!.config;
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
                  entry.name ?? '',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                IconButton(
                  tooltip: 'Hide',
                  visualDensity: VisualDensity.compact,
                  onPressed: () => MotionManager.instance.unregister(entry),
                  icon: Icon(CupertinoIcons.eye_slash),
                ),
                IconButton(
                  tooltip: "Delete",
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    MotionManager.instance.unregister(entry);
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            UiTextfield(
              initialText: config.duration.inMilliseconds.toString(),
              labelText: 'Duration (ms)',
              onChanged: (value) {
                final ms = int.tryParse(value);
                if (ms != null) {
                  currentState.updateConfig(
                    config.copyWith(duration: Duration(milliseconds: ms)),
                  );
                }
              },
            ),
            UICurvePicker(
              selected: config.curve,
              onChanged: (curve) {
                currentState.updateConfig(config.copyWith(curve: curve));
              },
            ),
            UICheckbox(
              size: 16,
              value: true,
              label: Text("Repeat"),
              onChanged: (bool value) {  },
            ),
          ],
        ),
      ),
    );
  }
}
