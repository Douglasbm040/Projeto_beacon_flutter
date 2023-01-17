import 'package:flutter/cupertino.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/interfaces/bleinteration_interface.dart';

enum StateBleInterationService {
  start,
  errorwhite,
  errorresquestmtu,
  correctwhite,
  correctrequestmtu
}

class BleInterationService extends ChangeNotifier implements IBleInteration {
  final Future<void> Function(QualifiedCharacteristic characteristic,
      {required List<int> value}) _writeWithoutResponse;
  final Future<int> Function({required String deviceId, required int mtu})
      _resquestSpace;
  BleInterationService({
    required Future<void> Function(QualifiedCharacteristic characteristic,
            {required List<int> value})
        writeWithoutResponse,
    required Future<int> Function({required String deviceId, required int mtu})
        requestSpace,
  })  : _writeWithoutResponse = writeWithoutResponse,
        _resquestSpace = requestSpace;
  StateBleInterationService _state = StateBleInterationService.start;
  @override
  StateBleInterationService get state => _state;
  @override
  Future<void> writeCharacterisiticWithoutResponse(
      QualifiedCharacteristic characteristic, List<int> value) async {
    try {
      await _writeWithoutResponse(characteristic, value: value);
      print(
          'Write without response value: $value to ${characteristic.characteristicId}');
      _state = StateBleInterationService.correctwhite;
      notifyListeners();
    } on Exception catch (e, s) {
      print(
        'Error occured when writing ${characteristic.characteristicId} : $e',
      );
      _state = StateBleInterationService.errorwhite;
      notifyListeners();
      // ignore: avoid_print
      print(s);
      rethrow;
    }
  }

  //Future<int> requestMtu({required String deviceId, required int mtu})
  @override
  Future<int> requestMtu(String deviceId, int mtu) async {
    try {
      final resultado = await _resquestSpace(deviceId: deviceId, mtu: mtu);
      _state = StateBleInterationService.correctrequestmtu;
      notifyListeners();
      return resultado;
    } catch (e) {
      print(e);
      _state = StateBleInterationService.errorresquestmtu;
      notifyListeners();
      rethrow;
    }
  }
}
