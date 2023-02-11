import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  CustomInput({super.key, this.placeholder = "", required this.onChange, this.numberOnly = false, String? initialValue}) {
    initialValue = initialValue;
  }

  String placeholder;
  bool numberOnly;
  String initialValue = "";
  Function(String value) onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => value!.isEmpty ? "Please enter a value" : null,
      initialValue: initialValue,
      keyboardType: numberOnly ? TextInputType.number : TextInputType.text,
      inputFormatters: numberOnly ? [FilteringTextInputFormatter.digitsOnly] : null,
      decoration: InputDecoration(border: const OutlineInputBorder(), fillColor: Colors.grey.shade100, filled: true, labelStyle: const TextStyle(fontSize: 20), labelText: placeholder),
      onChanged: (value) {
        onChange(value);
      },
    );
  }
}
