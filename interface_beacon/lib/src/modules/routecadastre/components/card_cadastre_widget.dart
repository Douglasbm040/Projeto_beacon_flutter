import 'package:flutter/material.dart';
import 'package:interface_beacon/src/modules/routecadastre/models/messages_models.dart';

class CardCadastreWidget extends StatelessWidget {
  const CardCadastreWidget({
    super.key,
    required this.text,
    required this.title, required this.next,
  });

  final String title;
  final String text;
  final String next;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
            child: Column(
          children: [
            Text(textAlign: TextAlign.center, title),
            const SizedBox(height: 70),
            Text(textAlign: TextAlign.justify, text),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(next);
              },
              child: const SizedBox(
                  height: 50, child: Center(child: Text("Proximo passo"))),
            ),
          ],
        )),
      ),
    );
  }
}
