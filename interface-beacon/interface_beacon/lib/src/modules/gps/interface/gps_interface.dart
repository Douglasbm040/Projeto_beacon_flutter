import 'package:geolocator/geolocator.dart';
import 'package:interface_beacon/src/modules/gps/services/gps_service.dart';

abstract class GpsInterface {
  Position get local;
  Future<Position> determinePosition();
  StateGpsService get state;
}
