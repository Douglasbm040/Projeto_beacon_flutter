import 'package:flutter/cupertino.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/interfaces/bleinteration_interface.dart';

class BleInterationService extends ChangeNotifier implements IBleInteration {
  final Future<void> Function(QualifiedCharacteristic characteristic,
      {required List<int> value}) _writeWithoutResponse;

  BleInterationService(
      {required Future<void> Function(QualifiedCharacteristic characteristic,
              {required List<int> value})
          writeWithoutResponse})
      : _writeWithoutResponse = writeWithoutResponse;

  @override
  Future<void> writeCharacterisiticWithoutResponse(
      QualifiedCharacteristic characteristic, List<int> value) async {
    try {
      await _writeWithoutResponse(characteristic, value: value);
      print(
          'Write without response value: $value to ${characteristic.characteristicId}');
    } on Exception catch (e, s) {
      print(
        'Error occured when writing ${characteristic.characteristicId} : $e',
      );
      // ignore: avoid_print
      print(s);
      rethrow;
    }
  }
}
