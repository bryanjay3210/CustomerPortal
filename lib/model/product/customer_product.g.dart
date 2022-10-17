// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CustomerProduct _$$_CustomerProductFromJson(Map<String, dynamic> json) =>
    _$_CustomerProduct(
      ProductID: json['ProductID'] ?? '',
      ProductName: json['ProductName'] ?? '',
      IsProductActive: json['IsProductActive'] ?? '',
      ProductActivationCharge: json['ProductActivationCharge'] ?? '',
      ProductUOM: json['ProductUOM'] ?? '',
      ProductCyclePrice: json['ProductCyclePrice'] ?? '',
      ProductBillCycle: json['ProductBillCycle'] ?? '',
      ProductProratable: json['ProductProratable'] ?? '',
      ProductStartDate: json['ProductStartDate'] ?? '',
      ProductEndDate: json['ProductEndDate'] ?? '',
      ProductInstance: json['ProductInstance'] ?? '',
    );

Map<String, dynamic> _$$_CustomerProductToJson(_$_CustomerProduct instance) =>
    <String, dynamic>{
      'ProductID': instance.ProductID,
      'ProductName': instance.ProductName,
      'IsProductActive': instance.IsProductActive,
      'ProductActivationCharge': instance.ProductActivationCharge,
      'ProductUOM': instance.ProductUOM,
      'ProductCyclePrice': instance.ProductCyclePrice,
      'ProductBillCycle': instance.ProductBillCycle,
      'ProductProratable': instance.ProductProratable,
      'ProductStartDate': instance.ProductStartDate,
      'ProductEndDate': instance.ProductEndDate,
      'ProductInstance': instance.ProductInstance,
    };
