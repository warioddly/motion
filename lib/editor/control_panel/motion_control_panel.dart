import 'package:flutter/material.dart';
import 'package:motion/core/utils/mixins/post_frame_callback_mixin.dart';
import 'package:motion/motion_manager.dart';
import 'package:motion/motions/_motion.dart';

class MotionControlPanel extends StatelessWidget {
  const MotionControlPanel({super.key});

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
                itemCount: MotionManager.instance.entries.length,
                itemBuilder: (_, index) {
                  final entry = MotionManager.instance.entries[index];
                  return MotionControl(entry: entry);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class MotionControl extends StatefulWidget {
  const MotionControl({super.key, required this.entry});

  final MotionEntry entry;

  @override
  State<MotionControl> createState() => _MotionControlState();
}

class _MotionControlState extends State<MotionControl>
    with PostFrameCallbackMixin {

  @override
  Widget build(BuildContext context) {
    final state = widget.entry.state.currentState;
    return state?.buildControlPanel(context, widget.entry) ?? SizedBox.shrink();
  }

  @override
  void onPostFrameCallback(timeStamp) {
    setState(() {});
  }
}
