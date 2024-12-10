import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  const MyInput({super.key, required this.label, required this.change, this.obscureText, this.initialValue});

  final String label;
  final String? initialValue;
  final bool? obscureText;
  final void Function(String) change;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: obscureText ?? false,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: label,
      ),
      onChanged: change,
    );
  }
}
