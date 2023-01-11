import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/interfaces/bleconection_interface.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/interfaces/bleinteration_interface.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/services/bleinteration_service.dart';
import 'package:interface_beacon/src/modules/db/firebase/interfaces/database_interface.dart';
import 'package:interface_beacon/src/modules/db/firebase/repository/database_repository.dart';

import '../../bluetoothBle/services/bleconection_service.dart';

class HomeAtualizaFormWidget extends StatelessWidget {
  HomeAtualizaFormWidget({
    super.key,
    required this.plugin,
    required this.interation,
    required this.DB,
  });
  final DataBaseInterface DB;
  final IBleConection plugin;
  final IBleInteration interation;

  final Uuid _myServiceUuid = //! adicionar automaticamente caracterista do ble
      Uuid.parse("4fafc201-1fb5-459e-8fcc-c5c9c331914b");
  final Uuid _myCharacteristicUuid =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26a8");
  final String device_id = "08:3A:F2:8F:2B:42";

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
              style: ElevatedButton.styleFrom(
                  backgroundColor: plugin.plug == conexao.conectado
                      ? Colors.green
                      : Colors.blue),
              onPressed: () {
                plugin.connect(device_id);
              },
              child: const SizedBox(
                  height: 50, child: Center(child: Text("conectar"))),
            ),
            const SizedBox(height: 30),
            const SizedBox(height: 20),
            const ListTile(
              leading: Text("3"),
              title: Text("clique no botao a baixo para atualizar os dados."),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                /*interation.writeCharacterisiticWithoutResponse(
                    QualifiedCharacteristic(
                        characteristicId: _myCharacteristicUuid,
                        serviceId: _myServiceUuid,
                        deviceId: device_id),
                    utf8.encode("olas"));*/
                DB.insert();
                DB.requisition();
              },
              child: const SizedBox(
                height: 50,
                child: Center(
                  child: Text("enviar"),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
