import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String initialValue;
  final bool readOnly;

  const CustomTextFormField({
    Key? key,
    required this.label,
    required this.initialValue,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
      ),
      initialValue: initialValue,
      readOnly: readOnly,
    );
  }
}
