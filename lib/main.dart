import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion/editor/motions_control_panel.dart';
import 'package:motion/editor/motions_playground.dart';
import 'package:motion/editor/motions_sidebar.dart';
import 'package:motion/shared/ui/theme/ui_theme.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MotionEditor());
}

class MotionEditor extends StatelessWidget {
  const MotionEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motion',
      theme: UITheme.theme,
      darkTheme: UITheme.theme,
      debugShowCheckedModeBanner: false,
      scrollBehavior: CupertinoScrollBehavior(),
      home: const Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MotionsSidebar(),
            MotionsPlayground(),
            MotionsControlPanel(),
          ],
        ),
      ),
    );
  }
}

