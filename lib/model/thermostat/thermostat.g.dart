// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thermostat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Thermostat _$$_ThermostatFromJson(Map<String, dynamic> json) =>
    _$_Thermostat(
      ThingID: json['ThingID'] ?? '',
      UnitID: json['UnitID'] ?? '',
      UnitName: json['UnitName'] ?? '',
      Mode: json['Mode'] ?? '',
      ModeLink: json['ModeLink'] ?? '',
      RoomTemp: json['RoomTemp'] ?? '',
      RoomTempLink: json['RoomTempLink'] ?? '',
      Setpoint: json['Setpoint'] ?? '',
      SetpointLink: json['SetpointLink'] ?? '',
      SetpointCtrl: json['SetpointCtrl'] ?? '',
      SetpointCtrlLink: json['SetpointCtrlLink'] ?? '',
      AptStatus: json['AptStatus'] ?? '',
    );

Map<String, dynamic> _$$_ThermostatToJson(_$_Thermostat instance) =>
    <String, dynamic>{
      'ThingID': instance.ThingID,
      'UnitID': instance.UnitID,
      'UnitName': instance.UnitName,
      'Mode': instance.Mode,
      'ModeLink': instance.ModeLink,
      'RoomTemp': instance.RoomTemp,
      'RoomTempLink': instance.RoomTempLink,
      'Setpoint': instance.Setpoint,
      'SetpointLink': instance.SetpointLink,
      'SetpointCtrl': instance.SetpointCtrl,
      'SetpointCtrlLink': instance.SetpointCtrlLink,
      'AptStatus': instance.AptStatus,
    };
