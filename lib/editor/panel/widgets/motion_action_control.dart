import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion/motion_manager.dart';
import 'package:motion/motions/_motion.dart';

class MotionActionControl extends StatelessWidget {
  const MotionActionControl({super.key, required this.entry});

  final MotionEntry entry;

  @override
  Widget build(BuildContext context) {
    return Row(
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
          onPressed: () => MotionManager.instance.unregister(entry),
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}
