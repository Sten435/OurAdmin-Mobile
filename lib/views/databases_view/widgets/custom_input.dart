import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  CustomInput(this.placeholder, {super.key, this.numberOnly = false, String? initialValue}) {
    if (initialValue != null) {
      this.initialValue = initialValue;
    }
  }

  String placeholder;
  bool numberOnly;
  String initialValue = "";

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => value!.isEmpty ? "Please enter a value" : null,
      initialValue: initialValue,
      keyboardType: numberOnly ? TextInputType.number : TextInputType.text,
      inputFormatters: numberOnly ? [FilteringTextInputFormatter.digitsOnly] : null,
      decoration: InputDecoration(border: const OutlineInputBorder(), fillColor: Colors.grey.shade100, filled: true, labelStyle: const TextStyle(fontSize: 20), labelText: placeholder),
    );
  }
}
