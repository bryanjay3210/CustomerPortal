// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Building _$$_BuildingFromJson(Map<String, dynamic> json) => _$_Building(
      BuildingName: json['BuildingName'] ?? '',
      BuildingID: json['BuildingID'] ?? '',
      RegionID: json['RegionID'] ?? '',
      IOTBuilding: json['IOTBuilding'] ?? '',
      ResidenceHall: json['ResidenceHall'] ?? '',
      Type: json['Type'] ?? '',
    );

Map<String, dynamic> _$$_BuildingToJson(_$_Building instance) =>
    <String, dynamic>{
      'BuildingName': instance.BuildingName,
      'BuildingID': instance.BuildingID,
      'RegionID': instance.RegionID,
      'IOTBuilding': instance.IOTBuilding,
      'ResidenceHall': instance.ResidenceHall,
      'Type': instance.Type,
    };
