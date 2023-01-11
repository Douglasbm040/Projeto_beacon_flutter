import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/services/bleconection_service.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/services/bleinteration_service.dart';
import 'package:interface_beacon/src/modules/db/firebase/repository/database_repository.dart';
import 'package:interface_beacon/src/modules/home/page/home_page.dart';
import 'package:interface_beacon/src/modules/auth/page/auth_page.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});
  //WidgetsFlutterBinding.ensureInitialized();
  static final FlutterReactiveBle _ble = FlutterReactiveBle();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<DataBaseRepository>(
            create: (context) => DataBaseRepository(),
          ),
          ChangeNotifierProvider<BleInterationService>(
            create: (context) => BleInterationService(
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
            '/home': (context) => const HomePage()
          },
        ));
  }
}
