// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class ScannerBleService extends ChangeNotifier {
  List<DiscoveredDevice> devices = [];

  ScannerBleService({
    required FlutterReactiveBle ble,
  }) : _ble = ble;

  final FlutterReactiveBle _ble;
  scanner() {
    _ble.scanForDevices(withServices: [], scanMode: ScanMode.lowLatency).listen(
        (device) {
      final deviceindex = devices.indexWhere((d) => d.id == device.id);
      if (deviceindex >= 0) {
        devices[deviceindex] = device;
        notifyListeners();
      } else {
        devices.add(device);
      }
    }, onError: (Object e) {
      print(e);
    });
  }
}
