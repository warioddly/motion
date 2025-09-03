
import 'package:flutter/material.dart';
import 'package:motion/motions/_motion.dart';
import 'package:motion/motions/rotate_motion.dart';

typedef MotionFactory = MotionEntry Function();

class AnimationListSidebar extends StatelessWidget {
  const AnimationListSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final motions = [
      RotateMotion().create,
    ];
    return Container(
      width: 300,
      color: Colors.greenAccent,
      child: Scaffold(
        body: Scrollbar(
          child: ListView.builder(
            primary: true,
            itemCount: motions.length,
            itemBuilder: (context, index) {
              final motion = motions[index];
              return SizedBox(
                height: 80,
                child: Draggable<MotionFactory>(
                  data: motion,
                  feedback: Material(
                    child: Container(
                      height: 80,
                      color: Colors.blue.withOpacity(0.7),
                      child: const Center(child: Text("Drag")),
                    ),
                  ),
                  childWhenDragging: Container(
                    height: 80,
                    color: Colors.grey,
                    child: const Center(child: Text("Box")),
                  ),
                  child: SizedBox(
                    height: 80,
                    child: Text(
                      motion.runtimeType.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
