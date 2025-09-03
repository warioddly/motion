import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:motion/motion_manager.dart';
import 'package:motion/motions/_motion.dart';
import 'package:motion/motions/rotate_motion.dart';


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
                  return Dismissible(
                    key: Key(motion.runtimeType.toString()),
                    onDismissed: (direction) {
                      MotionManager.instance.unregister(motion);
                    },
                    background: Container(color: Colors.red),
                    child: AnimationControl(
                      entry: motion,
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

class AnimationControl extends StatefulWidget {
  const AnimationControl({super.key, required this.entry});
  
  final MotionEntry entry;

  @override
  State<AnimationControl> createState() => _AnimationControlState();
}

class _AnimationControlState extends State<AnimationControl> {

  MotionEntry get entry => widget.entry;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Duration (ms)'),
            onChanged: (value) {
              final ms = int.tryParse(value);
              if (ms != null) {

                final state = entry.state.currentState;

                log("AnimationController: "
                    "duration=${state?.controller?.duration}, "
                );

                state?.updateConfig(
                    state.config.value.copyWith(
                        duration: Duration(milliseconds: ms)
                    )
                );

                state?.setState(() {});
              }
            },
          ),
          TextField(),

        ],
      ),
    );
  }

}
