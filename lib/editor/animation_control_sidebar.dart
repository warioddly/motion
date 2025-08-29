import 'package:flutter/material.dart';
import 'package:motion/motion_manager.dart';


class AnimationControlSidebar extends StatelessWidget {
  const AnimationControlSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: MotionManager.instance,
      builder: (context, _) {
        return Container(
          width: 300,
          color: Colors.amberAccent,
          child: Scaffold(
            body: Scrollbar(
              child: ListView.builder(
                primary: true,
                itemCount: MotionManager.instance.motions.length,
                itemBuilder: (context, index) {
                  final motion = MotionManager.instance.motions[index];
                  return SizedBox(
                    height: 80,
                    child: Dismissible(
                      key: Key(motion.name),
                      onDismissed: (direction) {
                        MotionManager.instance.unregister(motion);
                      },
                      background: Container(color: Colors.red),
                      child: Center(child: Text(motion.name)),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
