import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';
import 'package:motion/editor/control_panel/motion_default_control.dart';
import 'package:motion/_motion_config.dart';
import 'package:motion/_motion_entry.dart';

abstract class Motion extends StatefulWidget {
  const Motion({
    this.child,
    super.key,
  });

  final Widget? child;

  String get name;

  MotionEntry call();
}

abstract class MotionState extends State<Motion>
    with SingleTickerProviderStateMixin {

  /// TODO: Все это вынести в отдельный класс контроллер
  @protected
  AnimationController? controller;

  ValueListenable get listenable => controller!;

  @protected
  Animation<double>? animation;

  MotionConfig _config = MotionConfig.defaultConfig();

  MotionConfig get config => _config;

  set config(covariant MotionConfig value) => _config = value;

  @override
  void initState() {
    super.initState();
    _initialize(config);
  }

  void _initialize(MotionConfig config) {
    controller ??= AnimationController(
      vsync: this,
    );

    controller
      ?..duration = config.duration
      ..reverseDuration = config.reverseDuration
      ..value = config.value;

    animation = CurvedAnimation(
      parent: controller!,
      curve: config.curve,
      reverseCurve: config.reverseCurve,
    );

    controller?.repeat(period: config.duration);
  }

  void updateConfig(covariant MotionConfig config) {
    _initialize(this.config = config);
  }

  void pause() {
    controller?.stop();
  }

  void resume() {
    _initialize(config);
  }

  Widget buildControlPanel(BuildContext context) => MotionDefaultControl(this);

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
