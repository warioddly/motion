import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion/editor/animation_control_sidebar.dart';
import 'package:motion/editor/animation_editor_content.dart';
import 'package:motion/editor/animation_list_sidebar.dart';


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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      scrollBehavior: CupertinoScrollBehavior(),
      home: const Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AnimationListSidebar(),
            AnimationEditorContent(),
            AnimationControlSidebar(),
          ],
        ),
      ),
    );
  }
}

