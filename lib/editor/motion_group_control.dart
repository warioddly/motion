import 'package:flutter/material.dart';
import 'package:motion/_motion_manager.dart';
import 'package:motion/shared/ui/constants/dimensions.dart';

class MotionGroupControl extends StatelessWidget {
  const MotionGroupControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Insets.smHorizontal,
      child: Padding(
        padding: Insets.sxHorizontal + Insets.xsVertical,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: Dimensions.s,
          children: [
            IconButton(
              tooltip: "Play",
              onPressed: () {},
              icon: Icon(Icons.play_arrow),
            ),
            // IconButton(
            //   tooltip: "Repeat",
            //   onPressed: () {},
            //   icon: Icon(Icons.repeat),
            // ),
            IconButton(
              tooltip: "Reset",
              onPressed: MotionManager.instance.clearAll,
              icon: Icon(Icons.restart_alt),
            ),
            IconButton(
              tooltip: "Source code",
              onPressed: () {},
              icon: Icon(Icons.code),
            )
          ],
        ),
      ),
    );
  }
}
