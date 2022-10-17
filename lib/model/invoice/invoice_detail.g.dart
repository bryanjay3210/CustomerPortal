// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InvoicesDetail _$$_InvoicesDetailFromJson(Map<String, dynamic> json) =>
    _$_InvoicesDetail(
      DetailID: json['DetailID'] ?? '',
      DetailItem: json['DetailItem'] ?? '',
      DetailItemDescription: json['DetailItemDescription'] ?? '',
      DetailItemQuantity: json['DetailItemQuantity'] ?? '',
      DetailItemPrice: json['DetailItemPrice'] ?? '',
      DetailItemDate: json['DetailItemDate'] ?? '',
      DetailItemSDate: json['DetailItemSDate'] ?? '',
      DetailItemEDate: json['DetailItemEDate'] ?? '',
      DetailItemTaxed: json['DetailItemTaxed'] ?? '',
    );

Map<String, dynamic> _$$_InvoicesDetailToJson(_$_InvoicesDetail instance) =>
    <String, dynamic>{
      'DetailID': instance.DetailID,
      'DetailItem': instance.DetailItem,
      'DetailItemDescription': instance.DetailItemDescription,
      'DetailItemQuantity': instance.DetailItemQuantity,
      'DetailItemPrice': instance.DetailItemPrice,
      'DetailItemDate': instance.DetailItemDate,
      'DetailItemSDate': instance.DetailItemSDate,
      'DetailItemEDate': instance.DetailItemEDate,
      'DetailItemTaxed': instance.DetailItemTaxed,
    };
