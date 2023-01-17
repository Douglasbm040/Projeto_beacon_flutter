import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/services/bleinteration_service.dart';

abstract class IBleInteration {
  Future<void> writeCharacterisiticWithoutResponse(
      QualifiedCharacteristic characteristic, List<int> value);
  Future<int> requestMtu(String deviceId, int mtu);
  StateBleInterationService get state;
}
