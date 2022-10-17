import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'invoice_detail.freezed.dart';
part 'invoice_detail.g.dart';

@freezed
class InvoicesDetail with _$InvoicesDetail {
  factory InvoicesDetail({
    @Default('') dynamic DetailID,
    @Default('') dynamic DetailItem,
    @Default('') dynamic DetailItemDescription,
    @Default('') dynamic DetailItemQuantity,
    @Default('') dynamic DetailItemPrice,
    @Default('') dynamic DetailItemDate,
    @Default('') dynamic DetailItemSDate,
    @Default('') dynamic DetailItemEDate,
    @Default('') dynamic DetailItemTaxed,
  }) = _InvoicesDetail;

  factory InvoicesDetail.fromJson(Map<String, dynamic> json) =>
      _$InvoicesDetailFromJson(json);
}
