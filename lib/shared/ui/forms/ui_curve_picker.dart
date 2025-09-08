import 'package:flutter/material.dart';
import 'package:motion/core/constants/curves.dart';
import 'package:motion/shared/ui/previews/curve_preview.dart';

class UICurvePicker extends StatelessWidget {
  const UICurvePicker({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final Curve selected;
  final ValueChanged<Curve?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<Curve>(
      label: Text("Curve"),
      initialSelection: selected,
      onSelected: onChanged,
      enableSearch: false,
      enableFilter: false,
      showTrailingIcon: false,
      dropdownMenuEntries: allCurves.map((e) {
        return DropdownMenuEntry<Curve>(
          value: e.curve,
          label: e.name,
          leadingIcon: IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () => CurvePreview.show(context, e.curve),
          ),
        );
      }).toList(),
    );
  }
}
