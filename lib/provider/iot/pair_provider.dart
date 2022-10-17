import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:rxdart/subjects.dart';

import '../../enum.dart';
import '../../model/device/device.dart';
import '../../repository/iot/pair_repository.dart';

class PairProvider {
  final devices$ = BehaviorSubject<DataState>.seeded(DataState.initial);
  var devices = <Device>[];

  getDevices(Map<String, dynamic> map, BuildContext context) async {
    devices$.add(DataState.loading);
    Map<String, dynamic> data =
        await PairRepository(map['server']).getDevices(map);
    final newItems = <Device>[];
    if (data['Status'] == "Success") {
      if (data['Device'] == null) {
        devices$.add(DataState.empty);
        return;
      } else if (data['Device'] is Map) {
        newItems.add(Device.fromJson(data['Device']));
      } else {
        data['Device'].forEach((element) {
          if (element['Name'] is Map) {
            element['Name'] = '';
          }
          newItems.add(Device.fromJson(element));
        });
      }
      devices = newItems;
      devices$.add(DataState.success);
    } else {
      devices$.add(DataState.success);
    }
  }

  deleteDevice(Map<String, dynamic> map, BuildContext context) async {
    devices$.add(DataState.loading);
    Map<String, dynamic> data =
        await PairRepository(map['server']).removeDevice(map);
    if (data['Status'] == 'Success') {
      // await getdevices(map, context);
      devices.removeWhere((element) => element.ThingID == map['thingId']);
      devices$.add(DataState.success);
    } else {
      devices$.add(DataState.success);
    }
  }

  addDevice(Map<String, dynamic> map, BuildContext context,
      VoidCallback callback) async {
    devices$.add(DataState.loading);
    Map<String, dynamic> data =
        await PairRepository(map['server']).pairDeviceManual(map);
    if (data['Status'] == 'Success') {
      getDevices(map, context);
      if (callback != null) {
        callback();
      }
      devices$.add(DataState.success);
    } else {
      devices$.add(DataState.error);
    }
  }
}
