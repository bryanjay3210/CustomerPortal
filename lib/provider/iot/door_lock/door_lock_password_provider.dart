import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

import '../../../enum.dart';
import '../../../model/device/device.dart';
import '../../../repository/iot/door_lock_repository.dart';
import '../../main_provider.dart';

class DoorLockPasswordProvider {
  final devices$ = BehaviorSubject<DataState>.seeded(DataState.initial);
  var devices = <Device>[];

  getDLockList(Map<String, dynamic> map, BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    map['server'] = mainProvider.server.toString();
    map['loggedUser'] = mainProvider.user.UserID;
    map['buildingId'] = mainProvider.user.BuildingID;
    map['lockType'] = "10";
    devices$.add(DataState.loading);
    Map<String, dynamic> data =
        await DoorLockRepository(map['server']).getDLockList(map);
    final newItems = <Device>[];
    if (data['Status'] == "Success") {
      print('data doorlock get dLockList: $map');
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
      devices$.add(DataState.success);
    } else {
      devices$.add(DataState.success);
    }
  }

  assignDLock(Map<String, dynamic> map, BuildContext context,
      VoidCallback callback) async {
    devices$.add(DataState.loading);
    Map<String, dynamic> data =
        await DoorLockRepository(map['server']).assignDLock(map);
    if (data['Status'] == 'Success') {
      getDLockList(map, context);
      if (callback != null) {
        callback();
      }
      devices$.add(DataState.success);
    } else {
      devices$.add(DataState.error);
    }
  }

  removeDLock(Map<String, dynamic> map, BuildContext context) async {
    devices$.add(DataState.loading);
    Map<String, dynamic> data =
        await DoorLockRepository(map['server']).removeDLock(map);
    if (data['Status'] == 'Success') {
      // await getdevices(map, context);
      // devices.removeWhere((element) => element.ThingID == map['thingId']);
      print('data doorlock get dLockList: $map');
      devices$.add(DataState.success);
    } else {
      devices$.add(DataState.success);
    }
  }
}
