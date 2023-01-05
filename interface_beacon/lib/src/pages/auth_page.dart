import 'dart:ui';

import 'package:flutter/material.dart';

import '../components/auth_form_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: SingleChildScrollView(
          child: AuthFormWidget(),
        ),
      ),
    );
  }
}
