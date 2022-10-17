// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'target.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Target _$TargetFromJson(Map<String, dynamic> json) {
  return _Target.fromJson(json);
}

/// @nodoc
mixin _$Target {
  dynamic get TargetID => throw _privateConstructorUsedError;
  dynamic get TargetEmail => throw _privateConstructorUsedError;
  dynamic get ResidentName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TargetCopyWith<Target> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TargetCopyWith<$Res> {
  factory $TargetCopyWith(Target value, $Res Function(Target) then) =
      _$TargetCopyWithImpl<$Res>;
  $Res call({dynamic TargetID, dynamic TargetEmail, dynamic ResidentName});
}

/// @nodoc
class _$TargetCopyWithImpl<$Res> implements $TargetCopyWith<$Res> {
  _$TargetCopyWithImpl(this._value, this._then);

  final Target _value;
  // ignore: unused_field
  final $Res Function(Target) _then;

  @override
  $Res call({
    Object? TargetID = freezed,
    Object? TargetEmail = freezed,
    Object? ResidentName = freezed,
  }) {
    return _then(_value.copyWith(
      TargetID: TargetID == freezed
          ? _value.TargetID
          : TargetID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      TargetEmail: TargetEmail == freezed
          ? _value.TargetEmail
          : TargetEmail // ignore: cast_nullable_to_non_nullable
              as dynamic,
      ResidentName: ResidentName == freezed
          ? _value.ResidentName
          : ResidentName // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_TargetCopyWith<$Res> implements $TargetCopyWith<$Res> {
  factory _$$_TargetCopyWith(_$_Target value, $Res Function(_$_Target) then) =
      __$$_TargetCopyWithImpl<$Res>;
  @override
  $Res call({dynamic TargetID, dynamic TargetEmail, dynamic ResidentName});
}

/// @nodoc
class __$$_TargetCopyWithImpl<$Res> extends _$TargetCopyWithImpl<$Res>
    implements _$$_TargetCopyWith<$Res> {
  __$$_TargetCopyWithImpl(_$_Target _value, $Res Function(_$_Target) _then)
      : super(_value, (v) => _then(v as _$_Target));

  @override
  _$_Target get _value => super._value as _$_Target;

  @override
  $Res call({
    Object? TargetID = freezed,
    Object? TargetEmail = freezed,
    Object? ResidentName = freezed,
  }) {
    return _then(_$_Target(
      TargetID: TargetID == freezed
          ? _value.TargetID
          : TargetID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      TargetEmail: TargetEmail == freezed
          ? _value.TargetEmail
          : TargetEmail // ignore: cast_nullable_to_non_nullable
              as dynamic,
      ResidentName: ResidentName == freezed
          ? _value.ResidentName
          : ResidentName // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Target implements _Target {
  _$_Target(
      {this.TargetID = '', this.TargetEmail = '', this.ResidentName = ''});

  factory _$_Target.fromJson(Map<String, dynamic> json) =>
      _$$_TargetFromJson(json);

  @override
  @JsonKey()
  final dynamic TargetID;
  @override
  @JsonKey()
  final dynamic TargetEmail;
  @override
  @JsonKey()
  final dynamic ResidentName;

  @override
  String toString() {
    return 'Target(TargetID: $TargetID, TargetEmail: $TargetEmail, ResidentName: $ResidentName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Target &&
            const DeepCollectionEquality().equals(other.TargetID, TargetID) &&
            const DeepCollectionEquality()
                .equals(other.TargetEmail, TargetEmail) &&
            const DeepCollectionEquality()
                .equals(other.ResidentName, ResidentName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(TargetID),
      const DeepCollectionEquality().hash(TargetEmail),
      const DeepCollectionEquality().hash(ResidentName));

  @JsonKey(ignore: true)
  @override
  _$$_TargetCopyWith<_$_Target> get copyWith =>
      __$$_TargetCopyWithImpl<_$_Target>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TargetToJson(
      this,
    );
  }
}

abstract class _Target implements Target {
  factory _Target(
      {final dynamic TargetID,
      final dynamic TargetEmail,
      final dynamic ResidentName}) = _$_Target;

  factory _Target.fromJson(Map<String, dynamic> json) = _$_Target.fromJson;

  @override
  dynamic get TargetID;
  @override
  dynamic get TargetEmail;
  @override
  dynamic get ResidentName;
  @override
  @JsonKey(ignore: true)
  _$$_TargetCopyWith<_$_Target> get copyWith =>
      throw _privateConstructorUsedError;
}
