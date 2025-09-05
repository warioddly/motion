import 'package:flutter/material.dart';
import 'package:motion/core/utils/mixins/post_frame_callback_mixin.dart';
import 'package:motion/motions/_motion.dart';


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
    final state = widget.entry.currentState;
    print('widget.entry.currentState ${widget.entry.currentState}');
    return state?.buildControlPanel(context, widget.entry) ?? SizedBox.shrink();
  }

  @override
  void onPostFrameCallback(timeStamp) => setState(() {});
}
