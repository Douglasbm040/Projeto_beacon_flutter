import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:interface_beacon/src/modules/database/firebase/interfaces/database_interface.dart';

enum StateFirebase {
  start,
  errorequisition,
  erroinsert,
  requistioncorrect,
  insertcorrect
}

class DataBaseRepository extends ChangeNotifier implements DataBaseInterface {
  Map<String,dynamic> _device = {};
  StateFirebase _state = StateFirebase.start;
  late final DatabaseReference _dataRef =
      FirebaseDatabase.instance.ref("Device");
  late StreamSubscription<DatabaseEvent> _dataSubscription;

  @override
  get device => _device;
  @override
  StateFirebase get state => _state;
  @override
  requisition() async {
    try {
      final _dataSnapshot = await _dataRef.get();
      _device = _dataSnapshot.value as Map<String,dynamic>;
      _state = StateFirebase.requistioncorrect;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      _state = StateFirebase.errorequisition;
      notifyListeners();
    }
    _dataSubscription = _dataRef.onValue.listen((DatabaseEvent event) {
      _device = (event.snapshot.value ?? 0) as Map<String,dynamic>;
      notifyListeners();
    });
  }

  @override
  insert({required Map<String, dynamic> value}) async {
    try {
      await _dataRef.set(value);
      _state = StateFirebase.insertcorrect;
      notifyListeners();
    } catch (e) {
      print(e);
      _state = StateFirebase.erroinsert;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _dataSubscription.cancel();
    super.dispose();
  }
}
