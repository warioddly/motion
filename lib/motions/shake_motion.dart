import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:motion/core/constants/curves.dart';
import 'package:motion/motion_manager.dart';
import 'package:motion/motions/_motion.dart';

class ShakeMotion extends Motion {
  const ShakeMotion({super.child, super.key});

  @override
  MotionState createState() => _ShakeMotionState();

  @override
  MotionEntry call() {
    final globalKey = GlobalKey<MotionState>();
    return MotionEntry(
      builder: (child) => ShakeMotion(
        key: globalKey,
        child: child,
      ),
      state: globalKey,
    );
  }

}

class _ShakeMotionState extends MotionState {

  @override
  String get name => 'Shake Motion';

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: super.animation!,
      builder: (context, child) {
        double offset = math.sin((animation?.value ?? 1) * 2 * math.pi * 4) * 8;
        return Transform.translate(
          offset: Offset(offset, 0),
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
                Text(name),
                Spacer(),
                IconButton(
                  onPressed: () {
                    MotionManager.instance.unregister(entry);
                  },
                  icon: const Icon(Icons.delete),
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
            DropdownButton(
              items: allCurves
                  .map(
                    (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.name),
                ),
              )
                  .toList(),
              onChanged: (value) {
                updateConfig(config.copyWith(curve: value?.curve));
              },
            ),
          ],
        ),
      ),
    );
  }
}
