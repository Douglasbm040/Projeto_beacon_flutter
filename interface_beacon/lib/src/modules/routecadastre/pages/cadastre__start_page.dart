import 'package:flutter/material.dart';
import 'package:interface_beacon/src/modules/routecadastre/components/card_cadastre_widget.dart';
import 'package:interface_beacon/src/modules/routecadastre/models/messages_models.dart';

class CadastreStartPage extends StatelessWidget {
  const CadastreStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: SingleChildScrollView(
            child: CardCadastreWidget(
          title: "casdastre start",
          text: "asd",
          next: "/scan",
        )),
      ),
    );
  }
}
