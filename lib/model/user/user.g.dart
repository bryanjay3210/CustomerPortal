// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      Command: json['Command'] ?? '',
      Subcommand1: json['Subcommand1'] ?? '',
      UserID: json['UserID'] ?? '',
      UserType: json['UserType'] ?? '',
      CustomerID: json['CustomerID'] ?? '',
      GUID: json['GUID'] ?? '',
      CustomerType: json['CustomerType'] ?? '',
      BuildingID: json['BuildingID'] ?? '',
      Status: json['Status'] ?? '',
      Response: json['Response'] ?? '',
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'Command': instance.Command,
      'Subcommand1': instance.Subcommand1,
      'UserID': instance.UserID,
      'UserType': instance.UserType,
      'CustomerID': instance.CustomerID,
      'GUID': instance.GUID,
      'CustomerType': instance.CustomerType,
      'BuildingID': instance.BuildingID,
      'Status': instance.Status,
      'Response': instance.Response,
    };
