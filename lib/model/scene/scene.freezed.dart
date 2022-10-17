// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'scene.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Scene _$SceneFromJson(Map<String, dynamic> json) {
  return _Scene.fromJson(json);
}

/// @nodoc
mixin _$Scene {
  dynamic get SceneID => throw _privateConstructorUsedError;
  dynamic get SceneName => throw _privateConstructorUsedError;
  List<SceneItem> get Items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SceneCopyWith<Scene> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SceneCopyWith<$Res> {
  factory $SceneCopyWith(Scene value, $Res Function(Scene) then) =
      _$SceneCopyWithImpl<$Res>;
  $Res call({dynamic SceneID, dynamic SceneName, List<SceneItem> Items});
}

/// @nodoc
class _$SceneCopyWithImpl<$Res> implements $SceneCopyWith<$Res> {
  _$SceneCopyWithImpl(this._value, this._then);

  final Scene _value;
  // ignore: unused_field
  final $Res Function(Scene) _then;

  @override
  $Res call({
    Object? SceneID = freezed,
    Object? SceneName = freezed,
    Object? Items = freezed,
  }) {
    return _then(_value.copyWith(
      SceneID: SceneID == freezed
          ? _value.SceneID
          : SceneID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      SceneName: SceneName == freezed
          ? _value.SceneName
          : SceneName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Items: Items == freezed
          ? _value.Items
          : Items // ignore: cast_nullable_to_non_nullable
              as List<SceneItem>,
    ));
  }
}

/// @nodoc
abstract class _$$_SceneCopyWith<$Res> implements $SceneCopyWith<$Res> {
  factory _$$_SceneCopyWith(_$_Scene value, $Res Function(_$_Scene) then) =
      __$$_SceneCopyWithImpl<$Res>;
  @override
  $Res call({dynamic SceneID, dynamic SceneName, List<SceneItem> Items});
}

/// @nodoc
class __$$_SceneCopyWithImpl<$Res> extends _$SceneCopyWithImpl<$Res>
    implements _$$_SceneCopyWith<$Res> {
  __$$_SceneCopyWithImpl(_$_Scene _value, $Res Function(_$_Scene) _then)
      : super(_value, (v) => _then(v as _$_Scene));

  @override
  _$_Scene get _value => super._value as _$_Scene;

  @override
  $Res call({
    Object? SceneID = freezed,
    Object? SceneName = freezed,
    Object? Items = freezed,
  }) {
    return _then(_$_Scene(
      SceneID: SceneID == freezed
          ? _value.SceneID
          : SceneID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      SceneName: SceneName == freezed
          ? _value.SceneName
          : SceneName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Items: Items == freezed
          ? _value._Items
          : Items // ignore: cast_nullable_to_non_nullable
              as List<SceneItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Scene implements _Scene {
  _$_Scene(
      {this.SceneID = '',
      this.SceneName = '',
      required final List<SceneItem> Items})
      : _Items = Items;

  factory _$_Scene.fromJson(Map<String, dynamic> json) =>
      _$$_SceneFromJson(json);

  @override
  @JsonKey()
  final dynamic SceneID;
  @override
  @JsonKey()
  final dynamic SceneName;
  final List<SceneItem> _Items;
  @override
  List<SceneItem> get Items {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_Items);
  }

  @override
  String toString() {
    return 'Scene(SceneID: $SceneID, SceneName: $SceneName, Items: $Items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Scene &&
            const DeepCollectionEquality().equals(other.SceneID, SceneID) &&
            const DeepCollectionEquality().equals(other.SceneName, SceneName) &&
            const DeepCollectionEquality().equals(other._Items, _Items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(SceneID),
      const DeepCollectionEquality().hash(SceneName),
      const DeepCollectionEquality().hash(_Items));

  @JsonKey(ignore: true)
  @override
  _$$_SceneCopyWith<_$_Scene> get copyWith =>
      __$$_SceneCopyWithImpl<_$_Scene>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SceneToJson(
      this,
    );
  }
}

abstract class _Scene implements Scene {
  factory _Scene(
      {final dynamic SceneID,
      final dynamic SceneName,
      required final List<SceneItem> Items}) = _$_Scene;

  factory _Scene.fromJson(Map<String, dynamic> json) = _$_Scene.fromJson;

  @override
  dynamic get SceneID;
  @override
  dynamic get SceneName;
  @override
  List<SceneItem> get Items;
  @override
  @JsonKey(ignore: true)
  _$$_SceneCopyWith<_$_Scene> get copyWith =>
      throw _privateConstructorUsedError;
}
