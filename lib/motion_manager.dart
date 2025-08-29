
import 'package:flutter/foundation.dart' show ChangeNotifier;

import 'motions.dart' show MotionType;

final class MotionManager extends ChangeNotifier {
  static final MotionManager _instance = MotionManager._internal();

  static MotionManager get instance => _instance;

  MotionManager._internal();

  final List<MotionType> _pausedMotions = [];
  final List<MotionType> _motions = [];

  void register(MotionType motion) {
    _motions.add(motion);
    notifyListeners();
  }

  void unregister(MotionType motion) {
    _motions.remove(motion);
    notifyListeners();
  }

  void pause(MotionType motion) {
    if (_motions.contains(motion)) {
      _pausedMotions.add(motion);
      notifyListeners();
    }
  }

  void resume(MotionType motion) {
    if (_pausedMotions.contains(motion)) {
      _pausedMotions.remove(motion);
      notifyListeners();
    }
  }

  List<MotionType> get motions => List.unmodifiable(_motions);

}
