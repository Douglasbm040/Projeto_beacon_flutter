import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/services/bleconection_service.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/services/bleinteration_service.dart';
import 'package:interface_beacon/src/modules/custom/controllers/custom_textfield_controller.dart';
import 'package:interface_beacon/src/modules/db/firebase/repository/database_repository.dart';
import 'package:interface_beacon/src/modules/home/page/home_page.dart';
import 'package:interface_beacon/src/modules/auth/page/auth_page.dart';
import 'package:interface_beacon/src/modules/qrscanner/service/qrscanner_service.dart';
import 'package:interface_beacon/src/modules/routecadastre/pages/cadastre_final_page.dart';
import 'package:interface_beacon/src/modules/routecadastre/pages/cadastre_id_page.dart';
import 'package:interface_beacon/src/modules/routecadastre/pages/cadastre_scan_page.dart';
import 'package:provider/provider.dart';

import 'modules/routecadastre/components/card_cadastre_widget.dart';
import 'modules/routecadastre/pages/cadastre__start_page.dart';

class App extends StatelessWidget {
  const App({super.key});
  //WidgetsFlutterBinding.ensureInitialized();
  static final FlutterReactiveBle _ble = FlutterReactiveBle();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CustomTextfieldController>(
              create: ((context) => CustomTextfieldController())),
          ChangeNotifierProvider<QrScannerService>(
              create: (context) => QrScannerService()),
          ChangeNotifierProvider<DataBaseRepository>(
            create: (context) => DataBaseRepository(),
          ),
          ChangeNotifierProvider<BleInterationService>(
            create: (context) => BleInterationService(
                requestSpace: _ble.requestMtu,
                writeWithoutResponse: _ble.writeCharacteristicWithoutResponse),
          ),
          ChangeNotifierProvider<BleConectorService>(
            create: (context) => BleConectorService(ble: _ble),
          )
        ],
        child: MaterialApp(
          title: 'Interface Beacon',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: "/",
          routes: {
            '/': (context) => const AuthPage(),
            '/start': (context) => const CadastreStartPage(),
            '/home': (context) => const HomePage(),
            '/scan': (context) => const CadastreScanPage(),
            //'/id': (context) => const CadastreIdPage(),
            '/final': (context) => const CadastreFinalPage(),
          },
        ));
  }
}
