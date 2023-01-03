// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'moderator_message_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ModeratorMessageGroup _$ModeratorMessageGroupFromJson(
    Map<String, dynamic> json) {
  return _ModeratorMessageGroup.fromJson(json);
}

/// @nodoc
mixin _$ModeratorMessageGroup {
  dynamic get UserID => throw _privateConstructorUsedError;
  dynamic get CustomerID => throw _privateConstructorUsedError;
  dynamic get UserName => throw _privateConstructorUsedError;
  dynamic get UserEmail => throw _privateConstructorUsedError;
  dynamic get Status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ModeratorMessageGroupCopyWith<ModeratorMessageGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModeratorMessageGroupCopyWith<$Res> {
  factory $ModeratorMessageGroupCopyWith(ModeratorMessageGroup value,
          $Res Function(ModeratorMessageGroup) then) =
      _$ModeratorMessageGroupCopyWithImpl<$Res, ModeratorMessageGroup>;
  @useResult
  $Res call(
      {dynamic UserID,
      dynamic CustomerID,
      dynamic UserName,
      dynamic UserEmail,
      dynamic Status});
}

/// @nodoc
class _$ModeratorMessageGroupCopyWithImpl<$Res,
        $Val extends ModeratorMessageGroup>
    implements $ModeratorMessageGroupCopyWith<$Res> {
  _$ModeratorMessageGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? UserID = freezed,
    Object? CustomerID = freezed,
    Object? UserName = freezed,
    Object? UserEmail = freezed,
    Object? Status = freezed,
  }) {
    return _then(_value.copyWith(
      UserID: freezed == UserID
          ? _value.UserID
          : UserID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CustomerID: freezed == CustomerID
          ? _value.CustomerID
          : CustomerID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      UserName: freezed == UserName
          ? _value.UserName
          : UserName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      UserEmail: freezed == UserEmail
          ? _value.UserEmail
          : UserEmail // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Status: freezed == Status
          ? _value.Status
          : Status // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ModeratorMessageGroupCopyWith<$Res>
    implements $ModeratorMessageGroupCopyWith<$Res> {
  factory _$$_ModeratorMessageGroupCopyWith(_$_ModeratorMessageGroup value,
          $Res Function(_$_ModeratorMessageGroup) then) =
      __$$_ModeratorMessageGroupCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic UserID,
      dynamic CustomerID,
      dynamic UserName,
      dynamic UserEmail,
      dynamic Status});
}

/// @nodoc
class __$$_ModeratorMessageGroupCopyWithImpl<$Res>
    extends _$ModeratorMessageGroupCopyWithImpl<$Res, _$_ModeratorMessageGroup>
    implements _$$_ModeratorMessageGroupCopyWith<$Res> {
  __$$_ModeratorMessageGroupCopyWithImpl(_$_ModeratorMessageGroup _value,
      $Res Function(_$_ModeratorMessageGroup) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? UserID = freezed,
    Object? CustomerID = freezed,
    Object? UserName = freezed,
    Object? UserEmail = freezed,
    Object? Status = freezed,
  }) {
    return _then(_$_ModeratorMessageGroup(
      UserID: freezed == UserID
          ? _value.UserID
          : UserID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CustomerID: freezed == CustomerID
          ? _value.CustomerID
          : CustomerID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      UserName: freezed == UserName
          ? _value.UserName
          : UserName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      UserEmail: freezed == UserEmail
          ? _value.UserEmail
          : UserEmail // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Status: freezed == Status
          ? _value.Status
          : Status // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ModeratorMessageGroup implements _ModeratorMessageGroup {
  _$_ModeratorMessageGroup(
      {this.UserID = '',
      this.CustomerID = '',
      this.UserName = '',
      this.UserEmail = '',
      this.Status = ''});

  factory _$_ModeratorMessageGroup.fromJson(Map<String, dynamic> json) =>
      _$$_ModeratorMessageGroupFromJson(json);

  @override
  @JsonKey()
  final dynamic UserID;
  @override
  @JsonKey()
  final dynamic CustomerID;
  @override
  @JsonKey()
  final dynamic UserName;
  @override
  @JsonKey()
  final dynamic UserEmail;
  @override
  @JsonKey()
  final dynamic Status;

  @override
  String toString() {
    return 'ModeratorMessageGroup(UserID: $UserID, CustomerID: $CustomerID, UserName: $UserName, UserEmail: $UserEmail, Status: $Status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ModeratorMessageGroup &&
            const DeepCollectionEquality().equals(other.UserID, UserID) &&
            const DeepCollectionEquality()
                .equals(other.CustomerID, CustomerID) &&
            const DeepCollectionEquality().equals(other.UserName, UserName) &&
            const DeepCollectionEquality().equals(other.UserEmail, UserEmail) &&
            const DeepCollectionEquality().equals(other.Status, Status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(UserID),
      const DeepCollectionEquality().hash(CustomerID),
      const DeepCollectionEquality().hash(UserName),
      const DeepCollectionEquality().hash(UserEmail),
      const DeepCollectionEquality().hash(Status));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ModeratorMessageGroupCopyWith<_$_ModeratorMessageGroup> get copyWith =>
      __$$_ModeratorMessageGroupCopyWithImpl<_$_ModeratorMessageGroup>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ModeratorMessageGroupToJson(
      this,
    );
  }
}

abstract class _ModeratorMessageGroup implements ModeratorMessageGroup {
  factory _ModeratorMessageGroup(
      {final dynamic UserID,
      final dynamic CustomerID,
      final dynamic UserName,
      final dynamic UserEmail,
      final dynamic Status}) = _$_ModeratorMessageGroup;

  factory _ModeratorMessageGroup.fromJson(Map<String, dynamic> json) =
      _$_ModeratorMessageGroup.fromJson;

  @override
  dynamic get UserID;
  @override
  dynamic get CustomerID;
  @override
  dynamic get UserName;
  @override
  dynamic get UserEmail;
  @override
  dynamic get Status;
  @override
  @JsonKey(ignore: true)
  _$$_ModeratorMessageGroupCopyWith<_$_ModeratorMessageGroup> get copyWith =>
      throw _privateConstructorUsedError;
}
