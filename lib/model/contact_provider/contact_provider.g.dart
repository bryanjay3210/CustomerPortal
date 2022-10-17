// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ContactProvider _$$_ContactProviderFromJson(Map<String, dynamic> json) =>
    _$_ContactProvider(
      ProviderID: json['ProviderID'] ?? '',
      ProviderName: json['ProviderName'] ?? '',
      ProviderSMSEmail: json['ProviderSMSEmail'] ?? '',
      OptionID: json['OptionID'] ?? '',
      OptionEmail: json['OptionEmail'] ?? '',
      OptionSMS: json['OptionSMS'] ?? '',
      MessageApp: json['MessageApp'] ?? '',
      MessageEmail: json['MessageEmail'] ?? '',
      MessageSMS: json['MessageSMS'] ?? '',
    );

Map<String, dynamic> _$$_ContactProviderToJson(_$_ContactProvider instance) =>
    <String, dynamic>{
      'ProviderID': instance.ProviderID,
      'ProviderName': instance.ProviderName,
      'ProviderSMSEmail': instance.ProviderSMSEmail,
      'OptionID': instance.OptionID,
      'OptionEmail': instance.OptionEmail,
      'OptionSMS': instance.OptionSMS,
      'MessageApp': instance.MessageApp,
      'MessageEmail': instance.MessageEmail,
      'MessageSMS': instance.MessageSMS,
    };
