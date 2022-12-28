import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunica_beacons/src/controllers/controller_interationble.dart';
import '../widget/comunication_ui.dart';

class ComunicationPage extends StatelessWidget {
  const ComunicationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ControllerIntegrationBle>(
        builder: (context, plugs, child) => ComunicationUI(
              comunication: plugs,
            ));
  }
}
