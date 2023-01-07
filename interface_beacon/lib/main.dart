import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:interface_beacon/src/app.dart';
import 'package:interface_beacon/src/controller/controller_bleconection.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ControllerBleConector>(
      create: (context) => ControllerBleConector(ble: _ble),
    )
  ], child: const App()));
}
