import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:interface_beacon/src/modules/gps/interface/gps_interface.dart';

class GpsService extends ChangeNotifier implements GpsInterface {
  late final Position _local;

  @override
  Position get local => _local;
  @override
  Future<Position> determinePosition() async {
    bool serveEnabled;
    LocationPermission permission;

    serveEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serveEnabled) {
      return Future.error("Servico nao encontrado");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("permissao de localizacao não liberada");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("localizacao nao permitida para sempre");
    }
    _local = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return local;
  }
}
