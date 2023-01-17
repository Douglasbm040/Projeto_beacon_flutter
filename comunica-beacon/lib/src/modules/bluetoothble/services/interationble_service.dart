import 'package:flutter/widgets.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:convert' show utf8;

class IntegrationBleService with ChangeNotifier {
  final Future<int> Function({required String deviceId, required int mtu})
      _resquestSpace;

  final Future<List<DiscoveredService>> Function(String deviceId)
      _bleDiscoverServices;
  final Future<List<int>> Function(QualifiedCharacteristic characteristic)
      _readcharacteristic;
  final Future<void> Function(QualifiedCharacteristic characteristic,
      {required List<int> value}) _writeWithoutResponse;

  IntegrationBleService(
      {required Future<void> Function(QualifiedCharacteristic characteristic,
              {required List<int> value})
          writeWithoutResponse,
      required Future<int> Function(
              {required String deviceId, required int mtu})
          requestSpace,
      required Future<List<DiscoveredService>> Function(String deviceId)
          bleDiscoverServices,
      required Future<List<int>> Function(
              QualifiedCharacteristic characteristic)
          readcharacteristic})
      : _bleDiscoverServices = bleDiscoverServices,
        _readcharacteristic = readcharacteristic,
        _writeWithoutResponse = writeWithoutResponse,
        _resquestSpace = requestSpace;

  Future<List<DiscoveredService>> discoverServices(String deviceId) async {
    try {
      print('Start discovering services for: $deviceId');
      final result = await _bleDiscoverServices(deviceId);
      print('Discovering services finished');
      return result;
    } on Exception catch (e) {
      print('Error occured when discovering services: $e');
      rethrow;
    }
  }

  Future<List<int>> readCharacteristic(
      QualifiedCharacteristic characteristic) async {
    try {
      final result = await _readcharacteristic(characteristic);

      print(
          'Read ${characteristic.characteristicId}: value = ${utf8.decode(result)}');
      return result;
    } on Exception catch (e, s) {
      print(
        'Error occured when reading ${characteristic.characteristicId} : $e',
      );
      // ignore: avoid_print
      print(s);
      rethrow;
    }
  }

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

  //Future<int> Function({required String deviceId, required int mtu})
  Future<int> requestMtu(String deviceId, int mtu) async {
    try {
      final resultado = await _resquestSpace(deviceId: deviceId, mtu: mtu);
      return resultado;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
