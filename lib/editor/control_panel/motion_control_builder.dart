import 'package:flutter/material.dart';
import 'package:motion/_motion_entry.dart';

class MotionControlBuilder extends StatelessWidget {
  const MotionControlBuilder({super.key, required this.entry});

  final MotionEntry entry;

  @override
  Widget build(BuildContext context) {
    return entry.currentState?.buildControlPanel(context) ?? SizedBox.shrink();
  }
}
