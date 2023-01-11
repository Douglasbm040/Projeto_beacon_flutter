import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:interface_beacon/src/modules/db/firebase/interfaces/database_interface.dart';
import 'package:interface_beacon/src/shared/models/beacon_device.dart';

class DataBaseRepository extends ChangeNotifier implements DataBaseInterface {
  final Uri _urldb = Uri(
      scheme: "https", host: "fir-e0b3c.firebaseio.com", path: "/devices.json");
  final Uri url = Uri.parse("https://fir-e0b3c.firebaseio.com/devices.json");
  
  @override
  Future<void> insert() async {
    final response = await http.post(
      url,
      body: json.encode(
        {
          'name': 'farmacia',
          'latitude': 123234,
          'longitude': 1231234,
        },
      ),
    );
  }

  @override
  Future<void> requisition() async {
    final get = await http.get(_urldb);
    final decode = get.body;
    print(decode);
  }
}
