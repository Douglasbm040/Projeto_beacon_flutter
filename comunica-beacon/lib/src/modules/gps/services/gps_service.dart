import 'dart:async';

import 'package:comunica_beacons/src/modules/gps/interface/gps_interface.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

enum StateGpsService {
  start,
  startservice,
  notfoundservice,
  permissiondenied,
  permissiondeniedforever,
  localization
}

class GpsService extends ChangeNotifier implements GpsInfertface {
  var local;
  double? distanceInMeters;
  StateGpsService _state = StateGpsService.start;
  double lat = 0;
  double long = 0;

  //double get distanceInMeters => _distanceInMeters;
  @override
  //var get local => _local;

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
    local = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _state = StateGpsService.localization;
    notifyListeners();
    return local;
  }

  Stream<Position> positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high, distanceFilter: 5));

  double? distanceBetween(
      {required double startlat,
      required double startlong,
      required double endLat,
      required double endLong}) {
    distanceInMeters =
        Geolocator.distanceBetween(startlat, startlong, endLat, endLong);
    print(distanceInMeters);
    notifyListeners();
    return distanceInMeters;
  }
}
