import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:interface_beacon/src/components/Custom_textfield_widget.dart';

class HomeFormWidget extends StatelessWidget {
  const HomeFormWidget(
      {super.key, required String title, required String titlebuttom})
      : _title = title,
        _titlebutton = titlebuttom;
  final String _title;
  final String _titlebutton;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(30),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
            child: Column(
          children: [
            Text(_title),
            const SizedBox(height: 30),
            const CustomTextFieldWidget(label: 'Latitude'),
            const SizedBox(height: 20),
            const CustomTextFieldWidget(label: 'Logitude'),
            const SizedBox(height: 20),
            const CustomTextFieldWidget(label: 'ID'),
            const SizedBox(height: 20),
            const CustomTextFieldWidget(label: 'usuario'),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text(_titlebutton)),
            const SizedBox(height: 40),
          ],
        )),
      ),
    );
  }
}
