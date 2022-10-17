import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  factory Product({
    @Default('') dynamic PlanID,
    @Default('') dynamic PlanPrice,
    @Default('') dynamic PlanName,
    @Default('') dynamic PlanStartDate,
    @Default('') dynamic PlanEndDate,
    @Default('') dynamic PaymentProcessor,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
