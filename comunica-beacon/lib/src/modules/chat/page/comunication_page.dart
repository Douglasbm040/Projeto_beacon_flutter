import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunica_beacons/src/modules/bluetoothble/services/interationble_service.dart';
import '../components/comunication_ui.dart';

class ComunicationPage extends StatelessWidget {
  const ComunicationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<IntegrationBleService>(
        builder: (context, plugs, child) => ComunicationUI(
              comunication: plugs,
            ));
  }
}
