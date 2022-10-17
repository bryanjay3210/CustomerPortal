// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CreditCard _$$_CreditCardFromJson(Map<String, dynamic> json) =>
    _$_CreditCard(
      CardNum: json['CardNum'] ?? '',
      CardholderName: json['CardholderName'] ?? '',
      CardType: json['CardType'] ?? '',
      CardExpMonth: json['CardExpMonth'] ?? '',
      CardExpYear: json['CardExpYear'] ?? '',
      CardCVV: json['CardCVV'] ?? '',
      CardAutobill: json['CardAutobill'] ?? '',
    );

Map<String, dynamic> _$$_CreditCardToJson(_$_CreditCard instance) =>
    <String, dynamic>{
      'CardNum': instance.CardNum,
      'CardholderName': instance.CardholderName,
      'CardType': instance.CardType,
      'CardExpMonth': instance.CardExpMonth,
      'CardExpYear': instance.CardExpYear,
      'CardCVV': instance.CardCVV,
      'CardAutobill': instance.CardAutobill,
    };
