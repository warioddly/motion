import 'package:flutter/material.dart';
import 'package:motion/editor/control_panel/motion_control_builder.dart';
import 'package:motion/editor/control_panel/motion_group_control.dart';
import 'package:motion/_motion_manager.dart';

class MotionsControlPanel extends StatelessWidget {
  const MotionsControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ColoredBox(
        color: Colors.amberAccent,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 8),
              MotionGroupControl(),
              Expanded(
                child: ListenableBuilder(
                  listenable: MotionManager.instance,
                  builder: (_, Widget? child) {
                    return ListView.builder(
                      primary: true,
                      itemCount: MotionManager.instance.entries.length,
                      itemBuilder: (_, index) {
                        final entry = MotionManager.instance.entries[index];
                        return MotionControlBuilder(entry: entry);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
