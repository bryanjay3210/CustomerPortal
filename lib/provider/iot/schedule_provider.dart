import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import '../../enum.dart';
import '../../model/scene/scene.dart';
import '../../model/schedule/schedule.dart';
import '../../repository/iot/schedule_repository.dart';

class ScheduleProvider {
//stream
  final schedules$ = BehaviorSubject<DataState>.seeded(DataState.loading);

// objects
  var selectedScene = Scene(Items: []);
  var allSchedules = <Schedule>[];

  getSchedules(Map<String, dynamic> map, BuildContext context) async {
    schedules$.add(DataState.loading);
    Map<String, dynamic> data =
        await ScheduleRepository(map['server']).getSchedules(map);

    if (data['Status'] == 'Success') {
      final item = data['Schedule'];
      allSchedules.clear();
      if (item == null) {
        // allSchedules = Schedule();
      } else if (item.runtimeType.toString() == '_JsonMap') {
        allSchedules.add(Schedule.fromJson(item));
      } else if (item.runtimeType.toString() ==
          '_InternalLinkedHashMap<String, dynamic>') {
        var hMap = HashMap.from(item);
        allSchedules.add(Schedule.fromJson(hMap.cast()));
      } else {
        allSchedules
            .addAll([...List.from(item).map((e) => Schedule.fromJson(e))]);
        // allSchedules = Schedule.fromJson(data['Schedule']);
      }

      schedules$.add(DataState.success);
    } else {
      // schedules$.add(DataState.success);
    }
  }

  setSchedule(Map<String, dynamic> map, BuildContext context) async {
    schedules$.add(DataState.loading);
    Map<String, dynamic> data =
        await ScheduleRepository(map['server']).setSchedule(map, context);
    if (data['Status'] == 'Success') {
      map['scheduleId'] = data['ScheduleID'];
      final sched = Schedule(
          DayList: map['dayList'],
          SceneID: map['sceneId'],
          ScheduleID: map['scheduleId'],
          Time: map['time'],
          UnitID: map['unitId']);

      if (map['subCommand1'] == 'Add') {
        allSchedules.add(sched);
      } else {
        allSchedules.remove(sched);
      }

      schedules$.add(DataState.success);
    } else {
      schedules$.add(DataState.success);
    }
  }
}
