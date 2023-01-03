// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sent_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SentMessageModel _$SentMessageModelFromJson(Map<String, dynamic> json) {
  return _SentMessageModel.fromJson(json);
}

/// @nodoc
mixin _$SentMessageModel {
  dynamic get MessageID => throw _privateConstructorUsedError;
  dynamic get MessageDate => throw _privateConstructorUsedError;
  dynamic get CreatorID => throw _privateConstructorUsedError;
  dynamic get CreatorName => throw _privateConstructorUsedError;
  dynamic get Subject => throw _privateConstructorUsedError;
  dynamic get Message => throw _privateConstructorUsedError;
  dynamic get Ack => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SentMessageModelCopyWith<SentMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SentMessageModelCopyWith<$Res> {
  factory $SentMessageModelCopyWith(
          SentMessageModel value, $Res Function(SentMessageModel) then) =
      _$SentMessageModelCopyWithImpl<$Res, SentMessageModel>;
  @useResult
  $Res call(
      {dynamic MessageID,
      dynamic MessageDate,
      dynamic CreatorID,
      dynamic CreatorName,
      dynamic Subject,
      dynamic Message,
      dynamic Ack});
}

/// @nodoc
class _$SentMessageModelCopyWithImpl<$Res, $Val extends SentMessageModel>
    implements $SentMessageModelCopyWith<$Res> {
  _$SentMessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? MessageID = freezed,
    Object? MessageDate = freezed,
    Object? CreatorID = freezed,
    Object? CreatorName = freezed,
    Object? Subject = freezed,
    Object? Message = freezed,
    Object? Ack = freezed,
  }) {
    return _then(_value.copyWith(
      MessageID: freezed == MessageID
          ? _value.MessageID
          : MessageID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      MessageDate: freezed == MessageDate
          ? _value.MessageDate
          : MessageDate // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CreatorID: freezed == CreatorID
          ? _value.CreatorID
          : CreatorID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CreatorName: freezed == CreatorName
          ? _value.CreatorName
          : CreatorName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Subject: freezed == Subject
          ? _value.Subject
          : Subject // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Message: freezed == Message
          ? _value.Message
          : Message // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Ack: freezed == Ack
          ? _value.Ack
          : Ack // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SentMessageModelCopyWith<$Res>
    implements $SentMessageModelCopyWith<$Res> {
  factory _$$_SentMessageModelCopyWith(
          _$_SentMessageModel value, $Res Function(_$_SentMessageModel) then) =
      __$$_SentMessageModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic MessageID,
      dynamic MessageDate,
      dynamic CreatorID,
      dynamic CreatorName,
      dynamic Subject,
      dynamic Message,
      dynamic Ack});
}

/// @nodoc
class __$$_SentMessageModelCopyWithImpl<$Res>
    extends _$SentMessageModelCopyWithImpl<$Res, _$_SentMessageModel>
    implements _$$_SentMessageModelCopyWith<$Res> {
  __$$_SentMessageModelCopyWithImpl(
      _$_SentMessageModel _value, $Res Function(_$_SentMessageModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? MessageID = freezed,
    Object? MessageDate = freezed,
    Object? CreatorID = freezed,
    Object? CreatorName = freezed,
    Object? Subject = freezed,
    Object? Message = freezed,
    Object? Ack = freezed,
  }) {
    return _then(_$_SentMessageModel(
      MessageID: freezed == MessageID
          ? _value.MessageID
          : MessageID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      MessageDate: freezed == MessageDate
          ? _value.MessageDate
          : MessageDate // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CreatorID: freezed == CreatorID
          ? _value.CreatorID
          : CreatorID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CreatorName: freezed == CreatorName
          ? _value.CreatorName
          : CreatorName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Subject: freezed == Subject
          ? _value.Subject
          : Subject // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Message: freezed == Message
          ? _value.Message
          : Message // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Ack: freezed == Ack
          ? _value.Ack
          : Ack // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SentMessageModel implements _SentMessageModel {
  _$_SentMessageModel(
      {this.MessageID = '',
      this.MessageDate = '',
      this.CreatorID = '',
      this.CreatorName = '',
      this.Subject = '',
      this.Message = '',
      this.Ack = ''});

  factory _$_SentMessageModel.fromJson(Map<String, dynamic> json) =>
      _$$_SentMessageModelFromJson(json);

  @override
  @JsonKey()
  final dynamic MessageID;
  @override
  @JsonKey()
  final dynamic MessageDate;
  @override
  @JsonKey()
  final dynamic CreatorID;
  @override
  @JsonKey()
  final dynamic CreatorName;
  @override
  @JsonKey()
  final dynamic Subject;
  @override
  @JsonKey()
  final dynamic Message;
  @override
  @JsonKey()
  final dynamic Ack;

  @override
  String toString() {
    return 'SentMessageModel(MessageID: $MessageID, MessageDate: $MessageDate, CreatorID: $CreatorID, CreatorName: $CreatorName, Subject: $Subject, Message: $Message, Ack: $Ack)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SentMessageModel &&
            const DeepCollectionEquality().equals(other.MessageID, MessageID) &&
            const DeepCollectionEquality()
                .equals(other.MessageDate, MessageDate) &&
            const DeepCollectionEquality().equals(other.CreatorID, CreatorID) &&
            const DeepCollectionEquality()
                .equals(other.CreatorName, CreatorName) &&
            const DeepCollectionEquality().equals(other.Subject, Subject) &&
            const DeepCollectionEquality().equals(other.Message, Message) &&
            const DeepCollectionEquality().equals(other.Ack, Ack));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(MessageID),
      const DeepCollectionEquality().hash(MessageDate),
      const DeepCollectionEquality().hash(CreatorID),
      const DeepCollectionEquality().hash(CreatorName),
      const DeepCollectionEquality().hash(Subject),
      const DeepCollectionEquality().hash(Message),
      const DeepCollectionEquality().hash(Ack));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SentMessageModelCopyWith<_$_SentMessageModel> get copyWith =>
      __$$_SentMessageModelCopyWithImpl<_$_SentMessageModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SentMessageModelToJson(
      this,
    );
  }
}

abstract class _SentMessageModel implements SentMessageModel {
  factory _SentMessageModel(
      {final dynamic MessageID,
      final dynamic MessageDate,
      final dynamic CreatorID,
      final dynamic CreatorName,
      final dynamic Subject,
      final dynamic Message,
      final dynamic Ack}) = _$_SentMessageModel;

  factory _SentMessageModel.fromJson(Map<String, dynamic> json) =
      _$_SentMessageModel.fromJson;

  @override
  dynamic get MessageID;
  @override
  dynamic get MessageDate;
  @override
  dynamic get CreatorID;
  @override
  dynamic get CreatorName;
  @override
  dynamic get Subject;
  @override
  dynamic get Message;
  @override
  dynamic get Ack;
  @override
  @JsonKey(ignore: true)
  _$$_SentMessageModelCopyWith<_$_SentMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
