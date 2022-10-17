// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'device_tv.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DeviceTv _$DeviceTvFromJson(Map<String, dynamic> json) {
  return _DeviceTv.fromJson(json);
}

/// @nodoc
mixin _$DeviceTv {
  dynamic get TVID => throw _privateConstructorUsedError;
  dynamic get Location => throw _privateConstructorUsedError;
  dynamic get MAC => throw _privateConstructorUsedError;
  dynamic get OnOff => throw _privateConstructorUsedError;
  dynamic get Volume => throw _privateConstructorUsedError;
  dynamic get CC => throw _privateConstructorUsedError;
  dynamic get ID => throw _privateConstructorUsedError;
  dynamic get Channel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeviceTvCopyWith<DeviceTv> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceTvCopyWith<$Res> {
  factory $DeviceTvCopyWith(DeviceTv value, $Res Function(DeviceTv) then) =
      _$DeviceTvCopyWithImpl<$Res>;
  $Res call(
      {dynamic TVID,
      dynamic Location,
      dynamic MAC,
      dynamic OnOff,
      dynamic Volume,
      dynamic CC,
      dynamic ID,
      dynamic Channel});
}

/// @nodoc
class _$DeviceTvCopyWithImpl<$Res> implements $DeviceTvCopyWith<$Res> {
  _$DeviceTvCopyWithImpl(this._value, this._then);

  final DeviceTv _value;
  // ignore: unused_field
  final $Res Function(DeviceTv) _then;

  @override
  $Res call({
    Object? TVID = freezed,
    Object? Location = freezed,
    Object? MAC = freezed,
    Object? OnOff = freezed,
    Object? Volume = freezed,
    Object? CC = freezed,
    Object? ID = freezed,
    Object? Channel = freezed,
  }) {
    return _then(_value.copyWith(
      TVID: TVID == freezed
          ? _value.TVID
          : TVID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Location: Location == freezed
          ? _value.Location
          : Location // ignore: cast_nullable_to_non_nullable
              as dynamic,
      MAC: MAC == freezed
          ? _value.MAC
          : MAC // ignore: cast_nullable_to_non_nullable
              as dynamic,
      OnOff: OnOff == freezed
          ? _value.OnOff
          : OnOff // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Volume: Volume == freezed
          ? _value.Volume
          : Volume // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CC: CC == freezed
          ? _value.CC
          : CC // ignore: cast_nullable_to_non_nullable
              as dynamic,
      ID: ID == freezed
          ? _value.ID
          : ID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Channel: Channel == freezed
          ? _value.Channel
          : Channel // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_DeviceTvCopyWith<$Res> implements $DeviceTvCopyWith<$Res> {
  factory _$$_DeviceTvCopyWith(
          _$_DeviceTv value, $Res Function(_$_DeviceTv) then) =
      __$$_DeviceTvCopyWithImpl<$Res>;
  @override
  $Res call(
      {dynamic TVID,
      dynamic Location,
      dynamic MAC,
      dynamic OnOff,
      dynamic Volume,
      dynamic CC,
      dynamic ID,
      dynamic Channel});
}

/// @nodoc
class __$$_DeviceTvCopyWithImpl<$Res> extends _$DeviceTvCopyWithImpl<$Res>
    implements _$$_DeviceTvCopyWith<$Res> {
  __$$_DeviceTvCopyWithImpl(
      _$_DeviceTv _value, $Res Function(_$_DeviceTv) _then)
      : super(_value, (v) => _then(v as _$_DeviceTv));

  @override
  _$_DeviceTv get _value => super._value as _$_DeviceTv;

  @override
  $Res call({
    Object? TVID = freezed,
    Object? Location = freezed,
    Object? MAC = freezed,
    Object? OnOff = freezed,
    Object? Volume = freezed,
    Object? CC = freezed,
    Object? ID = freezed,
    Object? Channel = freezed,
  }) {
    return _then(_$_DeviceTv(
      TVID: TVID == freezed
          ? _value.TVID
          : TVID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Location: Location == freezed
          ? _value.Location
          : Location // ignore: cast_nullable_to_non_nullable
              as dynamic,
      MAC: MAC == freezed
          ? _value.MAC
          : MAC // ignore: cast_nullable_to_non_nullable
              as dynamic,
      OnOff: OnOff == freezed
          ? _value.OnOff
          : OnOff // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Volume: Volume == freezed
          ? _value.Volume
          : Volume // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CC: CC == freezed
          ? _value.CC
          : CC // ignore: cast_nullable_to_non_nullable
              as dynamic,
      ID: ID == freezed
          ? _value.ID
          : ID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Channel: Channel == freezed
          ? _value.Channel
          : Channel // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DeviceTv implements _DeviceTv {
  _$_DeviceTv(
      {this.TVID = '',
      this.Location = '',
      this.MAC = '',
      this.OnOff = '',
      this.Volume = '',
      this.CC = '',
      this.ID = '',
      this.Channel = ''});

  factory _$_DeviceTv.fromJson(Map<String, dynamic> json) =>
      _$$_DeviceTvFromJson(json);

  @override
  @JsonKey()
  final dynamic TVID;
  @override
  @JsonKey()
  final dynamic Location;
  @override
  @JsonKey()
  final dynamic MAC;
  @override
  @JsonKey()
  final dynamic OnOff;
  @override
  @JsonKey()
  final dynamic Volume;
  @override
  @JsonKey()
  final dynamic CC;
  @override
  @JsonKey()
  final dynamic ID;
  @override
  @JsonKey()
  final dynamic Channel;

  @override
  String toString() {
    return 'DeviceTv(TVID: $TVID, Location: $Location, MAC: $MAC, OnOff: $OnOff, Volume: $Volume, CC: $CC, ID: $ID, Channel: $Channel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeviceTv &&
            const DeepCollectionEquality().equals(other.TVID, TVID) &&
            const DeepCollectionEquality().equals(other.Location, Location) &&
            const DeepCollectionEquality().equals(other.MAC, MAC) &&
            const DeepCollectionEquality().equals(other.OnOff, OnOff) &&
            const DeepCollectionEquality().equals(other.Volume, Volume) &&
            const DeepCollectionEquality().equals(other.CC, CC) &&
            const DeepCollectionEquality().equals(other.ID, ID) &&
            const DeepCollectionEquality().equals(other.Channel, Channel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(TVID),
      const DeepCollectionEquality().hash(Location),
      const DeepCollectionEquality().hash(MAC),
      const DeepCollectionEquality().hash(OnOff),
      const DeepCollectionEquality().hash(Volume),
      const DeepCollectionEquality().hash(CC),
      const DeepCollectionEquality().hash(ID),
      const DeepCollectionEquality().hash(Channel));

  @JsonKey(ignore: true)
  @override
  _$$_DeviceTvCopyWith<_$_DeviceTv> get copyWith =>
      __$$_DeviceTvCopyWithImpl<_$_DeviceTv>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeviceTvToJson(
      this,
    );
  }
}

abstract class _DeviceTv implements DeviceTv {
  factory _DeviceTv(
      {final dynamic TVID,
      final dynamic Location,
      final dynamic MAC,
      final dynamic OnOff,
      final dynamic Volume,
      final dynamic CC,
      final dynamic ID,
      final dynamic Channel}) = _$_DeviceTv;

  factory _DeviceTv.fromJson(Map<String, dynamic> json) = _$_DeviceTv.fromJson;

  @override
  dynamic get TVID;
  @override
  dynamic get Location;
  @override
  dynamic get MAC;
  @override
  dynamic get OnOff;
  @override
  dynamic get Volume;
  @override
  dynamic get CC;
  @override
  dynamic get ID;
  @override
  dynamic get Channel;
  @override
  @JsonKey(ignore: true)
  _$$_DeviceTvCopyWith<_$_DeviceTv> get copyWith =>
      throw _privateConstructorUsedError;
}
