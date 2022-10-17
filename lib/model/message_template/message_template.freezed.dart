// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageTemplate _$MessageTemplateFromJson(Map<String, dynamic> json) {
  return _MessageTemplate.fromJson(json);
}

/// @nodoc
mixin _$MessageTemplate {
  dynamic get TemplateID => throw _privateConstructorUsedError;
  dynamic get TemplateName => throw _privateConstructorUsedError;
  dynamic get TemplateText => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageTemplateCopyWith<MessageTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageTemplateCopyWith<$Res> {
  factory $MessageTemplateCopyWith(
          MessageTemplate value, $Res Function(MessageTemplate) then) =
      _$MessageTemplateCopyWithImpl<$Res>;
  $Res call({dynamic TemplateID, dynamic TemplateName, dynamic TemplateText});
}

/// @nodoc
class _$MessageTemplateCopyWithImpl<$Res>
    implements $MessageTemplateCopyWith<$Res> {
  _$MessageTemplateCopyWithImpl(this._value, this._then);

  final MessageTemplate _value;
  // ignore: unused_field
  final $Res Function(MessageTemplate) _then;

  @override
  $Res call({
    Object? TemplateID = freezed,
    Object? TemplateName = freezed,
    Object? TemplateText = freezed,
  }) {
    return _then(_value.copyWith(
      TemplateID: TemplateID == freezed
          ? _value.TemplateID
          : TemplateID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      TemplateName: TemplateName == freezed
          ? _value.TemplateName
          : TemplateName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      TemplateText: TemplateText == freezed
          ? _value.TemplateText
          : TemplateText // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_MessageTemplateCopyWith<$Res>
    implements $MessageTemplateCopyWith<$Res> {
  factory _$$_MessageTemplateCopyWith(
          _$_MessageTemplate value, $Res Function(_$_MessageTemplate) then) =
      __$$_MessageTemplateCopyWithImpl<$Res>;
  @override
  $Res call({dynamic TemplateID, dynamic TemplateName, dynamic TemplateText});
}

/// @nodoc
class __$$_MessageTemplateCopyWithImpl<$Res>
    extends _$MessageTemplateCopyWithImpl<$Res>
    implements _$$_MessageTemplateCopyWith<$Res> {
  __$$_MessageTemplateCopyWithImpl(
      _$_MessageTemplate _value, $Res Function(_$_MessageTemplate) _then)
      : super(_value, (v) => _then(v as _$_MessageTemplate));

  @override
  _$_MessageTemplate get _value => super._value as _$_MessageTemplate;

  @override
  $Res call({
    Object? TemplateID = freezed,
    Object? TemplateName = freezed,
    Object? TemplateText = freezed,
  }) {
    return _then(_$_MessageTemplate(
      TemplateID: TemplateID == freezed
          ? _value.TemplateID
          : TemplateID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      TemplateName: TemplateName == freezed
          ? _value.TemplateName
          : TemplateName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      TemplateText: TemplateText == freezed
          ? _value.TemplateText
          : TemplateText // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MessageTemplate implements _MessageTemplate {
  _$_MessageTemplate(
      {this.TemplateID = '', this.TemplateName = '', this.TemplateText = ''});

  factory _$_MessageTemplate.fromJson(Map<String, dynamic> json) =>
      _$$_MessageTemplateFromJson(json);

  @override
  @JsonKey()
  final dynamic TemplateID;
  @override
  @JsonKey()
  final dynamic TemplateName;
  @override
  @JsonKey()
  final dynamic TemplateText;

  @override
  String toString() {
    return 'MessageTemplate(TemplateID: $TemplateID, TemplateName: $TemplateName, TemplateText: $TemplateText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageTemplate &&
            const DeepCollectionEquality()
                .equals(other.TemplateID, TemplateID) &&
            const DeepCollectionEquality()
                .equals(other.TemplateName, TemplateName) &&
            const DeepCollectionEquality()
                .equals(other.TemplateText, TemplateText));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(TemplateID),
      const DeepCollectionEquality().hash(TemplateName),
      const DeepCollectionEquality().hash(TemplateText));

  @JsonKey(ignore: true)
  @override
  _$$_MessageTemplateCopyWith<_$_MessageTemplate> get copyWith =>
      __$$_MessageTemplateCopyWithImpl<_$_MessageTemplate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageTemplateToJson(
      this,
    );
  }
}

abstract class _MessageTemplate implements MessageTemplate {
  factory _MessageTemplate(
      {final dynamic TemplateID,
      final dynamic TemplateName,
      final dynamic TemplateText}) = _$_MessageTemplate;

  factory _MessageTemplate.fromJson(Map<String, dynamic> json) =
      _$_MessageTemplate.fromJson;

  @override
  dynamic get TemplateID;
  @override
  dynamic get TemplateName;
  @override
  dynamic get TemplateText;
  @override
  @JsonKey(ignore: true)
  _$$_MessageTemplateCopyWith<_$_MessageTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}
