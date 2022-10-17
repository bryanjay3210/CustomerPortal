import 'package:freezed_annotation/freezed_annotation.dart';
part 'device.freezed.dart';
part 'device.g.dart';

@freezed
class Device with _$Device {
  factory Device({
    @Default('') dynamic ThingID,
    @Default('') dynamic Online,
    @Default('') dynamic Name,
    @Default('') dynamic UUID,
  }) = _Device;

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
}
