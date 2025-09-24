import 'package:flutter/material.dart';
import 'package:motion/_motion_manager.dart';
import 'package:motion/motions/align_motion.dart';
import 'package:motion/motions/flip_motion.dart';
import 'package:motion/motions/opacity_motion.dart';
import 'package:motion/motions/rotate_motion.dart';
import 'package:motion/motions/scale_motion.dart';
import 'package:motion/motions/shake_motion.dart';
import 'package:motion/motions/swing_motion.dart';
import 'package:motion/motions/tilt_motion.dart';
import 'package:motion/motions/wave_motion.dart';
import 'package:motion/shared/ui/constants/dimensions.dart';
import 'package:motion/shared/ui/theme/ui_theme.dart';

const _sidebarWidth = 300.0;

class MotionsSidebar extends StatelessWidget {
  const MotionsSidebar({super.key});

  static const _motions = [
    RotateMotion(),
    ShakeMotion(),
    AlignMotion(),
    ScaleMotion(),
    OpacityMotion(),
    FlipMotion(),
    SwingMotion(),
    WaveMotion(),
    TiltMotion(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _sidebarWidth,
      color: Colors.greenAccent,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: false,
              title: Text("Motion"),
            ),
            SliverToBoxAdapter(
              child: Divider(),
            ),
            SliverList.builder(
              itemCount: _motions.length,
              itemBuilder: (context, index) {
                final motion = _motions[index];
                return Draggable<MotionFactory>(
                  data: motion.call,
                  feedback: MouseRegion(
                    cursor: SystemMouseCursors.move,
                    child: Theme(
                      data: UITheme.theme,
                      child: Card(
                        color: Theme.of(context).colorScheme.surfaceContainerLow,
                        shadowColor: Colors.black,
                        elevation: 4,
                        margin: Insets.smHorizontal + Insets.xsVertical,
                        child: SizedBox(
                          height: 40,
                          width: _sidebarWidth - 24,
                          child: Center(child: Text(motion.name)),
                        ),
                      ),
                    ),
                  ),
                  childWhenDragging: Card(
                    margin: Insets.smHorizontal + Insets.xsVertical,
                    child: ListTile(
                      dense: true,
                      title: Text(motion.name),
                    ),
                  ),
                  child: Card(
                    margin: Insets.smHorizontal + Insets.xsVertical,
                    child: ListTile(
                      dense: true,
                      title: Text(motion.name),
                      trailing: IconButton(
                        onPressed: () {
                          MotionManager.instance.register(motion.call);
                        },
                        icon: Icon(Icons.add_rounded),
                      ),
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
