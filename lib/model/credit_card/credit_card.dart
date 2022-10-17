import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'credit_card.freezed.dart';
part 'credit_card.g.dart';

@freezed
class CreditCard with _$CreditCard {
  factory CreditCard({
    @Default('') dynamic CardNum,
    @Default('') dynamic CardholderName,
    @Default('') dynamic CardType,
    @Default('') dynamic CardExpMonth,
    @Default('') dynamic CardExpYear,
    @Default('') dynamic CardCVV,
    @Default('') dynamic CardAutobill,
  }) = _CreditCard;

  factory CreditCard.fromJson(Map<String, dynamic> json) =>
      _$CreditCardFromJson(json);
}
