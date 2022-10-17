// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductGroup _$$_ProductGroupFromJson(Map<String, dynamic> json) =>
    _$_ProductGroup(
      GroupID: json['GroupID'] ?? '',
      GroupName: json['GroupName'] ?? '',
      CustomerAvailable: json['CustomerAvailable'] ?? '',
      Products: (json['Products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ProductGroupToJson(_$_ProductGroup instance) =>
    <String, dynamic>{
      'GroupID': instance.GroupID,
      'GroupName': instance.GroupName,
      'CustomerAvailable': instance.CustomerAvailable,
      'Products': instance.Products,
    };
