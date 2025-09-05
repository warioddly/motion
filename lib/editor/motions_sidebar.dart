import 'package:flutter/material.dart';
import 'package:motion/motion_manager.dart';
import 'package:motion/motions/align_motion.dart';
import 'package:motion/motions/rotate_motion.dart';
import 'package:motion/motions/shake_motion.dart';

const _sidebarWidth = 300.0;

class MotionsSidebar extends StatelessWidget {
  const MotionsSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final motions = [RotateMotion(), ShakeMotion(), AlignMotion()];

    return Container(
      width: _sidebarWidth,
      color: Colors.greenAccent,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [

            SliverAppBar(
              centerTitle: false,
              title: Text("Motions"),
            ),

            SliverList.builder(
              itemCount: motions.length,
              itemBuilder: (context, index) {
                final motion = motions.elementAt(index);
                return Draggable<MotionFactory>(
                  data: motion.call,
                  feedback: Material(
                    child: Container(
                      height: 46,
                      width: _sidebarWidth,
                      color: Colors.blue.withOpacity(0.7),
                      child: Center(child: Text(motion.name)),
                    ),
                  ),
                  childWhenDragging: ListTile(
                    title: Text("Box"),
                  ),
                  child: ListTile(
                    title: Text(motion.name),
                    trailing: IconButton(
                      onPressed: () {
                        MotionManager.instance.register(motion.call);
                      },
                      icon: Icon(Icons.add),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
