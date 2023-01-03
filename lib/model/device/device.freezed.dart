// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return _Device.fromJson(json);
}

/// @nodoc
mixin _$Device {
  dynamic get ThingID => throw _privateConstructorUsedError;
  dynamic get Online => throw _privateConstructorUsedError;
  dynamic get Name => throw _privateConstructorUsedError;
  dynamic get UUID => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeviceCopyWith<Device> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceCopyWith<$Res> {
  factory $DeviceCopyWith(Device value, $Res Function(Device) then) =
      _$DeviceCopyWithImpl<$Res, Device>;
  @useResult
  $Res call({dynamic ThingID, dynamic Online, dynamic Name, dynamic UUID});
}

/// @nodoc
class _$DeviceCopyWithImpl<$Res, $Val extends Device>
    implements $DeviceCopyWith<$Res> {
  _$DeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ThingID = freezed,
    Object? Online = freezed,
    Object? Name = freezed,
    Object? UUID = freezed,
  }) {
    return _then(_value.copyWith(
      ThingID: freezed == ThingID
          ? _value.ThingID
          : ThingID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Online: freezed == Online
          ? _value.Online
          : Online // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Name: freezed == Name
          ? _value.Name
          : Name // ignore: cast_nullable_to_non_nullable
              as dynamic,
      UUID: freezed == UUID
          ? _value.UUID
          : UUID // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DeviceCopyWith<$Res> implements $DeviceCopyWith<$Res> {
  factory _$$_DeviceCopyWith(_$_Device value, $Res Function(_$_Device) then) =
      __$$_DeviceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic ThingID, dynamic Online, dynamic Name, dynamic UUID});
}

/// @nodoc
class __$$_DeviceCopyWithImpl<$Res>
    extends _$DeviceCopyWithImpl<$Res, _$_Device>
    implements _$$_DeviceCopyWith<$Res> {
  __$$_DeviceCopyWithImpl(_$_Device _value, $Res Function(_$_Device) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ThingID = freezed,
    Object? Online = freezed,
    Object? Name = freezed,
    Object? UUID = freezed,
  }) {
    return _then(_$_Device(
      ThingID: freezed == ThingID
          ? _value.ThingID
          : ThingID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Online: freezed == Online
          ? _value.Online
          : Online // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Name: freezed == Name
          ? _value.Name
          : Name // ignore: cast_nullable_to_non_nullable
              as dynamic,
      UUID: freezed == UUID
          ? _value.UUID
          : UUID // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Device implements _Device {
  _$_Device(
      {this.ThingID = '', this.Online = '', this.Name = '', this.UUID = ''});

  factory _$_Device.fromJson(Map<String, dynamic> json) =>
      _$$_DeviceFromJson(json);

  @override
  @JsonKey()
  final dynamic ThingID;
  @override
  @JsonKey()
  final dynamic Online;
  @override
  @JsonKey()
  final dynamic Name;
  @override
  @JsonKey()
  final dynamic UUID;

  @override
  String toString() {
    return 'Device(ThingID: $ThingID, Online: $Online, Name: $Name, UUID: $UUID)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Device &&
            const DeepCollectionEquality().equals(other.ThingID, ThingID) &&
            const DeepCollectionEquality().equals(other.Online, Online) &&
            const DeepCollectionEquality().equals(other.Name, Name) &&
            const DeepCollectionEquality().equals(other.UUID, UUID));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(ThingID),
      const DeepCollectionEquality().hash(Online),
      const DeepCollectionEquality().hash(Name),
      const DeepCollectionEquality().hash(UUID));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeviceCopyWith<_$_Device> get copyWith =>
      __$$_DeviceCopyWithImpl<_$_Device>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeviceToJson(
      this,
    );
  }
}

abstract class _Device implements Device {
  factory _Device(
      {final dynamic ThingID,
      final dynamic Online,
      final dynamic Name,
      final dynamic UUID}) = _$_Device;

  factory _Device.fromJson(Map<String, dynamic> json) = _$_Device.fromJson;

  @override
  dynamic get ThingID;
  @override
  dynamic get Online;
  @override
  dynamic get Name;
  @override
  dynamic get UUID;
  @override
  @JsonKey(ignore: true)
  _$$_DeviceCopyWith<_$_Device> get copyWith =>
      throw _privateConstructorUsedError;
}
