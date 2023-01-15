import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/interfaces/bleconection_interface.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/interfaces/bleinteration_interface.dart';
import 'package:interface_beacon/src/modules/db/firebase/interfaces/database_interface.dart';
import '../../bluetoothBle/services/bleconection_service.dart';

class HomeAtualizaFormWidget extends StatelessWidget {
  HomeAtualizaFormWidget({
    super.key,
    required this.plugin,
    required this.interation,
    required this.dataBase,
  });
  final DataBaseInterface dataBase;
  final IBleConection plugin;
  final IBleInteration interation;

  /*final Uuid _myServiceUuid = //! adicionar automaticamente caracterista do ble
      Uuid.parse("4fafc201-1fb5-459e-8fcc-c5c9c331914b");
  final Uuid _myCharacteristicUuid =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26a8");
  final String device_id = "08:3A:F2:8F:2B:42";

  final Map<String, dynamic> device = {
    "device_name": "Farmacia",
    "lat": 1231235143,
    "long": 12341351345,
    "device_id": "08:3A:F2:8F:2B:42",
    "serviceUuid": "4fafc201-1fb5-459e-8fcc-c5c9c331914b",
    "CharacteristicUuid": "beb5483e-36e1-4688-b7f5-ea07361b26a8"
  };
*/
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(30),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
            child: ListView(
          children: [
            const Center(
                child: Text("Siga os 2 passo para atualizar seu aparelho :")),
            const SizedBox(height: 30),
            const ListTile(
              leading: Text("PASSO 1"),
              title: Text(
                  textAlign: TextAlign.justify,
                  "clique no botao a baixo para conectar com o aparelho e aguarde a confirmação."),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: plugin.plug == conexao.conectado
                      ? Colors.green
                      : Colors.blue),
              onPressed: () async {
                await plugin.connect(dataBase.device["device_id"]);
              },
              child: const SizedBox(
                  height: 50, child: Center(child: Text("conectar"))),
            ),
            const SizedBox(height: 30),
            const SizedBox(height: 20),
            const ListTile(
              leading: Text("PASSO 2 "),
              title: Text("clique no botao a baixo para atualizar os dados."),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await dataBase.requisition();
                print(json.encode(dataBase.device));
                print(dataBase.device["CharacteristicUuid"]);
                print(dataBase.device["serviceUuid"]);
                print(dataBase.device["device_id"]);
                await interation.requestMtu(dataBase.device["device_id"], 250);
                interation.writeCharacterisiticWithoutResponse(
                  QualifiedCharacteristic(
                      characteristicId:
                          Uuid.parse(dataBase.device["CharacteristicUuid"]),
                      serviceId: Uuid.parse(dataBase.device["serviceUuid"]),
                      deviceId: dataBase.device["device_id"]),
                  utf8.encode(
                    
                    json.encode({
                      "n" : dataBase.device["deviceName"],
                      "lt": dataBase.device["lat"],
                      "lg": dataBase.device["long"],
                      "d" : dataBase.device["descricao"]
                    })
                    ,
                  ),
                );
                // dataBase.insert(value: device);
                //print(dataBase.device);
              },
              child: const SizedBox(
                height: 50,
                child: Center(
                  child: Text("Atualizar"),
                ),
              ),
            ),
          
          ],
        )),
      ),
    );
  }
}
