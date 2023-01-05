import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:interface_beacon/src/components/Custom_textfield_widget.dart';

class AuthFormWidget extends StatelessWidget {
  const AuthFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Form(
            child: Column(
          children: [
            const Icon(
              Icons.person_pin,
              size: 150,
              color: Colors.blue,
            ),
            CustomTextFieldWidget(label: "user"),
            const SizedBox(height: 10),
            CustomTextFieldWidget(label: 'Password'),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/home');
                },
                child: const Text("Entrar")),
            TextButton(onPressed: () {}, child: const Text('logar'))
          ],
        )),
      ),
    );
  }
}
