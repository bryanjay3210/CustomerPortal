import 'package:freezed_annotation/freezed_annotation.dart';
part 'tv_device.freezed.dart';
part 'tv_device.g.dart';

@freezed
class TvDevice with _$TvDevice {
  factory TvDevice({
    @Default('') dynamic id,
    @Default('') dynamic device_name,
    @Default('') dynamic mac,
    @Default('') dynamic PublicIP,
    @Default('') dynamic PrivateIP,
    @Default('') dynamic Interface,
    @Default('') dynamic ClientType,
    @Default('') dynamic ClientStatus,
    @Default('') dynamic SoftwareVersion,
    @Default('') dynamic Storage,
    @Default('') dynamic Chan,
    @Default('') dynamic is_community,
  }) = _TvDevice;

  factory TvDevice.fromJson(Map<String, dynamic> json) =>
      _$TvDeviceFromJson(json);
}
