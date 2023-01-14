import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:interface_beacon/src/modules/db/firebase/interfaces/database_interface.dart';
import 'package:interface_beacon/src/modules/qrscanner/interface/qrscanner_interface.dart';
import '../../custom/components/custom_textfield_widget.dart';

class HomeCadastroFormWidget extends StatelessWidget {
  const HomeCadastroFormWidget(
      {super.key,
      required String title,
      required String titlebuttom,
      required this.qrscanner,
      required this.dataBase})
      : _title = title,
        _titlebutton = titlebuttom;
  final DataBaseInterface dataBase;
  final QrScannerInterface qrscanner;
  final String _title;
  final String _titlebutton;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Center(
                child:
                    Text("4 Passo para cadastrar ou atualizar seu aparelho")),
            const SizedBox(height: 30),
            const ListTile(
              leading: Text("PASSO 1"),
              title: Text(
                  "Digite abaixo o nome do estabelecimanto onde o aparelho se localiza"),
            ),
            const SizedBox(height: 20),
            const CustomTextFieldWidget(label: 'Exemplo padaria pao doce'),
            const SizedBox(height: 20),
            const ListTile(
              leading: Text("PASSO 2"),
              title: Text("Aperte o botão abaixo e scane o QRcode"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await qrscanner.readQrcode();
                dataBase.insert(value: json.decode(qrscanner.result));
              },
              child: const SizedBox(
                  height: 50, child: Center(child: Text("Scanear Qrcode"))),
            ),
            const SizedBox(height: 20),
            const ListTile(
              leading: Text("PASSO 3"),
              title: Text("Instale o aparelho no local fixo em area externa"),
            ),
            const SizedBox(height: 20),
            const ListTile(
              leading: Text("PASSO 4"),
              title: Text(
                  textAlign: TextAlign.justify,
                  "Ligue o Gps do celular.  encoste o celular no aparelho. Aperte o botão abaixo"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const SizedBox(
                  height: 50,
                  child: Center(child: Text("Inserir localização"))),
            ),
            const SizedBox(height: 40),
          ],
        )),
      ),
    );
  }
}
