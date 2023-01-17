import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:interface_beacon/src/modules/qrscanner/interface/qrscanner_interface.dart';

enum StateQrScannerService { start, error, found, notfound }

class QrScannerService extends ChangeNotifier implements QrScannerInterface {
  String _result = "";

  StateQrScannerService _state = StateQrScannerService.start;
  StateQrScannerService get state => _state;
  @override
  String get result => _result;

  @override
  Future<void> readQrcode() async {
    try {
      String code = await FlutterBarcodeScanner.scanBarcode(
          "red", "cancelar", false, ScanMode.QR);
      _result = code != "-1" ? code : "nao encontrado";
      _state = code != "-1"
          ? StateQrScannerService.found
          : StateQrScannerService.notfound;
      notifyListeners();
    } catch (e) {
      print(e);
      _state = StateQrScannerService.error;
      notifyListeners();
    }
  }
}
