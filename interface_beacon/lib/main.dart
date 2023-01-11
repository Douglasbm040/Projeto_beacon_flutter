import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:interface_beacon/src/app.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/services/bleconection_service.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/services/bleinteration_service.dart';
import 'package:interface_beacon/src/modules/db/firebase/repository/database_repository.dart';
import 'package:provider/provider.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //final FlutterReactiveBle _ble = FlutterReactiveBle();
  runApp(const App());
}
