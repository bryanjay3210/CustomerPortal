// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'scene_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SceneItem _$SceneItemFromJson(Map<String, dynamic> json) {
  return _SceneItem.fromJson(json);
}

/// @nodoc
mixin _$SceneItem {
  dynamic get ItemName => throw _privateConstructorUsedError;
  dynamic get ItemValue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SceneItemCopyWith<SceneItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SceneItemCopyWith<$Res> {
  factory $SceneItemCopyWith(SceneItem value, $Res Function(SceneItem) then) =
      _$SceneItemCopyWithImpl<$Res>;
  $Res call({dynamic ItemName, dynamic ItemValue});
}

/// @nodoc
class _$SceneItemCopyWithImpl<$Res> implements $SceneItemCopyWith<$Res> {
  _$SceneItemCopyWithImpl(this._value, this._then);

  final SceneItem _value;
  // ignore: unused_field
  final $Res Function(SceneItem) _then;

  @override
  $Res call({
    Object? ItemName = freezed,
    Object? ItemValue = freezed,
  }) {
    return _then(_value.copyWith(
      ItemName: ItemName == freezed
          ? _value.ItemName
          : ItemName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      ItemValue: ItemValue == freezed
          ? _value.ItemValue
          : ItemValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_SceneItemCopyWith<$Res> implements $SceneItemCopyWith<$Res> {
  factory _$$_SceneItemCopyWith(
          _$_SceneItem value, $Res Function(_$_SceneItem) then) =
      __$$_SceneItemCopyWithImpl<$Res>;
  @override
  $Res call({dynamic ItemName, dynamic ItemValue});
}

/// @nodoc
class __$$_SceneItemCopyWithImpl<$Res> extends _$SceneItemCopyWithImpl<$Res>
    implements _$$_SceneItemCopyWith<$Res> {
  __$$_SceneItemCopyWithImpl(
      _$_SceneItem _value, $Res Function(_$_SceneItem) _then)
      : super(_value, (v) => _then(v as _$_SceneItem));

  @override
  _$_SceneItem get _value => super._value as _$_SceneItem;

  @override
  $Res call({
    Object? ItemName = freezed,
    Object? ItemValue = freezed,
  }) {
    return _then(_$_SceneItem(
      ItemName: ItemName == freezed
          ? _value.ItemName
          : ItemName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      ItemValue: ItemValue == freezed
          ? _value.ItemValue
          : ItemValue // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SceneItem implements _SceneItem {
  _$_SceneItem({this.ItemName = '', this.ItemValue = ''});

  factory _$_SceneItem.fromJson(Map<String, dynamic> json) =>
      _$$_SceneItemFromJson(json);

  @override
  @JsonKey()
  final dynamic ItemName;
  @override
  @JsonKey()
  final dynamic ItemValue;

  @override
  String toString() {
    return 'SceneItem(ItemName: $ItemName, ItemValue: $ItemValue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SceneItem &&
            const DeepCollectionEquality().equals(other.ItemName, ItemName) &&
            const DeepCollectionEquality().equals(other.ItemValue, ItemValue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(ItemName),
      const DeepCollectionEquality().hash(ItemValue));

  @JsonKey(ignore: true)
  @override
  _$$_SceneItemCopyWith<_$_SceneItem> get copyWith =>
      __$$_SceneItemCopyWithImpl<_$_SceneItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SceneItemToJson(
      this,
    );
  }
}

abstract class _SceneItem implements SceneItem {
  factory _SceneItem({final dynamic ItemName, final dynamic ItemValue}) =
      _$_SceneItem;

  factory _SceneItem.fromJson(Map<String, dynamic> json) =
      _$_SceneItem.fromJson;

  @override
  dynamic get ItemName;
  @override
  dynamic get ItemValue;
  @override
  @JsonKey(ignore: true)
  _$$_SceneItemCopyWith<_$_SceneItem> get copyWith =>
      throw _privateConstructorUsedError;
}
