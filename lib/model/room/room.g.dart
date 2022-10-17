// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Room _$$_RoomFromJson(Map<String, dynamic> json) => _$_Room(
      RoomID: json['RoomID'] ?? '',
      CustomerId: json['CustomerId'] ?? '',
      UnitId: json['UnitId'] ?? '',
      RoomName: json['RoomName'] ?? '',
      Items: (json['Items'] as List<dynamic>?)
              ?.map((e) => Thing.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_RoomToJson(_$_Room instance) => <String, dynamic>{
      'RoomID': instance.RoomID,
      'CustomerId': instance.CustomerId,
      'UnitId': instance.UnitId,
      'RoomName': instance.RoomName,
      'Items': instance.Items,
    };
