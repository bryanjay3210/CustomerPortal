import 'package:cp/model/product_group/product/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'product_group.freezed.dart';
part 'product_group.g.dart';

@freezed
class ProductGroup with _$ProductGroup {
  factory ProductGroup({
    @Default('') dynamic GroupID,
    @Default('') dynamic GroupName,
    @Default('') dynamic CustomerAvailable,
    List<Product>? Products,
  }) = _ProductGroup;

  factory ProductGroup.fromJson(Map<String, dynamic> json) =>
      _$ProductGroupFromJson(json);
}
