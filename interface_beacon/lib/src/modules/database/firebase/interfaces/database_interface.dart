import 'package:interface_beacon/src/modules/database/firebase/repository/database_repository.dart';

abstract class DataBaseInterface {
  insert({required Map<String, dynamic> value});
  requisition();
  Map<String,dynamic> get device;
  StateFirebase get state;
}
