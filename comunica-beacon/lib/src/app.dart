import 'package:comunica_beacons/src/modules/chat/page/comunication_page.dart';
import 'package:comunica_beacons/src/modules/database/firebase/repository/firebase_repository.dart';
import 'package:comunica_beacons/src/modules/gps/services/gps_service.dart';
import 'package:comunica_beacons/src/modules/home/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';

import 'modules/bluetoothble/services/conectble_service.dart';
import 'modules/bluetoothble/services/interationble_service.dart';
import 'modules/bluetoothble/services/scannerble_service.dart';

class App extends StatelessWidget {
  const App({super.key});
  //WidgetsFlutterBinding.ensureInitialized();
  //Provider.debugCheckInvalidValueType = null;
  static final FlutterReactiveBle _ble = FlutterReactiveBle();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<GpsService>(
            create: (context) => GpsService(),
          ),
          ChangeNotifierProvider<FirebaseRepository>(
            create: (context) => FirebaseRepository(),
          ),
          ChangeNotifierProvider<ScannerBleService>(
            create: (context) => ScannerBleService(ble: _ble),
          ),
          ChangeNotifierProvider<ConnectorBleService>(
            create: ((context) => ConnectorBleService(ble: _ble)),
          ),
          ChangeNotifierProvider(
            create: (context) => IntegrationBleService(
                writeWithoutResponse: _ble.writeCharacteristicWithoutResponse,
                bleDiscoverServices: _ble.discoverServices,
                readcharacteristic: _ble.readCharacteristic,
                requestSpace: _ble.requestMtu),
          ),
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blue),
            initialRoute: '/',
            routes: {
              '/': (_) => const Homepage(),
              '/comunication': (_) => const ComunicationPage(),
            }));
  }
}
