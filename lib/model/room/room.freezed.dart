// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Room _$RoomFromJson(Map<String, dynamic> json) {
  return _Room.fromJson(json);
}

/// @nodoc
mixin _$Room {
  dynamic get RoomID => throw _privateConstructorUsedError;
  dynamic get CustomerId => throw _privateConstructorUsedError;
  dynamic get UnitId => throw _privateConstructorUsedError;
  dynamic get RoomName => throw _privateConstructorUsedError;
  List<Thing> get Items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomCopyWith<Room> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomCopyWith<$Res> {
  factory $RoomCopyWith(Room value, $Res Function(Room) then) =
      _$RoomCopyWithImpl<$Res, Room>;
  @useResult
  $Res call(
      {dynamic RoomID,
      dynamic CustomerId,
      dynamic UnitId,
      dynamic RoomName,
      List<Thing> Items});
}

/// @nodoc
class _$RoomCopyWithImpl<$Res, $Val extends Room>
    implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? RoomID = freezed,
    Object? CustomerId = freezed,
    Object? UnitId = freezed,
    Object? RoomName = freezed,
    Object? Items = null,
  }) {
    return _then(_value.copyWith(
      RoomID: freezed == RoomID
          ? _value.RoomID
          : RoomID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CustomerId: freezed == CustomerId
          ? _value.CustomerId
          : CustomerId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      UnitId: freezed == UnitId
          ? _value.UnitId
          : UnitId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      RoomName: freezed == RoomName
          ? _value.RoomName
          : RoomName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Items: null == Items
          ? _value.Items
          : Items // ignore: cast_nullable_to_non_nullable
              as List<Thing>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RoomCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$$_RoomCopyWith(_$_Room value, $Res Function(_$_Room) then) =
      __$$_RoomCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic RoomID,
      dynamic CustomerId,
      dynamic UnitId,
      dynamic RoomName,
      List<Thing> Items});
}

/// @nodoc
class __$$_RoomCopyWithImpl<$Res> extends _$RoomCopyWithImpl<$Res, _$_Room>
    implements _$$_RoomCopyWith<$Res> {
  __$$_RoomCopyWithImpl(_$_Room _value, $Res Function(_$_Room) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? RoomID = freezed,
    Object? CustomerId = freezed,
    Object? UnitId = freezed,
    Object? RoomName = freezed,
    Object? Items = null,
  }) {
    return _then(_$_Room(
      RoomID: freezed == RoomID
          ? _value.RoomID
          : RoomID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CustomerId: freezed == CustomerId
          ? _value.CustomerId
          : CustomerId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      UnitId: freezed == UnitId
          ? _value.UnitId
          : UnitId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      RoomName: freezed == RoomName
          ? _value.RoomName
          : RoomName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Items: null == Items
          ? _value._Items
          : Items // ignore: cast_nullable_to_non_nullable
              as List<Thing>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Room with DiagnosticableTreeMixin implements _Room {
  _$_Room(
      {this.RoomID = '',
      this.CustomerId = '',
      this.UnitId = '',
      this.RoomName = '',
      final List<Thing> Items = const []})
      : _Items = Items;

  factory _$_Room.fromJson(Map<String, dynamic> json) => _$$_RoomFromJson(json);

  @override
  @JsonKey()
  final dynamic RoomID;
  @override
  @JsonKey()
  final dynamic CustomerId;
  @override
  @JsonKey()
  final dynamic UnitId;
  @override
  @JsonKey()
  final dynamic RoomName;
  final List<Thing> _Items;
  @override
  @JsonKey()
  List<Thing> get Items {
    if (_Items is EqualUnmodifiableListView) return _Items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_Items);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Room(RoomID: $RoomID, CustomerId: $CustomerId, UnitId: $UnitId, RoomName: $RoomName, Items: $Items)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Room'))
      ..add(DiagnosticsProperty('RoomID', RoomID))
      ..add(DiagnosticsProperty('CustomerId', CustomerId))
      ..add(DiagnosticsProperty('UnitId', UnitId))
      ..add(DiagnosticsProperty('RoomName', RoomName))
      ..add(DiagnosticsProperty('Items', Items));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Room &&
            const DeepCollectionEquality().equals(other.RoomID, RoomID) &&
            const DeepCollectionEquality()
                .equals(other.CustomerId, CustomerId) &&
            const DeepCollectionEquality().equals(other.UnitId, UnitId) &&
            const DeepCollectionEquality().equals(other.RoomName, RoomName) &&
            const DeepCollectionEquality().equals(other._Items, _Items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(RoomID),
      const DeepCollectionEquality().hash(CustomerId),
      const DeepCollectionEquality().hash(UnitId),
      const DeepCollectionEquality().hash(RoomName),
      const DeepCollectionEquality().hash(_Items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoomCopyWith<_$_Room> get copyWith =>
      __$$_RoomCopyWithImpl<_$_Room>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RoomToJson(
      this,
    );
  }
}

abstract class _Room implements Room {
  factory _Room(
      {final dynamic RoomID,
      final dynamic CustomerId,
      final dynamic UnitId,
      final dynamic RoomName,
      final List<Thing> Items}) = _$_Room;

  factory _Room.fromJson(Map<String, dynamic> json) = _$_Room.fromJson;

  @override
  dynamic get RoomID;
  @override
  dynamic get CustomerId;
  @override
  dynamic get UnitId;
  @override
  dynamic get RoomName;
  @override
  List<Thing> get Items;
  @override
  @JsonKey(ignore: true)
  _$$_RoomCopyWith<_$_Room> get copyWith => throw _privateConstructorUsedError;
}
