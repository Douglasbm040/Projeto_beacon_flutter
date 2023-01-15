import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:interface_beacon/src/modules/custom/controllers/custom_textfield_controller.dart';
import 'package:provider/provider.dart';

import '../components/auth_form_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Consumer<CustomTextfieldController>( builder: (context, controller, child) => 
             AuthFormWidget(controller: controller)),
        ),
      ),
    );
  }
}
