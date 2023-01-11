import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

abstract class IBleInteration {
  Future<void> writeCharacterisiticWithoutResponse(
      QualifiedCharacteristic characteristic, List<int> value);
}
