import 'package:flutter/material.dart';

abstract class Config {
  const Config();

  Duration get duration => const Duration(milliseconds: 500);

  Curve get curve => Curves.easeInOut;

  Curve get reverseCurve => Curves.easeInOut;

  bool get repeat => false;

  bool get reverse => false;

  double get upperBound => 1.0;

  double get lowerBound => 0.0;

}