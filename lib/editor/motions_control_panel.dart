import 'package:flutter/material.dart';
import 'package:motion/_motion_entry.dart';
import 'package:motion/editor/motion_group_control.dart';
import 'package:motion/_motion_manager.dart';
import 'package:motion/shared/ui/constants/dimensions.dart';

class MotionsControlPanel extends StatelessWidget {
  const MotionsControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spaces.s,
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
                      return entry.buildControlPanel(context) ?? SizedBox.shrink();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
