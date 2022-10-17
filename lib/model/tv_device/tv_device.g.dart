// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TvDevice _$$_TvDeviceFromJson(Map<String, dynamic> json) => _$_TvDevice(
      id: json['id'] ?? '',
      device_name: json['device_name'] ?? '',
      mac: json['mac'] ?? '',
      PublicIP: json['PublicIP'] ?? '',
      PrivateIP: json['PrivateIP'] ?? '',
      Interface: json['Interface'] ?? '',
      ClientType: json['ClientType'] ?? '',
      ClientStatus: json['ClientStatus'] ?? '',
      SoftwareVersion: json['SoftwareVersion'] ?? '',
      Storage: json['Storage'] ?? '',
      Chan: json['Chan'] ?? '',
      is_community: json['is_community'] ?? '',
    );

Map<String, dynamic> _$$_TvDeviceToJson(_$_TvDevice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'device_name': instance.device_name,
      'mac': instance.mac,
      'PublicIP': instance.PublicIP,
      'PrivateIP': instance.PrivateIP,
      'Interface': instance.Interface,
      'ClientType': instance.ClientType,
      'ClientStatus': instance.ClientStatus,
      'SoftwareVersion': instance.SoftwareVersion,
      'Storage': instance.Storage,
      'Chan': instance.Chan,
      'is_community': instance.is_community,
    };
