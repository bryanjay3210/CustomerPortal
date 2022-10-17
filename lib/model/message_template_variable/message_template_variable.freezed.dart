// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message_template_variable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageTemplateVariable _$MessageTemplateVariableFromJson(
    Map<String, dynamic> json) {
  return _MessageTemplateVariable.fromJson(json);
}

/// @nodoc
mixin _$MessageTemplateVariable {
  dynamic get VariableName => throw _privateConstructorUsedError;
  dynamic get VariableSub => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageTemplateVariableCopyWith<MessageTemplateVariable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageTemplateVariableCopyWith<$Res> {
  factory $MessageTemplateVariableCopyWith(MessageTemplateVariable value,
          $Res Function(MessageTemplateVariable) then) =
      _$MessageTemplateVariableCopyWithImpl<$Res>;
  $Res call({dynamic VariableName, dynamic VariableSub});
}

/// @nodoc
class _$MessageTemplateVariableCopyWithImpl<$Res>
    implements $MessageTemplateVariableCopyWith<$Res> {
  _$MessageTemplateVariableCopyWithImpl(this._value, this._then);

  final MessageTemplateVariable _value;
  // ignore: unused_field
  final $Res Function(MessageTemplateVariable) _then;

  @override
  $Res call({
    Object? VariableName = freezed,
    Object? VariableSub = freezed,
  }) {
    return _then(_value.copyWith(
      VariableName: VariableName == freezed
          ? _value.VariableName
          : VariableName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      VariableSub: VariableSub == freezed
          ? _value.VariableSub
          : VariableSub // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_MessageTemplateVariableCopyWith<$Res>
    implements $MessageTemplateVariableCopyWith<$Res> {
  factory _$$_MessageTemplateVariableCopyWith(_$_MessageTemplateVariable value,
          $Res Function(_$_MessageTemplateVariable) then) =
      __$$_MessageTemplateVariableCopyWithImpl<$Res>;
  @override
  $Res call({dynamic VariableName, dynamic VariableSub});
}

/// @nodoc
class __$$_MessageTemplateVariableCopyWithImpl<$Res>
    extends _$MessageTemplateVariableCopyWithImpl<$Res>
    implements _$$_MessageTemplateVariableCopyWith<$Res> {
  __$$_MessageTemplateVariableCopyWithImpl(_$_MessageTemplateVariable _value,
      $Res Function(_$_MessageTemplateVariable) _then)
      : super(_value, (v) => _then(v as _$_MessageTemplateVariable));

  @override
  _$_MessageTemplateVariable get _value =>
      super._value as _$_MessageTemplateVariable;

  @override
  $Res call({
    Object? VariableName = freezed,
    Object? VariableSub = freezed,
  }) {
    return _then(_$_MessageTemplateVariable(
      VariableName: VariableName == freezed
          ? _value.VariableName
          : VariableName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      VariableSub: VariableSub == freezed
          ? _value.VariableSub
          : VariableSub // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MessageTemplateVariable implements _MessageTemplateVariable {
  _$_MessageTemplateVariable({this.VariableName = '', this.VariableSub = ''});

  factory _$_MessageTemplateVariable.fromJson(Map<String, dynamic> json) =>
      _$$_MessageTemplateVariableFromJson(json);

  @override
  @JsonKey()
  final dynamic VariableName;
  @override
  @JsonKey()
  final dynamic VariableSub;

  @override
  String toString() {
    return 'MessageTemplateVariable(VariableName: $VariableName, VariableSub: $VariableSub)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageTemplateVariable &&
            const DeepCollectionEquality()
                .equals(other.VariableName, VariableName) &&
            const DeepCollectionEquality()
                .equals(other.VariableSub, VariableSub));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(VariableName),
      const DeepCollectionEquality().hash(VariableSub));

  @JsonKey(ignore: true)
  @override
  _$$_MessageTemplateVariableCopyWith<_$_MessageTemplateVariable>
      get copyWith =>
          __$$_MessageTemplateVariableCopyWithImpl<_$_MessageTemplateVariable>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageTemplateVariableToJson(
      this,
    );
  }
}

abstract class _MessageTemplateVariable implements MessageTemplateVariable {
  factory _MessageTemplateVariable(
      {final dynamic VariableName,
      final dynamic VariableSub}) = _$_MessageTemplateVariable;

  factory _MessageTemplateVariable.fromJson(Map<String, dynamic> json) =
      _$_MessageTemplateVariable.fromJson;

  @override
  dynamic get VariableName;
  @override
  dynamic get VariableSub;
  @override
  @JsonKey(ignore: true)
  _$$_MessageTemplateVariableCopyWith<_$_MessageTemplateVariable>
      get copyWith => throw _privateConstructorUsedError;
}
