import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/services/bleconection_service.dart';
import 'package:interface_beacon/src/modules/bluetoothBle/services/bleinteration_service.dart';
import 'package:interface_beacon/src/modules/custom/controllers/custom_textfield_controller.dart';
import 'package:interface_beacon/src/modules/database/firebase/repository/database_repository.dart';
import 'package:interface_beacon/src/modules/gps/services/gps_service.dart';
import 'package:interface_beacon/src/modules/qrscanner/service/qrscanner_service.dart';
import 'package:provider/provider.dart';

class ListProviders {
  static final FlutterReactiveBle _ble = FlutterReactiveBle();
  final providers = [
    
          ChangeNotifierProvider<GpsService>(
            create: (context) => GpsService(),
          ),
          ChangeNotifierProvider<CustomTextfieldController>(
              create: ((context) => CustomTextfieldController())),
          ChangeNotifierProvider<QrScannerService>(
              create: (context) => QrScannerService()),
          ChangeNotifierProvider<DataBaseRepository>(
            create: (context) => DataBaseRepository(),
          ),
          ChangeNotifierProvider<BleInterationService>(
            create: (context) => BleInterationService(
                requestSpace: _ble.requestMtu,
                writeWithoutResponse: _ble.writeCharacteristicWithoutResponse),
          ),
          ChangeNotifierProvider<BleConectorService>(
            create: (context) => BleConectorService(ble: _ble),
          )
        
  ];
}