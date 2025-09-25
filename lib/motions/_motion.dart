import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';
import 'package:motion/_motion_entry.dart';
import 'package:motion/motions/_motion_config.dart';
import 'package:motion/motions/_motion_control.dart';


abstract class Motion extends StatefulWidget {
  const Motion({this.child, super.key});

  final Widget? child;

  String get name;

  MotionEntry call();
}

mixin MotionConfigurable<T extends StatefulWidget, Config extends MotionConfig> on State<T> {

  late Config _config = defaultConfig();

  Config get config => _config;

  void updateConfig(covariant Config config) {
    if (identical(_config, config)) return;
    _config = config;
    onConfigUpdated(config);
  }

  @protected
  Config defaultConfig() => MotionConfig.defaultConfig() as Config;

  @protected
  void onConfigUpdated(covariant Config config);

}

mixin MotionAnimatable<T extends Motion, Config extends MotionConfig> on SingleTickerProviderStateMixin<T> {
  AnimationController? animationController;

  late Animation<double> animation;

  ValueListenable<double> get listenable => animationController!;

  void pause() => animationController?.stop();

  void resume() => animationController?.forward();

  void reset() => animationController?.reset();

  @protected
  void _initializeAnimation(covariant Config config) {
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

    if (config.repeat) {
      animationController?.repeat(reverse: config.reverse);
    }
    else {
      if (config.reverse) {
        animationController?.reverse(from: config.upperBound);
      } else {
        animationController?.forward(from: config.lowerBound);
      }
    }
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}

mixin MotionControllable<T extends StatefulWidget> on State<T> {
  MotionControl get controlPanel;

  Widget buildControlPanel(BuildContext context) => controlPanel;
}

abstract class MotionState<T extends Motion, Config extends MotionConfig> extends State<T>
    with
        SingleTickerProviderStateMixin,
        MotionConfigurable<T, Config>,
        MotionAnimatable,
        MotionControllable {

  @override
  MotionControl get controlPanel => MotionDefaultControl(this);

  @protected
  @override
  void initState() {
    super.initState();
    _initializeAnimation(config);
  }

  @override
  void onConfigUpdated(covariant Config config) {
    _initializeAnimation(config);
  }

}
