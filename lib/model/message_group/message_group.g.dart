// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageGroup _$$_MessageGroupFromJson(Map<String, dynamic> json) =>
    _$_MessageGroup(
      GroupID: json['GroupID'] ?? '',
      GroupName: json['GroupName'] ?? '',
      GroupType: json['GroupType'] ?? '',
      GroupAccess: json['GroupAccess'] ?? '',
      GroupDesc: json['GroupDesc'] ?? '',
      DefaultAcceptMessage: json['DefaultAcceptMessage'] ?? '',
      DefaultRejectMessage: json['DefaultRejectMessage'] ?? '',
      ModeratorsEmail: json['ModeratorsEmail'] ?? '',
      ReplyEmail: json['ReplyEmail'] ?? '',
      CanReply: json['CanReply'] ?? '',
      ModeratorCustomerID: json['ModeratorCustomerID'] ?? '',
      ModeratorUserID: json['ModeratorUserID'] ?? '',
      ModeratorUsername: json['ModeratorUsername'] ?? '',
      CustomerList: (json['CustomerList'] as List<dynamic>)
          .map((e) => Customer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_MessageGroupToJson(_$_MessageGroup instance) =>
    <String, dynamic>{
      'GroupID': instance.GroupID,
      'GroupName': instance.GroupName,
      'GroupType': instance.GroupType,
      'GroupAccess': instance.GroupAccess,
      'GroupDesc': instance.GroupDesc,
      'DefaultAcceptMessage': instance.DefaultAcceptMessage,
      'DefaultRejectMessage': instance.DefaultRejectMessage,
      'ModeratorsEmail': instance.ModeratorsEmail,
      'ReplyEmail': instance.ReplyEmail,
      'CanReply': instance.CanReply,
      'ModeratorCustomerID': instance.ModeratorCustomerID,
      'ModeratorUserID': instance.ModeratorUserID,
      'ModeratorUsername': instance.ModeratorUsername,
      'CustomerList': instance.CustomerList,
    };
