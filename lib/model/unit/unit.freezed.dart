// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'unit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Unit _$UnitFromJson(Map<String, dynamic> json) {
  return _Unit.fromJson(json);
}

/// @nodoc
mixin _$Unit {
  dynamic get UnitName => throw _privateConstructorUsedError;
  dynamic get UnitID => throw _privateConstructorUsedError;
  dynamic get UnitType => throw _privateConstructorUsedError;
  dynamic get Occupied => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnitCopyWith<Unit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnitCopyWith<$Res> {
  factory $UnitCopyWith(Unit value, $Res Function(Unit) then) =
      _$UnitCopyWithImpl<$Res>;
  $Res call(
      {dynamic UnitName, dynamic UnitID, dynamic UnitType, dynamic Occupied});
}

/// @nodoc
class _$UnitCopyWithImpl<$Res> implements $UnitCopyWith<$Res> {
  _$UnitCopyWithImpl(this._value, this._then);

  final Unit _value;
  // ignore: unused_field
  final $Res Function(Unit) _then;

  @override
  $Res call({
    Object? UnitName = freezed,
    Object? UnitID = freezed,
    Object? UnitType = freezed,
    Object? Occupied = freezed,
  }) {
    return _then(_value.copyWith(
      UnitName: UnitName == freezed
          ? _value.UnitName
          : UnitName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      UnitID: UnitID == freezed
          ? _value.UnitID
          : UnitID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      UnitType: UnitType == freezed
          ? _value.UnitType
          : UnitType // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Occupied: Occupied == freezed
          ? _value.Occupied
          : Occupied // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_UnitCopyWith<$Res> implements $UnitCopyWith<$Res> {
  factory _$$_UnitCopyWith(_$_Unit value, $Res Function(_$_Unit) then) =
      __$$_UnitCopyWithImpl<$Res>;
  @override
  $Res call(
      {dynamic UnitName, dynamic UnitID, dynamic UnitType, dynamic Occupied});
}

/// @nodoc
class __$$_UnitCopyWithImpl<$Res> extends _$UnitCopyWithImpl<$Res>
    implements _$$_UnitCopyWith<$Res> {
  __$$_UnitCopyWithImpl(_$_Unit _value, $Res Function(_$_Unit) _then)
      : super(_value, (v) => _then(v as _$_Unit));

  @override
  _$_Unit get _value => super._value as _$_Unit;

  @override
  $Res call({
    Object? UnitName = freezed,
    Object? UnitID = freezed,
    Object? UnitType = freezed,
    Object? Occupied = freezed,
  }) {
    return _then(_$_Unit(
      UnitName: UnitName == freezed
          ? _value.UnitName
          : UnitName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      UnitID: UnitID == freezed
          ? _value.UnitID
          : UnitID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      UnitType: UnitType == freezed
          ? _value.UnitType
          : UnitType // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Occupied: Occupied == freezed
          ? _value.Occupied
          : Occupied // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Unit implements _Unit {
  _$_Unit(
      {this.UnitName = '',
      this.UnitID = '',
      this.UnitType = '',
      this.Occupied = ''});

  factory _$_Unit.fromJson(Map<String, dynamic> json) => _$$_UnitFromJson(json);

  @override
  @JsonKey()
  final dynamic UnitName;
  @override
  @JsonKey()
  final dynamic UnitID;
  @override
  @JsonKey()
  final dynamic UnitType;
  @override
  @JsonKey()
  final dynamic Occupied;

  @override
  String toString() {
    return 'Unit(UnitName: $UnitName, UnitID: $UnitID, UnitType: $UnitType, Occupied: $Occupied)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Unit &&
            const DeepCollectionEquality().equals(other.UnitName, UnitName) &&
            const DeepCollectionEquality().equals(other.UnitID, UnitID) &&
            const DeepCollectionEquality().equals(other.UnitType, UnitType) &&
            const DeepCollectionEquality().equals(other.Occupied, Occupied));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(UnitName),
      const DeepCollectionEquality().hash(UnitID),
      const DeepCollectionEquality().hash(UnitType),
      const DeepCollectionEquality().hash(Occupied));

  @JsonKey(ignore: true)
  @override
  _$$_UnitCopyWith<_$_Unit> get copyWith =>
      __$$_UnitCopyWithImpl<_$_Unit>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UnitToJson(
      this,
    );
  }
}

abstract class _Unit implements Unit {
  factory _Unit(
      {final dynamic UnitName,
      final dynamic UnitID,
      final dynamic UnitType,
      final dynamic Occupied}) = _$_Unit;

  factory _Unit.fromJson(Map<String, dynamic> json) = _$_Unit.fromJson;

  @override
  dynamic get UnitName;
  @override
  dynamic get UnitID;
  @override
  dynamic get UnitType;
  @override
  dynamic get Occupied;
  @override
  @JsonKey(ignore: true)
  _$$_UnitCopyWith<_$_Unit> get copyWith => throw _privateConstructorUsedError;
}
