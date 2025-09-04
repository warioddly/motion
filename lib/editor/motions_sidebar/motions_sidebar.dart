
import 'package:flutter/material.dart';
import 'package:motion/motion_manager.dart';
import 'package:motion/motions/rotate_motion.dart';
import 'package:motion/motions/shake_motion.dart';

class MotionsSidebar extends StatelessWidget {
  const MotionsSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    
    final motions = {
      "Rotate": RotateMotion(),
      "Shake": ShakeMotion(),
    };
    
    return Container(
      width: 300,
      color: Colors.greenAccent,
      child: Scaffold(
        body: Scrollbar(
          child: ListView.builder(
            primary: true,
            itemCount: motions.values.length,
            itemBuilder: (context, index) {
              final motion = motions.values.elementAt(index);
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
                    child: Center(
                      child: Text(
                        motions.keys.elementAt(index),
                        textAlign: TextAlign.center,
                      ),
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
