import 'package:freezed_annotation/freezed_annotation.dart';
part 'unit.freezed.dart';
part 'unit.g.dart';

@freezed
class Unit with _$Unit {
  factory Unit({
    @Default('') dynamic UnitName,
    @Default('') dynamic UnitID,
    @Default('') dynamic UnitType,
    @Default('') dynamic Occupied,
  }) = _Unit;

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);
}
