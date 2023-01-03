// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'channel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Channel _$ChannelFromJson(Map<String, dynamic> json) {
  return _Channel.fromJson(json);
}

/// @nodoc
mixin _$Channel {
  dynamic get Name => throw _privateConstructorUsedError;
  dynamic get Number => throw _privateConstructorUsedError;
  dynamic get ID => throw _privateConstructorUsedError;
  dynamic get Icon => throw _privateConstructorUsedError;
  dynamic get Stream => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChannelCopyWith<Channel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelCopyWith<$Res> {
  factory $ChannelCopyWith(Channel value, $Res Function(Channel) then) =
      _$ChannelCopyWithImpl<$Res, Channel>;
  @useResult
  $Res call(
      {dynamic Name, dynamic Number, dynamic ID, dynamic Icon, dynamic Stream});
}

/// @nodoc
class _$ChannelCopyWithImpl<$Res, $Val extends Channel>
    implements $ChannelCopyWith<$Res> {
  _$ChannelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? Name = freezed,
    Object? Number = freezed,
    Object? ID = freezed,
    Object? Icon = freezed,
    Object? Stream = freezed,
  }) {
    return _then(_value.copyWith(
      Name: freezed == Name
          ? _value.Name
          : Name // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Number: freezed == Number
          ? _value.Number
          : Number // ignore: cast_nullable_to_non_nullable
              as dynamic,
      ID: freezed == ID
          ? _value.ID
          : ID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Icon: freezed == Icon
          ? _value.Icon
          : Icon // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Stream: freezed == Stream
          ? _value.Stream
          : Stream // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChannelCopyWith<$Res> implements $ChannelCopyWith<$Res> {
  factory _$$_ChannelCopyWith(
          _$_Channel value, $Res Function(_$_Channel) then) =
      __$$_ChannelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic Name, dynamic Number, dynamic ID, dynamic Icon, dynamic Stream});
}

/// @nodoc
class __$$_ChannelCopyWithImpl<$Res>
    extends _$ChannelCopyWithImpl<$Res, _$_Channel>
    implements _$$_ChannelCopyWith<$Res> {
  __$$_ChannelCopyWithImpl(_$_Channel _value, $Res Function(_$_Channel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? Name = freezed,
    Object? Number = freezed,
    Object? ID = freezed,
    Object? Icon = freezed,
    Object? Stream = freezed,
  }) {
    return _then(_$_Channel(
      Name: freezed == Name
          ? _value.Name
          : Name // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Number: freezed == Number
          ? _value.Number
          : Number // ignore: cast_nullable_to_non_nullable
              as dynamic,
      ID: freezed == ID
          ? _value.ID
          : ID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Icon: freezed == Icon
          ? _value.Icon
          : Icon // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Stream: freezed == Stream
          ? _value.Stream
          : Stream // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Channel with DiagnosticableTreeMixin implements _Channel {
  _$_Channel(
      {this.Name = '',
      this.Number = '',
      this.ID = '',
      this.Icon = '',
      this.Stream = ''});

  factory _$_Channel.fromJson(Map<String, dynamic> json) =>
      _$$_ChannelFromJson(json);

  @override
  @JsonKey()
  final dynamic Name;
  @override
  @JsonKey()
  final dynamic Number;
  @override
  @JsonKey()
  final dynamic ID;
  @override
  @JsonKey()
  final dynamic Icon;
  @override
  @JsonKey()
  final dynamic Stream;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Channel(Name: $Name, Number: $Number, ID: $ID, Icon: $Icon, Stream: $Stream)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Channel'))
      ..add(DiagnosticsProperty('Name', Name))
      ..add(DiagnosticsProperty('Number', Number))
      ..add(DiagnosticsProperty('ID', ID))
      ..add(DiagnosticsProperty('Icon', Icon))
      ..add(DiagnosticsProperty('Stream', Stream));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Channel &&
            const DeepCollectionEquality().equals(other.Name, Name) &&
            const DeepCollectionEquality().equals(other.Number, Number) &&
            const DeepCollectionEquality().equals(other.ID, ID) &&
            const DeepCollectionEquality().equals(other.Icon, Icon) &&
            const DeepCollectionEquality().equals(other.Stream, Stream));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(Name),
      const DeepCollectionEquality().hash(Number),
      const DeepCollectionEquality().hash(ID),
      const DeepCollectionEquality().hash(Icon),
      const DeepCollectionEquality().hash(Stream));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChannelCopyWith<_$_Channel> get copyWith =>
      __$$_ChannelCopyWithImpl<_$_Channel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChannelToJson(
      this,
    );
  }
}

abstract class _Channel implements Channel {
  factory _Channel(
      {final dynamic Name,
      final dynamic Number,
      final dynamic ID,
      final dynamic Icon,
      final dynamic Stream}) = _$_Channel;

  factory _Channel.fromJson(Map<String, dynamic> json) = _$_Channel.fromJson;

  @override
  dynamic get Name;
  @override
  dynamic get Number;
  @override
  dynamic get ID;
  @override
  dynamic get Icon;
  @override
  dynamic get Stream;
  @override
  @JsonKey(ignore: true)
  _$$_ChannelCopyWith<_$_Channel> get copyWith =>
      throw _privateConstructorUsedError;
}
