import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String _text;
  final TextEditingController _controller;
  const CustomTextFieldWidget(
      {super.key,
      required String label,
      required TextEditingController controller})
      : _text = label,
        _controller = controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _controller,
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
