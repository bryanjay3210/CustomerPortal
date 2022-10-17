// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Iot _$$_IotFromJson(Map<String, dynamic> json) => _$_Iot(
      Command: json['Command'] ?? '',
      Subcommand1: json['Subcommand1'] ?? '',
      ControllerID: json['ControllerID'] ?? '',
      ControllerIP: json['ControllerIP'] ?? '',
      ControllerUUID: json['ControllerUUID'] ?? '',
      ControllerBuildingID: json['ControllerBuildingID'] ?? '',
      ControllerBuildingUnitID: json['ControllerBuildingUnitID'] ?? '',
      IOTUserType: json['IOTUserType'] ?? '',
      Status: json['Status'] ?? '',
    );

Map<String, dynamic> _$$_IotToJson(_$_Iot instance) => <String, dynamic>{
      'Command': instance.Command,
      'Subcommand1': instance.Subcommand1,
      'ControllerID': instance.ControllerID,
      'ControllerIP': instance.ControllerIP,
      'ControllerUUID': instance.ControllerUUID,
      'ControllerBuildingID': instance.ControllerBuildingID,
      'ControllerBuildingUnitID': instance.ControllerBuildingUnitID,
      'IOTUserType': instance.IOTUserType,
      'Status': instance.Status,
    };
