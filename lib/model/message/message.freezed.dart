// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return _MessageModel.fromJson(json);
}

/// @nodoc
mixin _$MessageModel {
  dynamic get MessageID => throw _privateConstructorUsedError;
  dynamic get MessageDate => throw _privateConstructorUsedError;
  dynamic get CreatorID => throw _privateConstructorUsedError;
  dynamic get Subject => throw _privateConstructorUsedError;
  dynamic get Message => throw _privateConstructorUsedError;
  dynamic get Ack => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageModelCopyWith<MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageModelCopyWith<$Res> {
  factory $MessageModelCopyWith(
          MessageModel value, $Res Function(MessageModel) then) =
      _$MessageModelCopyWithImpl<$Res>;
  $Res call(
      {dynamic MessageID,
      dynamic MessageDate,
      dynamic CreatorID,
      dynamic Subject,
      dynamic Message,
      dynamic Ack});
}

/// @nodoc
class _$MessageModelCopyWithImpl<$Res> implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._value, this._then);

  final MessageModel _value;
  // ignore: unused_field
  final $Res Function(MessageModel) _then;

  @override
  $Res call({
    Object? MessageID = freezed,
    Object? MessageDate = freezed,
    Object? CreatorID = freezed,
    Object? Subject = freezed,
    Object? Message = freezed,
    Object? Ack = freezed,
  }) {
    return _then(_value.copyWith(
      MessageID: MessageID == freezed
          ? _value.MessageID
          : MessageID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      MessageDate: MessageDate == freezed
          ? _value.MessageDate
          : MessageDate // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CreatorID: CreatorID == freezed
          ? _value.CreatorID
          : CreatorID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Subject: Subject == freezed
          ? _value.Subject
          : Subject // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Message: Message == freezed
          ? _value.Message
          : Message // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Ack: Ack == freezed
          ? _value.Ack
          : Ack // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_MessageModelCopyWith<$Res>
    implements $MessageModelCopyWith<$Res> {
  factory _$$_MessageModelCopyWith(
          _$_MessageModel value, $Res Function(_$_MessageModel) then) =
      __$$_MessageModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {dynamic MessageID,
      dynamic MessageDate,
      dynamic CreatorID,
      dynamic Subject,
      dynamic Message,
      dynamic Ack});
}

/// @nodoc
class __$$_MessageModelCopyWithImpl<$Res>
    extends _$MessageModelCopyWithImpl<$Res>
    implements _$$_MessageModelCopyWith<$Res> {
  __$$_MessageModelCopyWithImpl(
      _$_MessageModel _value, $Res Function(_$_MessageModel) _then)
      : super(_value, (v) => _then(v as _$_MessageModel));

  @override
  _$_MessageModel get _value => super._value as _$_MessageModel;

  @override
  $Res call({
    Object? MessageID = freezed,
    Object? MessageDate = freezed,
    Object? CreatorID = freezed,
    Object? Subject = freezed,
    Object? Message = freezed,
    Object? Ack = freezed,
  }) {
    return _then(_$_MessageModel(
      MessageID: MessageID == freezed
          ? _value.MessageID
          : MessageID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      MessageDate: MessageDate == freezed
          ? _value.MessageDate
          : MessageDate // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CreatorID: CreatorID == freezed
          ? _value.CreatorID
          : CreatorID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Subject: Subject == freezed
          ? _value.Subject
          : Subject // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Message: Message == freezed
          ? _value.Message
          : Message // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Ack: Ack == freezed
          ? _value.Ack
          : Ack // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MessageModel implements _MessageModel {
  _$_MessageModel(
      {this.MessageID = '',
      this.MessageDate = '',
      this.CreatorID = '',
      this.Subject = '',
      this.Message = '',
      this.Ack = ''});

  factory _$_MessageModel.fromJson(Map<String, dynamic> json) =>
      _$$_MessageModelFromJson(json);

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
  final dynamic Subject;
  @override
  @JsonKey()
  final dynamic Message;
  @override
  @JsonKey()
  final dynamic Ack;

  @override
  String toString() {
    return 'MessageModel(MessageID: $MessageID, MessageDate: $MessageDate, CreatorID: $CreatorID, Subject: $Subject, Message: $Message, Ack: $Ack)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageModel &&
            const DeepCollectionEquality().equals(other.MessageID, MessageID) &&
            const DeepCollectionEquality()
                .equals(other.MessageDate, MessageDate) &&
            const DeepCollectionEquality().equals(other.CreatorID, CreatorID) &&
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
      const DeepCollectionEquality().hash(Subject),
      const DeepCollectionEquality().hash(Message),
      const DeepCollectionEquality().hash(Ack));

  @JsonKey(ignore: true)
  @override
  _$$_MessageModelCopyWith<_$_MessageModel> get copyWith =>
      __$$_MessageModelCopyWithImpl<_$_MessageModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageModelToJson(
      this,
    );
  }
}

abstract class _MessageModel implements MessageModel {
  factory _MessageModel(
      {final dynamic MessageID,
      final dynamic MessageDate,
      final dynamic CreatorID,
      final dynamic Subject,
      final dynamic Message,
      final dynamic Ack}) = _$_MessageModel;

  factory _MessageModel.fromJson(Map<String, dynamic> json) =
      _$_MessageModel.fromJson;

  @override
  dynamic get MessageID;
  @override
  dynamic get MessageDate;
  @override
  dynamic get CreatorID;
  @override
  dynamic get Subject;
  @override
  dynamic get Message;
  @override
  dynamic get Ack;
  @override
  @JsonKey(ignore: true)
  _$$_MessageModelCopyWith<_$_MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
