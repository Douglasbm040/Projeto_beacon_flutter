import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:interface_beacon/src/modules/db/firebase/interfaces/database_interface.dart';
import 'package:interface_beacon/src/shared/models/beacon_device.dart';

class DataBaseRepository extends ChangeNotifier implements DataBaseInterface {
  Map _device = {};
  late final DatabaseReference _dataRef =
      FirebaseDatabase.instance.ref("Device");
  late StreamSubscription<DatabaseEvent> _dataSubscription;
  get device => _device;
  // _dataRef = FirebaseDatabase.instance.ref("dados");
  requisition() async {
    try {
      final _dataSnapshot = await _dataRef.get();
      _device = _dataSnapshot.value as Map;
    } catch (e) {
      print(e.toString());
    }
    _dataSubscription = _dataRef.onValue.listen((DatabaseEvent event) {
      _device = (event.snapshot.value ?? 0) as Map;
    });
  }

  @override
  insert({required Map<String, dynamic> value}) async {
    await _dataRef.set(value);
  }

  void dispose() {
    _dataSubscription.cancel();
    super.dispose();
  }
}
