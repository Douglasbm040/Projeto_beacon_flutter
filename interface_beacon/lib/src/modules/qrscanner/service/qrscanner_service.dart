import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:interface_beacon/src/modules/qrscanner/interface/qrscanner_interface.dart';

class QrScannerService extends ChangeNotifier implements QrScannerInterface {
  String _rsult = "";

  String get result => _rsult;

  Future<void> readQrcode() async {
    try {
      String code = await FlutterBarcodeScanner.scanBarcode(
          "red", "cancelar", false, ScanMode.QR);
      _rsult = code != "-1" ? code : "nao encontrado";
    } catch (e) {
      print(e);
    }
  }
}
