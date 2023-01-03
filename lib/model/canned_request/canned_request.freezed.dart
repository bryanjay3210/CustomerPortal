// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'canned_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CannedRequest _$CannedRequestFromJson(Map<String, dynamic> json) {
  return _CannedRequest.fromJson(json);
}

/// @nodoc
mixin _$CannedRequest {
  dynamic get RequestID => throw _privateConstructorUsedError;
  dynamic get BuildingID => throw _privateConstructorUsedError;
  dynamic get RequestTitle => throw _privateConstructorUsedError;
  dynamic get RequestTarget => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CannedRequestCopyWith<CannedRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CannedRequestCopyWith<$Res> {
  factory $CannedRequestCopyWith(
          CannedRequest value, $Res Function(CannedRequest) then) =
      _$CannedRequestCopyWithImpl<$Res, CannedRequest>;
  @useResult
  $Res call(
      {dynamic RequestID,
      dynamic BuildingID,
      dynamic RequestTitle,
      dynamic RequestTarget});
}

/// @nodoc
class _$CannedRequestCopyWithImpl<$Res, $Val extends CannedRequest>
    implements $CannedRequestCopyWith<$Res> {
  _$CannedRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? RequestID = freezed,
    Object? BuildingID = freezed,
    Object? RequestTitle = freezed,
    Object? RequestTarget = freezed,
  }) {
    return _then(_value.copyWith(
      RequestID: freezed == RequestID
          ? _value.RequestID
          : RequestID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      BuildingID: freezed == BuildingID
          ? _value.BuildingID
          : BuildingID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      RequestTitle: freezed == RequestTitle
          ? _value.RequestTitle
          : RequestTitle // ignore: cast_nullable_to_non_nullable
              as dynamic,
      RequestTarget: freezed == RequestTarget
          ? _value.RequestTarget
          : RequestTarget // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CannedRequestCopyWith<$Res>
    implements $CannedRequestCopyWith<$Res> {
  factory _$$_CannedRequestCopyWith(
          _$_CannedRequest value, $Res Function(_$_CannedRequest) then) =
      __$$_CannedRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic RequestID,
      dynamic BuildingID,
      dynamic RequestTitle,
      dynamic RequestTarget});
}

/// @nodoc
class __$$_CannedRequestCopyWithImpl<$Res>
    extends _$CannedRequestCopyWithImpl<$Res, _$_CannedRequest>
    implements _$$_CannedRequestCopyWith<$Res> {
  __$$_CannedRequestCopyWithImpl(
      _$_CannedRequest _value, $Res Function(_$_CannedRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? RequestID = freezed,
    Object? BuildingID = freezed,
    Object? RequestTitle = freezed,
    Object? RequestTarget = freezed,
  }) {
    return _then(_$_CannedRequest(
      RequestID: freezed == RequestID
          ? _value.RequestID
          : RequestID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      BuildingID: freezed == BuildingID
          ? _value.BuildingID
          : BuildingID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      RequestTitle: freezed == RequestTitle
          ? _value.RequestTitle
          : RequestTitle // ignore: cast_nullable_to_non_nullable
              as dynamic,
      RequestTarget: freezed == RequestTarget
          ? _value.RequestTarget
          : RequestTarget // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CannedRequest implements _CannedRequest {
  _$_CannedRequest(
      {this.RequestID = '',
      this.BuildingID = '',
      this.RequestTitle = '',
      this.RequestTarget = ''});

  factory _$_CannedRequest.fromJson(Map<String, dynamic> json) =>
      _$$_CannedRequestFromJson(json);

  @override
  @JsonKey()
  final dynamic RequestID;
  @override
  @JsonKey()
  final dynamic BuildingID;
  @override
  @JsonKey()
  final dynamic RequestTitle;
  @override
  @JsonKey()
  final dynamic RequestTarget;

  @override
  String toString() {
    return 'CannedRequest(RequestID: $RequestID, BuildingID: $BuildingID, RequestTitle: $RequestTitle, RequestTarget: $RequestTarget)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CannedRequest &&
            const DeepCollectionEquality().equals(other.RequestID, RequestID) &&
            const DeepCollectionEquality()
                .equals(other.BuildingID, BuildingID) &&
            const DeepCollectionEquality()
                .equals(other.RequestTitle, RequestTitle) &&
            const DeepCollectionEquality()
                .equals(other.RequestTarget, RequestTarget));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(RequestID),
      const DeepCollectionEquality().hash(BuildingID),
      const DeepCollectionEquality().hash(RequestTitle),
      const DeepCollectionEquality().hash(RequestTarget));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CannedRequestCopyWith<_$_CannedRequest> get copyWith =>
      __$$_CannedRequestCopyWithImpl<_$_CannedRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CannedRequestToJson(
      this,
    );
  }
}

abstract class _CannedRequest implements CannedRequest {
  factory _CannedRequest(
      {final dynamic RequestID,
      final dynamic BuildingID,
      final dynamic RequestTitle,
      final dynamic RequestTarget}) = _$_CannedRequest;

  factory _CannedRequest.fromJson(Map<String, dynamic> json) =
      _$_CannedRequest.fromJson;

  @override
  dynamic get RequestID;
  @override
  dynamic get BuildingID;
  @override
  dynamic get RequestTitle;
  @override
  dynamic get RequestTarget;
  @override
  @JsonKey(ignore: true)
  _$$_CannedRequestCopyWith<_$_CannedRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
