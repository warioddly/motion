import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';
import 'package:motion/_motion_entry.dart';
import 'package:motion/motions/_motion_config.dart';
import 'package:motion/motions/_motion_control.dart';


abstract class Motion extends StatefulWidget {
  const Motion({
    this.child,
    super.key,
  });

  final Widget? child;

  String get name;

  MotionEntry call();
}

abstract class MotionState extends State<Motion> with SingleTickerProviderStateMixin {
  /// TODO: Все это вынести в отдельный класс контроллер
  @protected
  AnimationController? animationController;

  @protected
  Animation<double>? animation;

  ValueListenable get listenable => animationController!;

  MotionConfig _config = MotionConfig.defaultConfig();

  MotionConfig get config => _config;

  set config(covariant MotionConfig value) => _config = value;

  MotionControl get controlPanel => MotionDefaultControl(this);

  @override
  void initState() {
    super.initState();
    _initialize(config);
  }

  void _initialize(MotionConfig config) {
    animationController ??= AnimationController(
      vsync: this,
    );

    animationController
      ?..duration = config.duration
      ..reverseDuration = config.reverseDuration
      ..value = config.value;

    animation = CurvedAnimation(
      parent: animationController!,
      curve: config.curve,
      reverseCurve: config.reverseCurve,
    );

    animationController?.repeat(
      period: config.duration,
    );
  }

  void updateConfig(covariant MotionConfig config) {
    _initialize(this.config = config);
  }

  void pause() {
    animationController?.stop();
  }

  void resume() {
    _initialize(config);
  }

  Widget buildControlPanel(BuildContext context) => controlPanel;

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}
