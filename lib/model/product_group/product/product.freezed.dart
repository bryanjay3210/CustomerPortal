// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  dynamic get ProductID => throw _privateConstructorUsedError;
  dynamic get ProductName => throw _privateConstructorUsedError;
  dynamic get ProductPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res>;
  $Res call({dynamic ProductID, dynamic ProductName, dynamic ProductPrice});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res> implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  final Product _value;
  // ignore: unused_field
  final $Res Function(Product) _then;

  @override
  $Res call({
    Object? ProductID = freezed,
    Object? ProductName = freezed,
    Object? ProductPrice = freezed,
  }) {
    return _then(_value.copyWith(
      ProductID: ProductID == freezed
          ? _value.ProductID
          : ProductID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      ProductName: ProductName == freezed
          ? _value.ProductName
          : ProductName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      ProductPrice: ProductPrice == freezed
          ? _value.ProductPrice
          : ProductPrice // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$_ProductCopyWith(
          _$_Product value, $Res Function(_$_Product) then) =
      __$$_ProductCopyWithImpl<$Res>;
  @override
  $Res call({dynamic ProductID, dynamic ProductName, dynamic ProductPrice});
}

/// @nodoc
class __$$_ProductCopyWithImpl<$Res> extends _$ProductCopyWithImpl<$Res>
    implements _$$_ProductCopyWith<$Res> {
  __$$_ProductCopyWithImpl(_$_Product _value, $Res Function(_$_Product) _then)
      : super(_value, (v) => _then(v as _$_Product));

  @override
  _$_Product get _value => super._value as _$_Product;

  @override
  $Res call({
    Object? ProductID = freezed,
    Object? ProductName = freezed,
    Object? ProductPrice = freezed,
  }) {
    return _then(_$_Product(
      ProductID: ProductID == freezed
          ? _value.ProductID
          : ProductID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      ProductName: ProductName == freezed
          ? _value.ProductName
          : ProductName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      ProductPrice: ProductPrice == freezed
          ? _value.ProductPrice
          : ProductPrice // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Product implements _Product {
  _$_Product(
      {this.ProductID = '', this.ProductName = '', this.ProductPrice = ''});

  factory _$_Product.fromJson(Map<String, dynamic> json) =>
      _$$_ProductFromJson(json);

  @override
  @JsonKey()
  final dynamic ProductID;
  @override
  @JsonKey()
  final dynamic ProductName;
  @override
  @JsonKey()
  final dynamic ProductPrice;

  @override
  String toString() {
    return 'Product(ProductID: $ProductID, ProductName: $ProductName, ProductPrice: $ProductPrice)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Product &&
            const DeepCollectionEquality().equals(other.ProductID, ProductID) &&
            const DeepCollectionEquality()
                .equals(other.ProductName, ProductName) &&
            const DeepCollectionEquality()
                .equals(other.ProductPrice, ProductPrice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(ProductID),
      const DeepCollectionEquality().hash(ProductName),
      const DeepCollectionEquality().hash(ProductPrice));

  @JsonKey(ignore: true)
  @override
  _$$_ProductCopyWith<_$_Product> get copyWith =>
      __$$_ProductCopyWithImpl<_$_Product>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductToJson(
      this,
    );
  }
}

abstract class _Product implements Product {
  factory _Product(
      {final dynamic ProductID,
      final dynamic ProductName,
      final dynamic ProductPrice}) = _$_Product;

  factory _Product.fromJson(Map<String, dynamic> json) = _$_Product.fromJson;

  @override
  dynamic get ProductID;
  @override
  dynamic get ProductName;
  @override
  dynamic get ProductPrice;
  @override
  @JsonKey(ignore: true)
  _$$_ProductCopyWith<_$_Product> get copyWith =>
      throw _privateConstructorUsedError;
}
