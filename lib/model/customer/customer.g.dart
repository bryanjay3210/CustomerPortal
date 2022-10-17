// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Customer _$$_CustomerFromJson(Map<String, dynamic> json) => _$_Customer(
      CustomerName: json['CustomerName'] ?? '',
      CustomerID: json['CustomerID'] ?? '',
      CustomerTargetID: json['CustomerTargetID'] ?? '',
      CustomerTargetEmail: json['CustomerTargetEmail'] ?? '',
    );

Map<String, dynamic> _$$_CustomerToJson(_$_Customer instance) =>
    <String, dynamic>{
      'CustomerName': instance.CustomerName,
      'CustomerID': instance.CustomerID,
      'CustomerTargetID': instance.CustomerTargetID,
      'CustomerTargetEmail': instance.CustomerTargetEmail,
    };
