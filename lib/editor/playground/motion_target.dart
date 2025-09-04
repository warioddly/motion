
import 'package:flutter/material.dart';

class MotionTarget extends StatelessWidget {
  const MotionTarget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: 200,
        child: ColoredBox(
          color: Colors.blue,
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
    );
  }
}