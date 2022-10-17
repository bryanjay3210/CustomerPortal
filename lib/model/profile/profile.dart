import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  factory Profile({
    @Default('') dynamic UserType,
    @Default('') dynamic UserFirstName,
    @Default('') dynamic UserLastName,
    @Default('') dynamic UserName,
    @Default('') dynamic UserPassword,
    @Default('') dynamic UserPhoneHome,
    @Default('') dynamic UserPhoneWork,
    @Default('') dynamic UserPhoneMobile,
    @Default('') dynamic UserEmail,
    @Default('') dynamic UserTimeZone,
    @Default('') dynamic UserInfo,
    @Default('') dynamic UserPin,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
