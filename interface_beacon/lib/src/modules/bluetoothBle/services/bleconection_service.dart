import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/interfaces/bleconection_interface.dart';

enum conexao { conectado, disconectado, errordisconection, erroroconection }

class BleConectorService extends ChangeNotifier implements IBleConection {
  final FlutterReactiveBle _ble;

  BleConectorService({
    required FlutterReactiveBle ble,
  }) : _ble = ble;
  conexao _plug = conexao.disconectado;

  @override
  conexao get plug => _plug;

  Stream<ConnectionStateUpdate> get state => _deviceConnectionController.stream;

  final _deviceConnectionController = StreamController<ConnectionStateUpdate>();

  late StreamSubscription<ConnectionStateUpdate> _connection;

  @override
  Future<void> connect(String deviceId) async {
    print('Start connecting to $deviceId');
    _connection = _ble.connectToDevice(id: deviceId).listen((update) {
      print('ConnectionState for device $deviceId ');
      _deviceConnectionController.add(update);
      _plug = conexao.conectado;
      notifyListeners();
    }, onError: (Object e) {
      print('Connecting to device $deviceId resulted in error $e');
      _plug = conexao.erroroconection;
      notifyListeners();
    });
  }

  @override
  Future<void> disconnect(String deviceId) async {
    try {
      print('disconnecting to device: $deviceId');
      await _connection.cancel();
      _plug = conexao.disconectado;
      notifyListeners();
    } on Exception catch (e, _) {
      print("Error disconnecting from a device: $e");
      _plug = conexao.errordisconection;
      notifyListeners();
    } finally {
      // Since [_connection] subscription is terminated, the "disconnected" state cannot be received and propagated
      _deviceConnectionController.add(
        ConnectionStateUpdate(
          deviceId: deviceId,
          connectionState: DeviceConnectionState.disconnected,
          failure: null,
        ),
      );
    }
  }

  Future<void> dispose() async {
    await _deviceConnectionController.close();
  }
}
