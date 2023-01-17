import 'package:interface_beacon/src/modules/qrscanner/service/qrscanner_service.dart';

abstract class QrScannerInterface {
  Future<void> readQrcode();
  String get result;
  StateQrScannerService get state;
}
