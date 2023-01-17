import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:interface_beacon/src/modules/gps/interface/gps_interface.dart';

enum StateGpsService {
  start,
  startservice,
  notfoundservice,
  permissiondenied,
  permissiondeniedforever,
  localization
}

class GpsService extends ChangeNotifier implements GpsInterface {
  late final Position _local;
  StateGpsService _state = StateGpsService.start;
  @override
  Position get local => _local;

  StateGpsService get state => _state;
  @override
  Future<Position> determinePosition() async {
    bool serveEnabled;
    LocationPermission permission;
    serveEnabled = await Geolocator.isLocationServiceEnabled();
    _state = StateGpsService.startservice;
    notifyListeners();

    if (!serveEnabled) {
      _state = StateGpsService.notfoundservice;
      notifyListeners();
      return Future.error("Servico nao encontrado");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _state = StateGpsService.permissiondenied;
        notifyListeners();
        return Future.error("permissao de localizacao não liberada");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _state = StateGpsService.permissiondeniedforever;
      notifyListeners();
      return Future.error("localizacao nao permitida para sempre");
    }
    _local = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _state = StateGpsService.localization;
    notifyListeners();
    return local;
  }
}
