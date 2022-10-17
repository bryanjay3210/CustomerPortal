// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Schedule _$$_ScheduleFromJson(Map<String, dynamic> json) => _$_Schedule(
      ScheduleID: json['ScheduleID'] ?? '',
      UnitID: json['UnitID'] ?? '',
      SceneID: json['SceneID'] ?? '',
      DayList: json['DayList'] ?? '',
      Time: json['Time'] ?? '',
    );

Map<String, dynamic> _$$_ScheduleToJson(_$_Schedule instance) =>
    <String, dynamic>{
      'ScheduleID': instance.ScheduleID,
      'UnitID': instance.UnitID,
      'SceneID': instance.SceneID,
      'DayList': instance.DayList,
      'Time': instance.Time,
    };
