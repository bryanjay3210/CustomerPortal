// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  return _Schedule.fromJson(json);
}

/// @nodoc
mixin _$Schedule {
  dynamic get ScheduleID => throw _privateConstructorUsedError;
  dynamic get UnitID => throw _privateConstructorUsedError;
  dynamic get SceneID => throw _privateConstructorUsedError;
  dynamic get DayList => throw _privateConstructorUsedError;
  dynamic get Time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScheduleCopyWith<Schedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleCopyWith<$Res> {
  factory $ScheduleCopyWith(Schedule value, $Res Function(Schedule) then) =
      _$ScheduleCopyWithImpl<$Res>;
  $Res call(
      {dynamic ScheduleID,
      dynamic UnitID,
      dynamic SceneID,
      dynamic DayList,
      dynamic Time});
}

/// @nodoc
class _$ScheduleCopyWithImpl<$Res> implements $ScheduleCopyWith<$Res> {
  _$ScheduleCopyWithImpl(this._value, this._then);

  final Schedule _value;
  // ignore: unused_field
  final $Res Function(Schedule) _then;

  @override
  $Res call({
    Object? ScheduleID = freezed,
    Object? UnitID = freezed,
    Object? SceneID = freezed,
    Object? DayList = freezed,
    Object? Time = freezed,
  }) {
    return _then(_value.copyWith(
      ScheduleID: ScheduleID == freezed
          ? _value.ScheduleID
          : ScheduleID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      UnitID: UnitID == freezed
          ? _value.UnitID
          : UnitID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      SceneID: SceneID == freezed
          ? _value.SceneID
          : SceneID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      DayList: DayList == freezed
          ? _value.DayList
          : DayList // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Time: Time == freezed
          ? _value.Time
          : Time // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_ScheduleCopyWith<$Res> implements $ScheduleCopyWith<$Res> {
  factory _$$_ScheduleCopyWith(
          _$_Schedule value, $Res Function(_$_Schedule) then) =
      __$$_ScheduleCopyWithImpl<$Res>;
  @override
  $Res call(
      {dynamic ScheduleID,
      dynamic UnitID,
      dynamic SceneID,
      dynamic DayList,
      dynamic Time});
}

/// @nodoc
class __$$_ScheduleCopyWithImpl<$Res> extends _$ScheduleCopyWithImpl<$Res>
    implements _$$_ScheduleCopyWith<$Res> {
  __$$_ScheduleCopyWithImpl(
      _$_Schedule _value, $Res Function(_$_Schedule) _then)
      : super(_value, (v) => _then(v as _$_Schedule));

  @override
  _$_Schedule get _value => super._value as _$_Schedule;

  @override
  $Res call({
    Object? ScheduleID = freezed,
    Object? UnitID = freezed,
    Object? SceneID = freezed,
    Object? DayList = freezed,
    Object? Time = freezed,
  }) {
    return _then(_$_Schedule(
      ScheduleID: ScheduleID == freezed
          ? _value.ScheduleID
          : ScheduleID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      UnitID: UnitID == freezed
          ? _value.UnitID
          : UnitID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      SceneID: SceneID == freezed
          ? _value.SceneID
          : SceneID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      DayList: DayList == freezed
          ? _value.DayList
          : DayList // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Time: Time == freezed
          ? _value.Time
          : Time // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Schedule implements _Schedule {
  _$_Schedule(
      {this.ScheduleID = '',
      this.UnitID = '',
      this.SceneID = '',
      this.DayList = '',
      this.Time = ''});

  factory _$_Schedule.fromJson(Map<String, dynamic> json) =>
      _$$_ScheduleFromJson(json);

  @override
  @JsonKey()
  final dynamic ScheduleID;
  @override
  @JsonKey()
  final dynamic UnitID;
  @override
  @JsonKey()
  final dynamic SceneID;
  @override
  @JsonKey()
  final dynamic DayList;
  @override
  @JsonKey()
  final dynamic Time;

  @override
  String toString() {
    return 'Schedule(ScheduleID: $ScheduleID, UnitID: $UnitID, SceneID: $SceneID, DayList: $DayList, Time: $Time)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Schedule &&
            const DeepCollectionEquality()
                .equals(other.ScheduleID, ScheduleID) &&
            const DeepCollectionEquality().equals(other.UnitID, UnitID) &&
            const DeepCollectionEquality().equals(other.SceneID, SceneID) &&
            const DeepCollectionEquality().equals(other.DayList, DayList) &&
            const DeepCollectionEquality().equals(other.Time, Time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(ScheduleID),
      const DeepCollectionEquality().hash(UnitID),
      const DeepCollectionEquality().hash(SceneID),
      const DeepCollectionEquality().hash(DayList),
      const DeepCollectionEquality().hash(Time));

  @JsonKey(ignore: true)
  @override
  _$$_ScheduleCopyWith<_$_Schedule> get copyWith =>
      __$$_ScheduleCopyWithImpl<_$_Schedule>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScheduleToJson(
      this,
    );
  }
}

abstract class _Schedule implements Schedule {
  factory _Schedule(
      {final dynamic ScheduleID,
      final dynamic UnitID,
      final dynamic SceneID,
      final dynamic DayList,
      final dynamic Time}) = _$_Schedule;

  factory _Schedule.fromJson(Map<String, dynamic> json) = _$_Schedule.fromJson;

  @override
  dynamic get ScheduleID;
  @override
  dynamic get UnitID;
  @override
  dynamic get SceneID;
  @override
  dynamic get DayList;
  @override
  dynamic get Time;
  @override
  @JsonKey(ignore: true)
  _$$_ScheduleCopyWith<_$_Schedule> get copyWith =>
      throw _privateConstructorUsedError;
}
