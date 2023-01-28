import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  String text;
  bool defaultValue = false;
  Function(bool value) onChanged;

  CustomCheckBox(
    this.text, {
    super.key,
    required this.defaultValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(text),
      value: defaultValue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4), // Optionally
        side: const BorderSide(color: Colors.grey),
      ),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}
