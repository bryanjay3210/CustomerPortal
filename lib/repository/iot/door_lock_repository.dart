import 'package:cp/service/api_request.dart';

class DoorLockRepository extends RequestApi {
  DoorLockRepository(int server) : super(server);

  dynamic getDLockList(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Cmd": "DlocList",
      "BuildingID": map["buildingId"],
      "UnitID": map["unitId"],
      "LockType": map["lockType"],
      "LoggedUser": map["loggedUser"]
    };
    return await getApi(dataUrl, type: 'lock');
  }

  dynamic assignDLock(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Cmd": "DlocAssign",
      "Subcommand1": "A",
      "BuildingID": map["buildingId"],
      "UnitID": map["unitId"],
      "MAC": map["mac"],
      "LockType": "1",
      "LoggedUser": map["loggedUser"]
    };
    return await getApi(dataUrl, type: 'lock');
  }

  dynamic removeDLock(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Cmd": "DlocAssign",
      "Subcommand1": "R",
      "BuildingID": "303545",
      "UnitID": "303963",
      "MAC": "123456789012",
      "LoggedUser": "1"
    };
    return await getApi(dataUrl, type: 'lock');
  }

  dynamic dLockPasswordAdd(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Cmd": "DlocPassword",
      "Subcommand1": "A",
      "CustomerID": "308001",
      "Label": "Pass2",
      "Password": "Pass1234",
      "EffectiveStart": "",
      "EffectiveStop": "",
      "EntryCount": "0",
      "LoggedUser": "1"
    };
    return await getApi(dataUrl, type: 'lock');
  }

  dynamic dLockPasswordEdit(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Cmd": "DlocPassword",
      "Subcommand1": "E",
      "CustomerID": "308001",
      "Slot": "4",
      "Label": "Pass2",
      "Password": "Pass1234",
      "EffectiveStart": "",
      "EffectiveStop": "",
      "Entr yCount": "0",
      "LoggedUser": "1"
    };
    return await getApi(dataUrl, type: 'lock');
  }

  dynamic dLockPasswordRemove(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Cmd": "DlocPassword",
      "Subcommand1": "R",
      "CustomerID": "308001",
      "Slot": "1",
      "LoggedUser": "1"
    };
    return await getApi(dataUrl, type: 'lock');
  }

  dynamic dLockPasswordDisable(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Cmd": "DlocPassword",
      "Subcommand1": "D",
      "CustomerID": "308001",
      "Slot": "1",
      "LoggedUser": "1"
    };
    return await getApi(dataUrl, type: 'lock');
  }

  dynamic dLockPasswordEnable(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Cmd": "DlocPassword",
      "Subcommand1": "U",
      "CustomerID": "308001",
      "Slot": "1",
      "LoggedUser": "1"
    };
    return await getApi(dataUrl, type: 'lock');
  }

  dynamic dLockPasswordFlush(Map<String, dynamic> map) async {
    dynamic dataUrl = {
      "Cmd": "DlocPassword",
      "Subcommand1": "F",
      "CustomerID": "308001",
      "Slot": "1",
      "LoggedUser": "1"
    };
    return await getApi(dataUrl, type: 'lock');
  }
}
