import 'package:flutter/material.dart';

class CustomComboBox extends StatefulWidget {
  String placeholder;
  String? borderText;
  String? selectedItem;
  List<String> items = [];
  Function(String value) onChanged;

  CustomComboBox(
    this.items, {
    super.key,
    this.selectedItem,
    required this.onChanged,
    required this.placeholder,
    this.borderText,
  }) {
    borderText ??= placeholder;
  }

  @override
  State<CustomComboBox> createState() => CustomComboBoxState();
}

class CustomComboBoxState extends State<CustomComboBox> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: widget.items.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(
            type,
          ),
        );
      }).toList(),
      validator: (value) {
        if (value == null) {
          return 'Select a value';
        }
        return null;
      },
      isExpanded: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.brown),
        ),
        labelText: widget.borderText,
      ),
      value: widget.selectedItem,
      hint: Text(widget.placeholder),
      onChanged: (value) {
        if (value == null) return;
        widget.onChanged(value);
      },
    );
  }
}
