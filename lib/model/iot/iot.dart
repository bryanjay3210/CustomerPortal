import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'iot.freezed.dart';
part 'iot.g.dart';

@freezed
class Iot with _$Iot {
  factory Iot({
    @Default('') dynamic Command,
    @Default('') dynamic Subcommand1,
    @Default('') dynamic ControllerID,
    @Default('') dynamic ControllerIP,
    @Default('') dynamic ControllerUUID,
    @Default('') dynamic ControllerBuildingID,
    @Default('') dynamic ControllerBuildingUnitID,
    @Default('') dynamic IOTUserType,
    @Default('') dynamic Status,
  }) = _Iot;

  factory Iot.fromJson(Map<String, dynamic> json) => _$IotFromJson(json);
}
