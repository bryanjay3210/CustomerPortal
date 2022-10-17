// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'building.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Building _$BuildingFromJson(Map<String, dynamic> json) {
  return _Building.fromJson(json);
}

/// @nodoc
mixin _$Building {
  dynamic get BuildingName => throw _privateConstructorUsedError;
  dynamic get BuildingID => throw _privateConstructorUsedError;
  dynamic get RegionID => throw _privateConstructorUsedError;
  dynamic get IOTBuilding => throw _privateConstructorUsedError;
  dynamic get ResidenceHall => throw _privateConstructorUsedError;
  dynamic get Type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BuildingCopyWith<Building> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuildingCopyWith<$Res> {
  factory $BuildingCopyWith(Building value, $Res Function(Building) then) =
      _$BuildingCopyWithImpl<$Res>;
  $Res call(
      {dynamic BuildingName,
      dynamic BuildingID,
      dynamic RegionID,
      dynamic IOTBuilding,
      dynamic ResidenceHall,
      dynamic Type});
}

/// @nodoc
class _$BuildingCopyWithImpl<$Res> implements $BuildingCopyWith<$Res> {
  _$BuildingCopyWithImpl(this._value, this._then);

  final Building _value;
  // ignore: unused_field
  final $Res Function(Building) _then;

  @override
  $Res call({
    Object? BuildingName = freezed,
    Object? BuildingID = freezed,
    Object? RegionID = freezed,
    Object? IOTBuilding = freezed,
    Object? ResidenceHall = freezed,
    Object? Type = freezed,
  }) {
    return _then(_value.copyWith(
      BuildingName: BuildingName == freezed
          ? _value.BuildingName
          : BuildingName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      BuildingID: BuildingID == freezed
          ? _value.BuildingID
          : BuildingID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      RegionID: RegionID == freezed
          ? _value.RegionID
          : RegionID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      IOTBuilding: IOTBuilding == freezed
          ? _value.IOTBuilding
          : IOTBuilding // ignore: cast_nullable_to_non_nullable
              as dynamic,
      ResidenceHall: ResidenceHall == freezed
          ? _value.ResidenceHall
          : ResidenceHall // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Type: Type == freezed
          ? _value.Type
          : Type // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_BuildingCopyWith<$Res> implements $BuildingCopyWith<$Res> {
  factory _$$_BuildingCopyWith(
          _$_Building value, $Res Function(_$_Building) then) =
      __$$_BuildingCopyWithImpl<$Res>;
  @override
  $Res call(
      {dynamic BuildingName,
      dynamic BuildingID,
      dynamic RegionID,
      dynamic IOTBuilding,
      dynamic ResidenceHall,
      dynamic Type});
}

/// @nodoc
class __$$_BuildingCopyWithImpl<$Res> extends _$BuildingCopyWithImpl<$Res>
    implements _$$_BuildingCopyWith<$Res> {
  __$$_BuildingCopyWithImpl(
      _$_Building _value, $Res Function(_$_Building) _then)
      : super(_value, (v) => _then(v as _$_Building));

  @override
  _$_Building get _value => super._value as _$_Building;

  @override
  $Res call({
    Object? BuildingName = freezed,
    Object? BuildingID = freezed,
    Object? RegionID = freezed,
    Object? IOTBuilding = freezed,
    Object? ResidenceHall = freezed,
    Object? Type = freezed,
  }) {
    return _then(_$_Building(
      BuildingName: BuildingName == freezed
          ? _value.BuildingName
          : BuildingName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      BuildingID: BuildingID == freezed
          ? _value.BuildingID
          : BuildingID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      RegionID: RegionID == freezed
          ? _value.RegionID
          : RegionID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      IOTBuilding: IOTBuilding == freezed
          ? _value.IOTBuilding
          : IOTBuilding // ignore: cast_nullable_to_non_nullable
              as dynamic,
      ResidenceHall: ResidenceHall == freezed
          ? _value.ResidenceHall
          : ResidenceHall // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Type: Type == freezed
          ? _value.Type
          : Type // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Building implements _Building {
  _$_Building(
      {this.BuildingName = '',
      this.BuildingID = '',
      this.RegionID = '',
      this.IOTBuilding = '',
      this.ResidenceHall = '',
      this.Type = ''});

  factory _$_Building.fromJson(Map<String, dynamic> json) =>
      _$$_BuildingFromJson(json);

  @override
  @JsonKey()
  final dynamic BuildingName;
  @override
  @JsonKey()
  final dynamic BuildingID;
  @override
  @JsonKey()
  final dynamic RegionID;
  @override
  @JsonKey()
  final dynamic IOTBuilding;
  @override
  @JsonKey()
  final dynamic ResidenceHall;
  @override
  @JsonKey()
  final dynamic Type;

  @override
  String toString() {
    return 'Building(BuildingName: $BuildingName, BuildingID: $BuildingID, RegionID: $RegionID, IOTBuilding: $IOTBuilding, ResidenceHall: $ResidenceHall, Type: $Type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Building &&
            const DeepCollectionEquality()
                .equals(other.BuildingName, BuildingName) &&
            const DeepCollectionEquality()
                .equals(other.BuildingID, BuildingID) &&
            const DeepCollectionEquality().equals(other.RegionID, RegionID) &&
            const DeepCollectionEquality()
                .equals(other.IOTBuilding, IOTBuilding) &&
            const DeepCollectionEquality()
                .equals(other.ResidenceHall, ResidenceHall) &&
            const DeepCollectionEquality().equals(other.Type, Type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(BuildingName),
      const DeepCollectionEquality().hash(BuildingID),
      const DeepCollectionEquality().hash(RegionID),
      const DeepCollectionEquality().hash(IOTBuilding),
      const DeepCollectionEquality().hash(ResidenceHall),
      const DeepCollectionEquality().hash(Type));

  @JsonKey(ignore: true)
  @override
  _$$_BuildingCopyWith<_$_Building> get copyWith =>
      __$$_BuildingCopyWithImpl<_$_Building>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BuildingToJson(
      this,
    );
  }
}

abstract class _Building implements Building {
  factory _Building(
      {final dynamic BuildingName,
      final dynamic BuildingID,
      final dynamic RegionID,
      final dynamic IOTBuilding,
      final dynamic ResidenceHall,
      final dynamic Type}) = _$_Building;

  factory _Building.fromJson(Map<String, dynamic> json) = _$_Building.fromJson;

  @override
  dynamic get BuildingName;
  @override
  dynamic get BuildingID;
  @override
  dynamic get RegionID;
  @override
  dynamic get IOTBuilding;
  @override
  dynamic get ResidenceHall;
  @override
  dynamic get Type;
  @override
  @JsonKey(ignore: true)
  _$$_BuildingCopyWith<_$_Building> get copyWith =>
      throw _privateConstructorUsedError;
}
