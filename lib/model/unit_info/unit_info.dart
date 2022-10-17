import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'unit_info.freezed.dart';
part 'unit_info.g.dart';

@freezed
class UnitInfo with _$UnitInfo {
  factory UnitInfo({
    @Default('') dynamic BedName,
    @Default('') dynamic CustomerName,
    @Default('') dynamic UserFname,
    @Default('') dynamic UserLname,
    @Default('') dynamic UnitID,
    @Default('') dynamic UnitName,
    @Default('') dynamic CustomerID,
    @Default('') dynamic UserID,
    @Default('') dynamic Suspended,
    @Default('') dynamic BuildingName,
    @Default('') dynamic UserPhoneMobile,
    @Default('') dynamic CustomerPin,
    @Default('') dynamic UserEmail,
  }) = _UnitInfo;

  factory UnitInfo.fromJson(Map<String, dynamic> json) =>
      _$UnitInfoFromJson(json);
}
