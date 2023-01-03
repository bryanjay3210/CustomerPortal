// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_tv.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DeviceTv _$$_DeviceTvFromJson(Map<String, dynamic> json) => _$_DeviceTv(
      TVID: json['TVID'] ?? '',
      Location: json['Location'] ?? '',
      MAC: json['MAC'] ?? '',
      OnOff: json['OnOff'] ?? '',
      Volume: json['Volume'] ?? '',
      CC: json['CC'] ?? '',
      ID: json['ID'] ?? '',
      is_community: json['is_community'] ?? '',
      Channel: json['Channel'] ?? '',
    );

Map<String, dynamic> _$$_DeviceTvToJson(_$_DeviceTv instance) =>
    <String, dynamic>{
      'TVID': instance.TVID,
      'Location': instance.Location,
      'MAC': instance.MAC,
      'OnOff': instance.OnOff,
      'Volume': instance.Volume,
      'CC': instance.CC,
      'ID': instance.ID,
      'is_community': instance.is_community,
      'Channel': instance.Channel,
    };
