// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sent_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SentMessageModel _$$_SentMessageModelFromJson(Map<String, dynamic> json) =>
    _$_SentMessageModel(
      MessageID: json['MessageID'] ?? '',
      MessageDate: json['MessageDate'] ?? '',
      CreatorID: json['CreatorID'] ?? '',
      CreatorName: json['CreatorName'] ?? '',
      Subject: json['Subject'] ?? '',
      Message: json['Message'] ?? '',
      Ack: json['Ack'] ?? '',
    );

Map<String, dynamic> _$$_SentMessageModelToJson(_$_SentMessageModel instance) =>
    <String, dynamic>{
      'MessageID': instance.MessageID,
      'MessageDate': instance.MessageDate,
      'CreatorID': instance.CreatorID,
      'CreatorName': instance.CreatorName,
      'Subject': instance.Subject,
      'Message': instance.Message,
      'Ack': instance.Ack,
    };
