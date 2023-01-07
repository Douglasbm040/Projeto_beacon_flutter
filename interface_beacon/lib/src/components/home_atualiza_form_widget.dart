import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:interface_beacon/src/components/Custom_textfield_widget.dart';

class HomeAtualizaFormWidget extends StatelessWidget {
  const HomeAtualizaFormWidget(
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
            child: ListView(
          children: [
            const Text("Siga os passo para atualizar seu aparelho :"),
            const SizedBox(height: 30),
            const ListTile(
              leading: Text("1"),
              title: Text(
                  textAlign: TextAlign.justify,
                  "clique no botao a baixo para conectar com o aparelho e aguarde."),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                
              },
              child: const SizedBox(
                  height: 50, child: Center(child: Text("conectar"))),
            ),
            const SizedBox(height: 30),
            /*const ListTile(
              leading: Text("2"),
              title: Text("Aguarde a conexão ser estabelecida"),
            ),*/
            const SizedBox(height: 20),
            const ListTile(
              leading: Text("3"),
              title: Text("clique no botao a baixo para atualizar os dados."),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              child: const SizedBox(
                  height: 50, child: Center(child: Text("enviar"))),
            ),
          ],
        )),
      ),
    );
  }
}
