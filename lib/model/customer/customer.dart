import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  factory Customer(
      {@Default('') dynamic CustomerName,
      @Default('') dynamic CustomerID,
      @Default('') dynamic CustomerTargetID,
      @Default('') dynamic CustomerTargetEmail}) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
