import 'package:flutter/material.dart';
import 'package:motion/motion_manager.dart';


class MotionGroupControl extends StatelessWidget {
  const MotionGroupControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 8,
          children: [
            IconButton(
              tooltip: "Play",
              onPressed: () {},
              icon: Icon(Icons.play_arrow),
            ),
            IconButton(
              tooltip: "Repeat",
              onPressed: () {},
              icon: Icon(Icons.repeat),
            ),
            IconButton(
              tooltip: "Reset",
              onPressed: () =>
                  MotionManager.instance.entries.forEach(
                    MotionManager.instance.unregister,
                  ),
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
