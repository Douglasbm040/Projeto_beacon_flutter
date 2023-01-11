import '../services/bleconection_service.dart';

abstract class IBleConection {
  Future<void> connect(String deviceId);
  Future<void> disconnect(String deviceId);
  conexao get plug;
}
