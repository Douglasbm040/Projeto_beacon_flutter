abstract class QrScannerInterface {
  Future<void> readQrcode();
  String get result;
}
