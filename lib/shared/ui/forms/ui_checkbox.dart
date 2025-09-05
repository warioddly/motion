import 'package:flutter/material.dart';

class UICheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double size;
  final Color activeColor;
  final Color borderColor;
  final Widget? label;

  const UICheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 16,
    this.activeColor = Colors.blue,
    this.borderColor = Colors.grey,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: size,
              height: size,
              decoration: ShapeDecoration(
                color: value ? activeColor : Colors.transparent,
                shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    side: BorderSide(
                      color: value ? activeColor : borderColor,
                      width: 2,
                    )
                ),
              ),
              child: value
                  ? Icon(
                Icons.check,
                color: Colors.white,
                size: size * 0.7,
              )
                  : null,
            ),
            if (label != null) ...[
              const SizedBox(width: 8),
              label!,
            ],
          ],
        ),
      ),
    );
  }
}