import 'package:flutter/material.dart';

const _minHeight = 100.0;

class ControlBar extends StatefulWidget {
  const ControlBar({super.key});

  @override
  State<ControlBar> createState() => _ControlBarState();
}

class _ControlBarState extends State<ControlBar> {
  final heightController = ValueNotifier(250.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onVerticalDragUpdate: (details) {
            heightController.value = (heightController.value - details.delta.dy)
                .clamp(_minHeight, MediaQuery.heightOf(context) * .6);
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.resizeRow,
            child: Container(
              width: double.infinity,
              height: 5,
              color: Colors.red,
            ),
          ),
        ),

        ValueListenableBuilder(
          valueListenable: heightController,
          builder: (context, height, child) {
            return SizedBox(
              width: double.infinity,
              height: height,
              child: child,
            );
          },
          child: Container(color: Colors.green),
        ),
      ],
    );
  }
}
