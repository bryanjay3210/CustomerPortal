import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

import '../../../enum.dart';
import '../../../model/building/building.dart';
import '../../../model/device/device.dart';
import '../../../model/unit/unit.dart';
import '../../../repository/account/message_manager/message_group.dart';
import '../../../repository/iot/door_lock_repository.dart';
import '../../../repository/manager/customer_repository.dart';
import '../../main_provider.dart';

class DoorLockProvider {
  final doorLocks$ = BehaviorSubject<DataState>.seeded(DataState.initial);
  final units$ = BehaviorSubject<DataState>.seeded(DataState.initial);
  final buildings$ = BehaviorSubject<DataState>.seeded(DataState.empty);
  var devices = <Device>[];
  var units = <Unit>[];
  var buildings = <Building>[];
  var selectedBuilding = Building();
  var selectedUnit = Unit();

  getBuildings(Map<String, dynamic> map, BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['buildingId'] = mainProvider.user.BuildingID;
    map['loggedUser'] = mainProvider.user.UserID;
    Map<String, dynamic> data =
        await MessageGroupRepository(map['server']).getBuildings(map, context);
    final newItems = <Building>[];
    if (data['Status'] == "Success") {
      if (data['Building'] == null) {
        buildings$.add(DataState.empty);
        return;
      } else if (data['Building'] is Map) {
        newItems.add(Building.fromJson(data['Building']));
      } else {
        data['Building'].forEach((element) {
          if (element['IOTBuilding'] is Map) {
            element['IOTBuilding'] = '';
          }
          newItems.add(Building.fromJson(element));
        });
      }
      buildings = newItems;
      // try {
      //   currentBuilding = newItems
      //       .firstWhere((element) => element.BuildingID == map['buildingId']);
      // } catch (ex) {
      //   currentBuilding = Building();
      // }
    } else {}
    buildings$.add(DataState.success);
  }

  getDLockList(Map<String, dynamic> map, BuildContext context) async {
    doorLocks$.add(DataState.loading);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['loggedUser'] = mainProvider.user.UserID;
    map['buildingId'] = selectedBuilding.BuildingID;
    map['unitId'] = selectedUnit.UnitID;
    map['lockType'] = '1';
    Map<String, dynamic> data =
        await DoorLockRepository(map['server']).getDLockList(map);
    final newItems = <Device>[];
    if (data['Status'] == "Success") {
      // if (data['Device'] == null) {
      //   devices$.add(DataState.empty);
      //   return;
      // } else if (data['Device'] is Map) {
      //   newItems.add(Device.fromJson(data['Device']));
      // } else {
      //   data['Device'].forEach((element) {
      //     if (element['Name'] is Map) {
      //       element['Name'] = '';
      //     }
      //     newItems.add(Device.fromJson(element));
      //   });
      // }
      // devices = newItems;
      doorLocks$.add(DataState.success);
    } else {
      doorLocks$.add(DataState.success);
    }
  }

  getUnits(Map<String, dynamic> map, BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['loggedUser'] = mainProvider.user.UserID;
    map['buildingId'] = selectedBuilding.BuildingID;
    units$.add(DataState.loading);
    Map<String, dynamic> data =
        await CustomerRepository(map['server']).getUnits(map, context);
    final newItems = <Unit>[];
    newItems.add(Unit());
    if (data['Status'] == "Success") {
      if (data['Unit'] == null) {
        // units$.add(DataState.empty)
        return;
      } else if (data['Unit'] is Map) {
        newItems.add(Unit.fromJson(data['Unit']));
      } else {
        data['Unit'].forEach((element) {
          newItems.add(Unit.fromJson(element));
        });
      }
      units = newItems;
      // populateDropDowns();
    }
    units$.add(DataState.success);
  }

  assignDLock(Map<String, dynamic> map, BuildContext context,
      VoidCallback callback) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server;
    map['mac'] = "234567891341";
    map['unitId'] = selectedUnit.UnitID;
    map['loggedUser'] = mainProvider.user.UserID;
    map['buildingId'] = selectedBuilding.BuildingID;
    doorLocks$.add(DataState.loading);
    Map<String, dynamic> data =
        await DoorLockRepository(map['server']).assignDLock(map);
    if (data['Status'] == 'Success') {
      getDLockList(map, context);
      if (callback != null) {
        callback();
      }
      doorLocks$.add(DataState.success);
    } else {
      doorLocks$.add(DataState.error);
    }
  }

  removeDLock(Map<String, dynamic> map, BuildContext context) async {
    doorLocks$.add(DataState.loading);
    Map<String, dynamic> data =
        await DoorLockRepository(map['server']).removeDLock(map);
    if (data['Status'] == 'Success') {
      // await getdevices(map, context);
      // devices.removeWhere((element) => element.ThingID == map['thingId']);
      print('data doorlock get dLockList: $map');
      doorLocks$.add(DataState.success);
    } else {
      doorLocks$.add(DataState.success);
    }
  }
}
