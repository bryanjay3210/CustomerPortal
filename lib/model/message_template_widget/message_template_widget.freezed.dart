// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_template_widget.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageTemplateWidget _$MessageTemplateWidgetFromJson(
    Map<String, dynamic> json) {
  return _MessageTemplateWidget.fromJson(json);
}

/// @nodoc
mixin _$MessageTemplateWidget {
  String get TemplateID => throw _privateConstructorUsedError;
  String get TemplateName => throw _privateConstructorUsedError;
  String get TemplateText => throw _privateConstructorUsedError;
  bool get isSelected => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageTemplateWidgetCopyWith<MessageTemplateWidget> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageTemplateWidgetCopyWith<$Res> {
  factory $MessageTemplateWidgetCopyWith(MessageTemplateWidget value,
          $Res Function(MessageTemplateWidget) then) =
      _$MessageTemplateWidgetCopyWithImpl<$Res, MessageTemplateWidget>;
  @useResult
  $Res call(
      {String TemplateID,
      String TemplateName,
      String TemplateText,
      bool isSelected});
}

/// @nodoc
class _$MessageTemplateWidgetCopyWithImpl<$Res,
        $Val extends MessageTemplateWidget>
    implements $MessageTemplateWidgetCopyWith<$Res> {
  _$MessageTemplateWidgetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? TemplateID = null,
    Object? TemplateName = null,
    Object? TemplateText = null,
    Object? isSelected = null,
  }) {
    return _then(_value.copyWith(
      TemplateID: null == TemplateID
          ? _value.TemplateID
          : TemplateID // ignore: cast_nullable_to_non_nullable
              as String,
      TemplateName: null == TemplateName
          ? _value.TemplateName
          : TemplateName // ignore: cast_nullable_to_non_nullable
              as String,
      TemplateText: null == TemplateText
          ? _value.TemplateText
          : TemplateText // ignore: cast_nullable_to_non_nullable
              as String,
      isSelected: null == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MessageTemplateWidgetCopyWith<$Res>
    implements $MessageTemplateWidgetCopyWith<$Res> {
  factory _$$_MessageTemplateWidgetCopyWith(_$_MessageTemplateWidget value,
          $Res Function(_$_MessageTemplateWidget) then) =
      __$$_MessageTemplateWidgetCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String TemplateID,
      String TemplateName,
      String TemplateText,
      bool isSelected});
}

/// @nodoc
class __$$_MessageTemplateWidgetCopyWithImpl<$Res>
    extends _$MessageTemplateWidgetCopyWithImpl<$Res, _$_MessageTemplateWidget>
    implements _$$_MessageTemplateWidgetCopyWith<$Res> {
  __$$_MessageTemplateWidgetCopyWithImpl(_$_MessageTemplateWidget _value,
      $Res Function(_$_MessageTemplateWidget) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? TemplateID = null,
    Object? TemplateName = null,
    Object? TemplateText = null,
    Object? isSelected = null,
  }) {
    return _then(_$_MessageTemplateWidget(
      TemplateID: null == TemplateID
          ? _value.TemplateID
          : TemplateID // ignore: cast_nullable_to_non_nullable
              as String,
      TemplateName: null == TemplateName
          ? _value.TemplateName
          : TemplateName // ignore: cast_nullable_to_non_nullable
              as String,
      TemplateText: null == TemplateText
          ? _value.TemplateText
          : TemplateText // ignore: cast_nullable_to_non_nullable
              as String,
      isSelected: null == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MessageTemplateWidget implements _MessageTemplateWidget {
  _$_MessageTemplateWidget(
      {this.TemplateID = '',
      this.TemplateName = '',
      this.TemplateText = '',
      required this.isSelected});

  factory _$_MessageTemplateWidget.fromJson(Map<String, dynamic> json) =>
      _$$_MessageTemplateWidgetFromJson(json);

  @override
  @JsonKey()
  final String TemplateID;
  @override
  @JsonKey()
  final String TemplateName;
  @override
  @JsonKey()
  final String TemplateText;
  @override
  final bool isSelected;

  @override
  String toString() {
    return 'MessageTemplateWidget(TemplateID: $TemplateID, TemplateName: $TemplateName, TemplateText: $TemplateText, isSelected: $isSelected)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageTemplateWidget &&
            (identical(other.TemplateID, TemplateID) ||
                other.TemplateID == TemplateID) &&
            (identical(other.TemplateName, TemplateName) ||
                other.TemplateName == TemplateName) &&
            (identical(other.TemplateText, TemplateText) ||
                other.TemplateText == TemplateText) &&
            (identical(other.isSelected, isSelected) ||
                other.isSelected == isSelected));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, TemplateID, TemplateName, TemplateText, isSelected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessageTemplateWidgetCopyWith<_$_MessageTemplateWidget> get copyWith =>
      __$$_MessageTemplateWidgetCopyWithImpl<_$_MessageTemplateWidget>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageTemplateWidgetToJson(
      this,
    );
  }
}

abstract class _MessageTemplateWidget implements MessageTemplateWidget {
  factory _MessageTemplateWidget(
      {final String TemplateID,
      final String TemplateName,
      final String TemplateText,
      required final bool isSelected}) = _$_MessageTemplateWidget;

  factory _MessageTemplateWidget.fromJson(Map<String, dynamic> json) =
      _$_MessageTemplateWidget.fromJson;

  @override
  String get TemplateID;
  @override
  String get TemplateName;
  @override
  String get TemplateText;
  @override
  bool get isSelected;
  @override
  @JsonKey(ignore: true)
  _$$_MessageTemplateWidgetCopyWith<_$_MessageTemplateWidget> get copyWith =>
      throw _privateConstructorUsedError;
}
