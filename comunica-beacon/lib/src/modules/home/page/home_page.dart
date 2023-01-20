import 'package:comunica_beacons/src/modules/bluetoothble/services/conectble_service.dart';
import 'package:comunica_beacons/src/modules/database/firebase/repository/firebase_repository.dart';
import 'package:comunica_beacons/src/modules/gps/services/gps_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunica_beacons/src/modules/bluetoothble/services/scannerble_service.dart';
import '../components/homepage_ui.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer4<ScannerBleService, ConnectorBleService, FirebaseRepository,
        GpsService>(
      builder: (context, scanner, swicthconection, firebase, gps, __) =>
          HomePageUi(
        devices: scanner.devices,
        plug: swicthconection,
        request: firebase,
        gps: gps,
      ),
    );
  }
}
