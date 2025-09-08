import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:motion/_motion_entry.dart';
import 'package:motion/motions/_motion.dart';

typedef MotionFactory = MotionEntry Function();

final class MotionManager extends ChangeNotifier {
  static final MotionManager _instance = MotionManager._internal();

  static MotionManager get instance => _instance;

  MotionManager._internal();

  final List<MotionEntry> _entries = [];

  void register(MotionFactory entry) {
    _entries.add(entry());
    notifyListeners();
  }

  void unregister(MotionState state) {
    _entries.removeWhere((e) => identical(e.state.currentState, state));
    notifyListeners();
  }

  void clearAll() {
    _entries.clear();
    notifyListeners();
  }

  List<MotionEntry> get entries => List.unmodifiable(_entries);

}
