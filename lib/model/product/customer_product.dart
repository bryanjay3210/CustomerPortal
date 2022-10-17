import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'customer_product.freezed.dart';
part 'customer_product.g.dart';

@freezed
class CustomerProduct with _$CustomerProduct {
  factory CustomerProduct({
    @Default('') dynamic ProductID,
    @Default('') dynamic ProductName,
    @Default('') dynamic IsProductActive,
    @Default('') dynamic ProductActivationCharge,
    @Default('') dynamic ProductUOM,
    @Default('') dynamic ProductCyclePrice,
    @Default('') dynamic ProductBillCycle,
    @Default('') dynamic ProductProratable,
    @Default('') dynamic ProductStartDate,
    @Default('') dynamic ProductEndDate,
    @Default('') dynamic ProductInstance,
  }) = _CustomerProduct;

  factory CustomerProduct.fromJson(Map<String, dynamic> json) =>
      _$CustomerProductFromJson(json);
}
