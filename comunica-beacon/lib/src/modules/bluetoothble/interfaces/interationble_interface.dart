import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

abstract class InterationBleInterface {
  Future<List<DiscoveredService>> discoverServices();
  Future<List<int>> readCharacteristic();
  Future<void> writeCharacterisiticWithoutResponse();
  Future<void> requestMtu();
}
