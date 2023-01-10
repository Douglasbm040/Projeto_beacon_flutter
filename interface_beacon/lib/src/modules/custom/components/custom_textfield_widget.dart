import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String _text;

  const CustomTextFieldWidget({super.key, required String label})
      : _text = label;
  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
            labelText: _text,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.blue),
              borderRadius: BorderRadius.circular(50),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.green),
              borderRadius: BorderRadius.circular(50),
            )));
  }
}
