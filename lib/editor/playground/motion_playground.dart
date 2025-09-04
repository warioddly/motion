import 'package:flutter/material.dart';
import 'package:motion/editor/playground/motion_target.dart';
import 'package:motion/motion_manager.dart';
import 'package:motion/motions/_motion.dart';
import 'package:motion/shared/ui/layouts/grid_background.dart';

class MotionPlayground extends StatelessWidget {
  const MotionPlayground({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = MotionManager.instance;
    return Expanded(
      child: GridBackground(
        child: RepaintBoundary(
          child: DragTarget<MotionFactory>(
            onAccept: manager.register,
            builder: (context, _, __) {
              return ListenableBuilder(
                listenable: manager,
                builder: (_, __) => manager.entries.fold<Widget>(
                  const MotionTarget(),
                  (previous, MotionEntry motion) => motion.builder(previous),
                )
              );
            },
          ),
        ),
      ),
    );
  }
}
