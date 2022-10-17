import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_message_group.freezed.dart';
part 'customer_message_group.g.dart';

@freezed
class CustomerMessageGroup with _$CustomerMessageGroup {
  factory CustomerMessageGroup({
    @Default('') dynamic CustomerID,
    @Default('') dynamic Name,
    @Default('') dynamic FirstName,
    @Default('') dynamic LastName,
  }) = _CustomerMessageGroup;

  factory CustomerMessageGroup.fromJson(Map<String, dynamic> json) =>
      _$CustomerMessageGroupFromJson(json);
}
