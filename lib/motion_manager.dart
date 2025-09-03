import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:motion/editor/animation_list_sidebar.dart';
import 'package:motion/motions/_motion.dart';

final class MotionManager extends ChangeNotifier {
  static final MotionManager _instance = MotionManager._internal();

  static MotionManager get instance => _instance;

  MotionManager._internal();

  final List<MotionEntry> _motions = [];

  void register(MotionFactory entry) {
    _motions.add(entry());
    notifyListeners();
  }

  void unregister(MotionEntry entry) {
    _motions.remove(entry);
    notifyListeners();
  }

  List<MotionEntry> get motions => List.unmodifiable(_motions);

}
