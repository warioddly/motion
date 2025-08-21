import 'package:flutter/material.dart';

abstract class MotionConfig {
  const MotionConfig();

  Duration get duration => const Duration(milliseconds: 500);

  Curve get curve => Curves.easeInOut;

  Curve get reverseCurve => Curves.easeInOut;

  bool get repeat => false;

  bool get reverse => false;

  double get upperBound => 1.0;

  double get lowerBound => 0.0;

}

final class MotionConfigDefault extends MotionConfig {
  const MotionConfigDefault();

  @override
  Duration get duration => const Duration(milliseconds: 500);

  @override
  Curve get curve => Curves.easeInOut;

  @override
  Curve get reverseCurve => Curves.easeInOut;

  @override
  bool get repeat => false;

  @override
  bool get reverse => false;

  @override
  double get upperBound => 1.0;

  @override
  double get lowerBound => 0.0;

}

final class ShakeMotionConfig extends MotionConfig {
  const ShakeMotionConfig();

  @override
  Duration get duration => const Duration(milliseconds: 500);

  @override
  Curve get curve => Curves.linear;

  @override
  Curve get reverseCurve => Curves.linear;

  @override
  bool get repeat => true;

  @override
  bool get reverse => false;

  @override
  double get upperBound => 1.0;

  @override
  double get lowerBound => -1.0;

}
