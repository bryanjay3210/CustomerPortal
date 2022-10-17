import 'package:freezed_annotation/freezed_annotation.dart';
part 'wifi_user.freezed.dart';
part 'wifi_user.g.dart';

@freezed
class WifiUser with _$WifiUser {
  factory WifiUser({
    @Default('') dynamic WifiUserID,
    @Default('') dynamic WifiUserName,
    @Default('') dynamic WifiPassword,
  }) = _WifiUser;

  factory WifiUser.fromJson(Map<String, dynamic> json) =>
      _$WifiUserFromJson(json);
}
