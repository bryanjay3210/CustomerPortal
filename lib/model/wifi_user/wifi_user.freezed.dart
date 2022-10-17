// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wifi_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WifiUser _$WifiUserFromJson(Map<String, dynamic> json) {
  return _WifiUser.fromJson(json);
}

/// @nodoc
mixin _$WifiUser {
  dynamic get WifiUserID => throw _privateConstructorUsedError;
  dynamic get WifiUserName => throw _privateConstructorUsedError;
  dynamic get WifiPassword => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WifiUserCopyWith<WifiUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WifiUserCopyWith<$Res> {
  factory $WifiUserCopyWith(WifiUser value, $Res Function(WifiUser) then) =
      _$WifiUserCopyWithImpl<$Res>;
  $Res call({dynamic WifiUserID, dynamic WifiUserName, dynamic WifiPassword});
}

/// @nodoc
class _$WifiUserCopyWithImpl<$Res> implements $WifiUserCopyWith<$Res> {
  _$WifiUserCopyWithImpl(this._value, this._then);

  final WifiUser _value;
  // ignore: unused_field
  final $Res Function(WifiUser) _then;

  @override
  $Res call({
    Object? WifiUserID = freezed,
    Object? WifiUserName = freezed,
    Object? WifiPassword = freezed,
  }) {
    return _then(_value.copyWith(
      WifiUserID: WifiUserID == freezed
          ? _value.WifiUserID
          : WifiUserID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      WifiUserName: WifiUserName == freezed
          ? _value.WifiUserName
          : WifiUserName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      WifiPassword: WifiPassword == freezed
          ? _value.WifiPassword
          : WifiPassword // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_WifiUserCopyWith<$Res> implements $WifiUserCopyWith<$Res> {
  factory _$$_WifiUserCopyWith(
          _$_WifiUser value, $Res Function(_$_WifiUser) then) =
      __$$_WifiUserCopyWithImpl<$Res>;
  @override
  $Res call({dynamic WifiUserID, dynamic WifiUserName, dynamic WifiPassword});
}

/// @nodoc
class __$$_WifiUserCopyWithImpl<$Res> extends _$WifiUserCopyWithImpl<$Res>
    implements _$$_WifiUserCopyWith<$Res> {
  __$$_WifiUserCopyWithImpl(
      _$_WifiUser _value, $Res Function(_$_WifiUser) _then)
      : super(_value, (v) => _then(v as _$_WifiUser));

  @override
  _$_WifiUser get _value => super._value as _$_WifiUser;

  @override
  $Res call({
    Object? WifiUserID = freezed,
    Object? WifiUserName = freezed,
    Object? WifiPassword = freezed,
  }) {
    return _then(_$_WifiUser(
      WifiUserID: WifiUserID == freezed
          ? _value.WifiUserID
          : WifiUserID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      WifiUserName: WifiUserName == freezed
          ? _value.WifiUserName
          : WifiUserName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      WifiPassword: WifiPassword == freezed
          ? _value.WifiPassword
          : WifiPassword // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WifiUser implements _WifiUser {
  _$_WifiUser(
      {this.WifiUserID = '', this.WifiUserName = '', this.WifiPassword = ''});

  factory _$_WifiUser.fromJson(Map<String, dynamic> json) =>
      _$$_WifiUserFromJson(json);

  @override
  @JsonKey()
  final dynamic WifiUserID;
  @override
  @JsonKey()
  final dynamic WifiUserName;
  @override
  @JsonKey()
  final dynamic WifiPassword;

  @override
  String toString() {
    return 'WifiUser(WifiUserID: $WifiUserID, WifiUserName: $WifiUserName, WifiPassword: $WifiPassword)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WifiUser &&
            const DeepCollectionEquality()
                .equals(other.WifiUserID, WifiUserID) &&
            const DeepCollectionEquality()
                .equals(other.WifiUserName, WifiUserName) &&
            const DeepCollectionEquality()
                .equals(other.WifiPassword, WifiPassword));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(WifiUserID),
      const DeepCollectionEquality().hash(WifiUserName),
      const DeepCollectionEquality().hash(WifiPassword));

  @JsonKey(ignore: true)
  @override
  _$$_WifiUserCopyWith<_$_WifiUser> get copyWith =>
      __$$_WifiUserCopyWithImpl<_$_WifiUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WifiUserToJson(
      this,
    );
  }
}

abstract class _WifiUser implements WifiUser {
  factory _WifiUser(
      {final dynamic WifiUserID,
      final dynamic WifiUserName,
      final dynamic WifiPassword}) = _$_WifiUser;

  factory _WifiUser.fromJson(Map<String, dynamic> json) = _$_WifiUser.fromJson;

  @override
  dynamic get WifiUserID;
  @override
  dynamic get WifiUserName;
  @override
  dynamic get WifiPassword;
  @override
  @JsonKey(ignore: true)
  _$$_WifiUserCopyWith<_$_WifiUser> get copyWith =>
      throw _privateConstructorUsedError;
}
