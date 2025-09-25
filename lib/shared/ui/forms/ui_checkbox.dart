import 'package:flutter/material.dart';
import 'package:motion/shared/ui/constants/dimensions.dart';

class UICheckbox extends StatefulWidget {
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
    this.size = 14,
    this.activeColor = Colors.blue,
    this.borderColor = Colors.grey,
    this.label,
  });

  @override
  State<UICheckbox> createState() => _UICheckboxState();
}

class _UICheckboxState extends State<UICheckbox> {

  ValueNotifier<bool> checked = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    checked.value = widget.value;
  }

  @override
  void dispose() {
    checked.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          widget.onChanged(!widget.value);
          checked.value = !checked.value;
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder(
              valueListenable: checked,
              builder: (context, value, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  width: widget.size,
                  height: widget.size,
                  decoration: ShapeDecoration(
                    color: value ? widget.activeColor : Colors.transparent,
                    shape: RoundedSuperellipseBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        side: BorderSide(
                          color: value ? widget.activeColor : widget.borderColor,
                          width: 2,
                        )
                    ),
                  ),
                  child: value
                      ? Icon(
                    Icons.check,
                    color: Colors.white,
                    size: widget.size * 0.7,
                  )
                      : null,
                );
              }
            ),
            if (widget.label != null) ...[
              Spaces.s,
              widget.label!,
            ],
          ],
        ),
      ),
    );
  }
}