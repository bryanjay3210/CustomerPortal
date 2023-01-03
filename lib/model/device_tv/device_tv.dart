import 'package:freezed_annotation/freezed_annotation.dart';
part 'device_tv.freezed.dart';
part 'device_tv.g.dart';

@freezed
class DeviceTv with _$DeviceTv {
  factory DeviceTv({
    @Default('') dynamic TVID,
    @Default('') dynamic Location,
    @Default('') dynamic MAC,
    @Default('') dynamic OnOff,
    @Default('') dynamic Volume,
    @Default('') dynamic CC,
    @Default('') dynamic ID,
    @Default('') dynamic is_community,
    @Default('') dynamic Channel,
  }) = _DeviceTv;

  factory DeviceTv.fromJson(Map<String, dynamic> json) =>
      _$DeviceTvFromJson(json);
}
