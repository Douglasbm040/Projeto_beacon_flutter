import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/services/bleconection_service.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/services/bleinteration_service.dart';
import 'package:interface_beacon/src/modules/custom/controllers/custom_textfield_controller.dart';
import 'package:interface_beacon/src/modules/database/firebase/repository/database_repository.dart';
import 'package:interface_beacon/src/modules/gps/services/gps_service.dart';
import 'package:interface_beacon/src/modules/qrscanner/service/qrscanner_service.dart';
import 'package:provider/provider.dart';

import '../components/home_atualiza_form_widget.dart';
import '../components/home_cadastro_form_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColorDark,
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Text("Cadastrar"),
                Text("Atualizar"),
              ],
            ),
            title: const Text('Bem vindo a interface beacon'),
          ),
          body: TabBarView(children: [
            Consumer4<QrScannerService, DataBaseRepository,CustomTextfieldController,GpsService>(
              builder: (context, qrscannerservice, firebase,controller,localization, child) =>
                  HomeCadastroFormWidget(
                title: "Cadastre o seu beacon",
                titlebuttom: "enviar dados",
                qrscanner: qrscannerservice,
                dataBase: firebase,
                controller: controller,
                localization: localization,
              ),
            ),
            Consumer3<BleConectorService, BleInterationService,
                DataBaseRepository>(
              builder: (context, conector, response, firebase, child) =>
                  HomeAtualizaFormWidget(
                plugin: conector,
                interation: response,
                dataBase: firebase,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
