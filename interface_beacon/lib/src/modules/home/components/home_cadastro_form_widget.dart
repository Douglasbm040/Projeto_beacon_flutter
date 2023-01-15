import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:interface_beacon/src/modules/custom/controllers/custom_textfield_controller.dart';
import 'package:interface_beacon/src/modules/db/firebase/interfaces/database_interface.dart';
import 'package:interface_beacon/src/modules/qrscanner/interface/qrscanner_interface.dart';
import '../../custom/components/custom_textfield_widget.dart';

class HomeCadastroFormWidget extends StatelessWidget {
  HomeCadastroFormWidget(
      {super.key,
      required String title,
      required String titlebuttom,
      required this.qrscanner,
      required this.dataBase,
      required this.controller})
      : _title = title,
        _titlebutton = titlebuttom;
  final CustomTextfieldController controller;
  final DataBaseInterface dataBase;
  final QrScannerInterface qrscanner;
  final String _title;
  final String _titlebutton;
  late Map _json = {};
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
                    Text("6 Passo para cadastrar ou atualizar seu aparelho")),
            const SizedBox(height: 30),
            const ListTile(
              leading: Text("PASSO 1"),
              title: Text(
                  "Digite abaixo o nome do estabelecimanto onde o aparelho se localiza"),
            ),
            const SizedBox(height: 20),
            CustomTextFieldWidget(
                label: 'Exemplo padaria pao doce',
                controller: controller.deviceName),
            const SizedBox(height: 20),
            const ListTile(
              leading: Text("PASSO 2"),
              title: Text("Aperte o botão abaixo e scane o QRcode"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              //! os espaço podem esta vindo o qr code
              onPressed: () async {
                await qrscanner.readQrcode();
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
            const SizedBox(height: 20),
            const ListTile(
              leading: Text("PASSO 5"),
              title: Text("Escreva uma breve descrição"),
            ),
            const SizedBox(height: 20),
            CustomTextFieldWidget(
              label: "descreva aqui ...",
              controller: controller.descricao,
            ),
            const SizedBox(height: 20),
            const ListTile(
              leading: Text("PASSO 6"),
              title: Text("Clique no botão abaixo para enviar o formulário"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final _json = {
                  "deviceName": controller.deviceName.text,
                  "descricao": controller.descricao.text,
                  ...json.decode(qrscanner.result)
                };
                final submit = json.encode(_json);
                await dataBase.insert(value: json.decode(submit));
              },
              child: const SizedBox(
                height: 50,
                child: Center(
                  child: Text("enviar"),
                ),
              ),
            ),
            const SizedBox(height: 40)
          ],
        )),
      ),
    );
  }
}
