import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    @Default('') dynamic Command,
    @Default('') dynamic Subcommand1,
    @Default('') dynamic UserID,
    @Default('') dynamic UserType,
    @Default('') dynamic CustomerID,
    @Default('') dynamic GUID,
    @Default('') dynamic CustomerType,
    @Default('') dynamic BuildingID,
    @Default('') dynamic Status,
    @Default('') dynamic Response,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
