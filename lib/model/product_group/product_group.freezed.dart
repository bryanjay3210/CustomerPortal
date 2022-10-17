// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'product_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProductGroup _$ProductGroupFromJson(Map<String, dynamic> json) {
  return _ProductGroup.fromJson(json);
}

/// @nodoc
mixin _$ProductGroup {
  dynamic get GroupID => throw _privateConstructorUsedError;
  dynamic get GroupName => throw _privateConstructorUsedError;
  dynamic get CustomerAvailable => throw _privateConstructorUsedError;
  List<Product>? get Products => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductGroupCopyWith<ProductGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductGroupCopyWith<$Res> {
  factory $ProductGroupCopyWith(
          ProductGroup value, $Res Function(ProductGroup) then) =
      _$ProductGroupCopyWithImpl<$Res>;
  $Res call(
      {dynamic GroupID,
      dynamic GroupName,
      dynamic CustomerAvailable,
      List<Product>? Products});
}

/// @nodoc
class _$ProductGroupCopyWithImpl<$Res> implements $ProductGroupCopyWith<$Res> {
  _$ProductGroupCopyWithImpl(this._value, this._then);

  final ProductGroup _value;
  // ignore: unused_field
  final $Res Function(ProductGroup) _then;

  @override
  $Res call({
    Object? GroupID = freezed,
    Object? GroupName = freezed,
    Object? CustomerAvailable = freezed,
    Object? Products = freezed,
  }) {
    return _then(_value.copyWith(
      GroupID: GroupID == freezed
          ? _value.GroupID
          : GroupID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      GroupName: GroupName == freezed
          ? _value.GroupName
          : GroupName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CustomerAvailable: CustomerAvailable == freezed
          ? _value.CustomerAvailable
          : CustomerAvailable // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Products: Products == freezed
          ? _value.Products
          : Products // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
    ));
  }
}

/// @nodoc
abstract class _$$_ProductGroupCopyWith<$Res>
    implements $ProductGroupCopyWith<$Res> {
  factory _$$_ProductGroupCopyWith(
          _$_ProductGroup value, $Res Function(_$_ProductGroup) then) =
      __$$_ProductGroupCopyWithImpl<$Res>;
  @override
  $Res call(
      {dynamic GroupID,
      dynamic GroupName,
      dynamic CustomerAvailable,
      List<Product>? Products});
}

/// @nodoc
class __$$_ProductGroupCopyWithImpl<$Res>
    extends _$ProductGroupCopyWithImpl<$Res>
    implements _$$_ProductGroupCopyWith<$Res> {
  __$$_ProductGroupCopyWithImpl(
      _$_ProductGroup _value, $Res Function(_$_ProductGroup) _then)
      : super(_value, (v) => _then(v as _$_ProductGroup));

  @override
  _$_ProductGroup get _value => super._value as _$_ProductGroup;

  @override
  $Res call({
    Object? GroupID = freezed,
    Object? GroupName = freezed,
    Object? CustomerAvailable = freezed,
    Object? Products = freezed,
  }) {
    return _then(_$_ProductGroup(
      GroupID: GroupID == freezed
          ? _value.GroupID
          : GroupID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      GroupName: GroupName == freezed
          ? _value.GroupName
          : GroupName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CustomerAvailable: CustomerAvailable == freezed
          ? _value.CustomerAvailable
          : CustomerAvailable // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Products: Products == freezed
          ? _value._Products
          : Products // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProductGroup implements _ProductGroup {
  _$_ProductGroup(
      {this.GroupID = '',
      this.GroupName = '',
      this.CustomerAvailable = '',
      final List<Product>? Products})
      : _Products = Products;

  factory _$_ProductGroup.fromJson(Map<String, dynamic> json) =>
      _$$_ProductGroupFromJson(json);

  @override
  @JsonKey()
  final dynamic GroupID;
  @override
  @JsonKey()
  final dynamic GroupName;
  @override
  @JsonKey()
  final dynamic CustomerAvailable;
  final List<Product>? _Products;
  @override
  List<Product>? get Products {
    final value = _Products;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ProductGroup(GroupID: $GroupID, GroupName: $GroupName, CustomerAvailable: $CustomerAvailable, Products: $Products)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductGroup &&
            const DeepCollectionEquality().equals(other.GroupID, GroupID) &&
            const DeepCollectionEquality().equals(other.GroupName, GroupName) &&
            const DeepCollectionEquality()
                .equals(other.CustomerAvailable, CustomerAvailable) &&
            const DeepCollectionEquality().equals(other._Products, _Products));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(GroupID),
      const DeepCollectionEquality().hash(GroupName),
      const DeepCollectionEquality().hash(CustomerAvailable),
      const DeepCollectionEquality().hash(_Products));

  @JsonKey(ignore: true)
  @override
  _$$_ProductGroupCopyWith<_$_ProductGroup> get copyWith =>
      __$$_ProductGroupCopyWithImpl<_$_ProductGroup>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductGroupToJson(
      this,
    );
  }
}

abstract class _ProductGroup implements ProductGroup {
  factory _ProductGroup(
      {final dynamic GroupID,
      final dynamic GroupName,
      final dynamic CustomerAvailable,
      final List<Product>? Products}) = _$_ProductGroup;

  factory _ProductGroup.fromJson(Map<String, dynamic> json) =
      _$_ProductGroup.fromJson;

  @override
  dynamic get GroupID;
  @override
  dynamic get GroupName;
  @override
  dynamic get CustomerAvailable;
  @override
  List<Product>? get Products;
  @override
  @JsonKey(ignore: true)
  _$$_ProductGroupCopyWith<_$_ProductGroup> get copyWith =>
      throw _privateConstructorUsedError;
}
