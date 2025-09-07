import 'package:flutter/material.dart';

class UiTextfield extends StatelessWidget {
  const UiTextfield({
    super.key,
    required this.initialText,
    this.labelText,
    this.onChanged,
  });

  final String initialText;
  final String? labelText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Durations in milliseconds",
      child: TextField(
        controller: TextEditingController()..text = initialText,
        decoration: InputDecoration(labelText: labelText),
        onChanged: onChanged,
      ),
    );
  }
}
