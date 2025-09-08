import 'package:flutter/material.dart' show Widget, GlobalKey;
import 'package:motion/motions/_motion.dart';

final class MotionEntry {

  final GlobalKey<MotionState> state;
  final Motion Function(Widget child) builder;

  const MotionEntry({required this.builder, required this.state});

  Widget wrap(Widget child) => builder(child);

}

extension MotionEntryExtension on MotionEntry {

  MotionState? get currentState => state.currentState;

  String? get name => currentState?.widget.name;

}