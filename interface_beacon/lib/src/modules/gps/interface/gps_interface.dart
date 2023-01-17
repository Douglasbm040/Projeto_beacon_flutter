import 'package:geolocator/geolocator.dart';

abstract class GpsInterface {
  Position get local;
  Future<Position> determinePosition();
}
