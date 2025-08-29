import 'package:flutter/material.dart';
import 'package:motion/motion_manager.dart';
import 'package:motion/motions.dart';

class AnimationEditorContent extends StatefulWidget {
  const AnimationEditorContent({super.key});

  @override
  State<AnimationEditorContent> createState() => _AnimationEditorContentState();
}

class _AnimationEditorContentState extends State<AnimationEditorContent> {
  Color caughtColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.red,
        child: DragTarget<MotionType>(
          onAccept: MotionManager.instance.register,
          builder: (context, candidateData, rejectedData) {
            return Container(
              color: caughtColor,
              child: ListenableBuilder(
                listenable: MotionManager.instance,
                builder: (context, _) {
                  print(
                    'MotionManager.instance.motions ${MotionManager.instance.motions}',
                  );
                  return Container(
                    child: MotionManager.instance.motions.fold<Widget>(
                      Center(
                        child: Container(
                          width: 200,
                          height: 200,
                          color: Colors.blue.withOpacity(0.7),
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
                          (previous, motionType) =>
                          motionType.createMotion(previous),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}