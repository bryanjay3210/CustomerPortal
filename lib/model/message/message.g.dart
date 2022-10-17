// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageModel _$$_MessageModelFromJson(Map<String, dynamic> json) =>
    _$_MessageModel(
      MessageID: json['MessageID'] ?? '',
      MessageDate: json['MessageDate'] ?? '',
      CreatorID: json['CreatorID'] ?? '',
      Subject: json['Subject'] ?? '',
      Message: json['Message'] ?? '',
      Ack: json['Ack'] ?? '',
    );

Map<String, dynamic> _$$_MessageModelToJson(_$_MessageModel instance) =>
    <String, dynamic>{
      'MessageID': instance.MessageID,
      'MessageDate': instance.MessageDate,
      'CreatorID': instance.CreatorID,
      'Subject': instance.Subject,
      'Message': instance.Message,
      'Ack': instance.Ack,
    };
