// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      PlanID: json['PlanID'] ?? '',
      PlanPrice: json['PlanPrice'] ?? '',
      PlanName: json['PlanName'] ?? '',
      PlanStartDate: json['PlanStartDate'] ?? '',
      PlanEndDate: json['PlanEndDate'] ?? '',
      PaymentProcessor: json['PaymentProcessor'] ?? '',
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'PlanID': instance.PlanID,
      'PlanPrice': instance.PlanPrice,
      'PlanName': instance.PlanName,
      'PlanStartDate': instance.PlanStartDate,
      'PlanEndDate': instance.PlanEndDate,
      'PaymentProcessor': instance.PaymentProcessor,
    };
