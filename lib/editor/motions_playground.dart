import 'package:flutter/material.dart';
import 'package:motion/motion_manager.dart';
import 'package:motion/motions/_motion.dart';
import 'package:motion/shared/ui/layouts/grid_background.dart';

class MotionsPlayground extends StatelessWidget {
  const MotionsPlayground({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = MotionManager.instance;
    return Expanded(
      child: Stack(
        children: [
          
          Positioned.fill(
            child: GridBackground(
              child: RepaintBoundary(
                child: DragTarget<MotionFactory>(
                  onAccept: manager.register,
                  builder: (context, _, __) {
                    return ListenableBuilder(
                      listenable: manager,
                      builder: (_, __) => manager.entries.fold<Widget>(
                        const _MotionTarget(),
                        (previous, MotionEntry motion) => motion.builder(previous),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          
          // Positioned(
          //   top: 16,
          //   left: 0,
          //   right: 0,
          //   child: Center(
          //     child: Card(
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //         child: Row(
          //           mainAxisSize: MainAxisSize.min,
          //           spacing: 8,
          //           children: [
          //             IconButton(onPressed: () {} , icon: Icon(Icons.play_arrow)),
          //             IconButton(onPressed: () {} , icon: Icon(Icons.restart_alt))
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // )
          
        ],
      ),
    );
  }
}

class _MotionTarget extends StatelessWidget {
  const _MotionTarget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: 200,
        child: ColoredBox(
          color: Colors.blue,
          child: Center(
            child: const Text(
              "Drag a motion here",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
