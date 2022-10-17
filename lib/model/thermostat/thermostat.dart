import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'thermostat.freezed.dart';
part 'thermostat.g.dart';

@freezed
class Thermostat with _$Thermostat {
  factory Thermostat({
    @Default('') dynamic ThingID,
    @Default('') dynamic UnitID,
    @Default('') dynamic UnitName,
    @Default('') dynamic Mode,
    @Default('') dynamic ModeLink,
    @Default('') dynamic RoomTemp,
    @Default('') dynamic RoomTempLink,
    @Default('') dynamic Setpoint,
    @Default('') dynamic SetpointLink,
    @Default('') dynamic SetpointCtrl,
    @Default('') dynamic SetpointCtrlLink,
    @Default('') dynamic AptStatus,
  }) = _Thermostat;

  factory Thermostat.fromJson(Map<String, dynamic> json) =>
      _$ThermostatFromJson(json);
}
