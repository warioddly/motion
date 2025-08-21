import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion/motions.dart';

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

  List<MotionType> get pausedMotions => List.unmodifiable(_pausedMotions);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      scrollBehavior: CupertinoScrollBehavior(),
      home: const Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AnimationSidebar(),
            Content(),
            AnimationControlSidebar(),
          ],
        ),
      ),
    );
  }
}

class AnimationSidebar extends StatelessWidget {
  const AnimationSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final motions = MotionType.values;
    return Container(
      width: 300,
      color: Colors.greenAccent,
      child: Scaffold(
        body: Scrollbar(
          child: ListView.builder(
            primary: true,
            itemCount: motions.length,
            itemBuilder: (context, index) {
              final motion = motions[index];
              return SizedBox(
                height: 80,
                child: Draggable<MotionType>(
                  data: motion,
                  feedback: Material(
                    child: Container(
                      width: 300,
                      height: 80,
                      color: Colors.blue.withOpacity(0.7),
                      child: const Center(child: Text("Drag")),
                    ),
                  ),
                  childWhenDragging: Container(
                    width: 300,
                    height: 80,
                    color: Colors.grey,
                    child: const Center(child: Text("Box")),
                  ),
                  child: SizedBox(
                    width: 300,
                    height: 80,
                    child: Center(child: Text(motion.name)),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class AnimationControlSidebar extends StatelessWidget {
  const AnimationControlSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: MotionManager.instance,
      builder: (context, _) {
        return Container(
          width: 300,
          color: Colors.amberAccent,
          child: Scaffold(
            body: Scrollbar(
              child: ListView.builder(
                primary: true,
                itemCount: MotionManager.instance.motions.length,
                itemBuilder: (context, index) {
                  final motion = MotionManager.instance.motions[index];
                  return SizedBox(
                    height: 80,
                    child: Dismissible(
                      key: Key(motion.name),
                      onDismissed: (direction) {
                        MotionManager.instance.unregister(motion);
                      },
                      background: Container(color: Colors.red),
                      child: Center(child: Text(motion.name)),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  Color caughtColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.red,
        child: DragTarget<MotionType>(
          onAccept: MotionManager.instance.register,
          builder: (context, candidateData, rejectedData) {
            return Container(
              color: caughtColor,
              child: ListenableBuilder(
                listenable: MotionManager.instance,
                builder: (context, _) {
                  print(
                    'MotionManager.instance.motions ${MotionManager.instance.motions}',
                  );
                  return Container(
                    child: MotionManager.instance.motions.fold<Widget>(
                      Center(
                        child: Container(
                          width: 200,
                          height: 200,
                          color: Colors.blue.withOpacity(0.7),
                          child: Center(
                            child: const Text(
                              "Drag a motion here",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      (previous, motionType) =>
                          motionType.createMotion(previous),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
