import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:interface_beacon/src/modules/custom/controllers/custom_textfield_controller.dart';
import 'package:interface_beacon/src/modules/database/firebase/interfaces/database_interface.dart';
import 'package:interface_beacon/src/modules/database/firebase/repository/database_repository.dart';
import 'package:interface_beacon/src/modules/gps/interface/gps_interface.dart';
import 'package:interface_beacon/src/modules/gps/services/gps_service.dart';
import 'package:interface_beacon/src/modules/qrscanner/interface/qrscanner_interface.dart';
import 'package:interface_beacon/src/modules/qrscanner/service/qrscanner_service.dart';
import '../../custom/components/custom_textfield_widget.dart';

class HomeCadastroFormWidget extends StatelessWidget {
  HomeCadastroFormWidget(
      {super.key,
      required String title,
      required String titlebuttom,
      required this.qrscanner,
      required this.dataBase,
      required this.controller,
      required this.localization})
      : _title = title,
        _titlebutton = titlebuttom;

  final GpsInterface localization;
  final CustomTextfieldController controller;
  final DataBaseInterface dataBase;
  final QrScannerInterface qrscanner;
  final String _title;
  final String _titlebutton;
  late Map _json = {};
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      elevation: 10,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            child: ListView(
          children: [
            Card(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                      child: Text(
                          "6 Passo para cadastrar ou atualizar seu aparelho")),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Card(
              elevation: 10,
              child: ListTile(
                leading: const Text("PASSO 1"),
                title: Column(
                  children: [
                    const Text(
                        "Digite abaixo o nome do estabelecimanto onde o aparelho se localiza"),
                    const SizedBox(height: 20),
                    CustomTextFieldWidget(
                        label: 'Exemplo padaria pao doce',
                        controller: controller.deviceName),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Card(
              elevation: 10,
              child: ListTile(
                leading: const Text("PASSO 2"),
                title: Column(
                  children: [
                    const Text("Aperte o botão abaixo e scane o QRcode"),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: qrscanner.state ==
                                  StateQrScannerService.start
                              ? Colors.blue
                              : qrscanner.state != StateQrScannerService.found
                                  ? Colors.red
                                  : Colors.green),
                      onPressed: () async {
                        await qrscanner.readQrcode();
                      },
                      child: const SizedBox(
                          height: 50,
                          child: Center(child: Text("Scanear Qrcode"))),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Card(
              elevation: 10,
              child: ListTile(
                leading: Text("PASSO 3"),
                title: Text("Instale o aparelho no local fixo em area externa"),
              ),
            ),
            const SizedBox(height: 5),
            Card(
              elevation: 10,
              child: ListTile(
                leading: const Text("PASSO 4"),
                title: Column(
                  children: [
                    const Text(
                        textAlign: TextAlign.justify,
                        "Ligue o Gps do celular.  encoste o celular no aparelho. Aperte o botão abaixo"),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              localization.state != StateGpsService.startservice
                                  ? Colors.blue
                                  : localization.state !=
                                          StateGpsService.localization
                                      ? Colors.red
                                      : Colors.green),
                      onPressed: () {
                        localization.determinePosition();
                      },
                      child: const SizedBox(
                          height: 50,
                          child: Center(child: Text("Inserir localização"))),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Card(
              elevation: 10,
              child: ListTile(
                leading: const Text("PASSO 5"),
                title: Column(
                  children: [
                    const Text(
                      "Escreva uma breve descrição",
                    ),
                    const SizedBox(height: 20),
                    CustomTextFieldWidget(
                      label: "descreva aqui ...",
                      controller: controller.descricao,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Card(
              elevation: 10,
              child: ListTile(
                leading: const Text("PASSO 6"),
                title: Column(
                  children: [
                    const Text(
                        "Clique no botão abaixo para enviar o formulário"),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: dataBase.state == StateFirebase.start
                              ? Colors.blue
                              : dataBase.state != StateFirebase.insertcorrect
                                  ? Colors.red
                                  : Colors.green),
                      onPressed: () async {
                        final _json = {
                          "deviceName": controller.deviceName.text,
                          "descricao": controller.descricao.text,
                          "latitude": localization.local.latitude,
                          "longitude": localization.local.longitude,
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
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20)
          ],
        )),
      ),
    );
  }
}
