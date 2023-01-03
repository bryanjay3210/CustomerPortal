// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
  dynamic get PlanID => throw _privateConstructorUsedError;
  dynamic get PlanPrice => throw _privateConstructorUsedError;
  dynamic get PlanName => throw _privateConstructorUsedError;
  dynamic get PlanStartDate => throw _privateConstructorUsedError;
  dynamic get PlanEndDate => throw _privateConstructorUsedError;
  dynamic get PaymentProcessor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {dynamic PlanID,
      dynamic PlanPrice,
      dynamic PlanName,
      dynamic PlanStartDate,
      dynamic PlanEndDate,
      dynamic PaymentProcessor});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? PlanID = freezed,
    Object? PlanPrice = freezed,
    Object? PlanName = freezed,
    Object? PlanStartDate = freezed,
    Object? PlanEndDate = freezed,
    Object? PaymentProcessor = freezed,
  }) {
    return _then(_value.copyWith(
      PlanID: freezed == PlanID
          ? _value.PlanID
          : PlanID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      PlanPrice: freezed == PlanPrice
          ? _value.PlanPrice
          : PlanPrice // ignore: cast_nullable_to_non_nullable
              as dynamic,
      PlanName: freezed == PlanName
          ? _value.PlanName
          : PlanName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      PlanStartDate: freezed == PlanStartDate
          ? _value.PlanStartDate
          : PlanStartDate // ignore: cast_nullable_to_non_nullable
              as dynamic,
      PlanEndDate: freezed == PlanEndDate
          ? _value.PlanEndDate
          : PlanEndDate // ignore: cast_nullable_to_non_nullable
              as dynamic,
      PaymentProcessor: freezed == PaymentProcessor
          ? _value.PaymentProcessor
          : PaymentProcessor // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$_ProductCopyWith(
          _$_Product value, $Res Function(_$_Product) then) =
      __$$_ProductCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic PlanID,
      dynamic PlanPrice,
      dynamic PlanName,
      dynamic PlanStartDate,
      dynamic PlanEndDate,
      dynamic PaymentProcessor});
}

/// @nodoc
class __$$_ProductCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$_Product>
    implements _$$_ProductCopyWith<$Res> {
  __$$_ProductCopyWithImpl(_$_Product _value, $Res Function(_$_Product) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? PlanID = freezed,
    Object? PlanPrice = freezed,
    Object? PlanName = freezed,
    Object? PlanStartDate = freezed,
    Object? PlanEndDate = freezed,
    Object? PaymentProcessor = freezed,
  }) {
    return _then(_$_Product(
      PlanID: freezed == PlanID
          ? _value.PlanID
          : PlanID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      PlanPrice: freezed == PlanPrice
          ? _value.PlanPrice
          : PlanPrice // ignore: cast_nullable_to_non_nullable
              as dynamic,
      PlanName: freezed == PlanName
          ? _value.PlanName
          : PlanName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      PlanStartDate: freezed == PlanStartDate
          ? _value.PlanStartDate
          : PlanStartDate // ignore: cast_nullable_to_non_nullable
              as dynamic,
      PlanEndDate: freezed == PlanEndDate
          ? _value.PlanEndDate
          : PlanEndDate // ignore: cast_nullable_to_non_nullable
              as dynamic,
      PaymentProcessor: freezed == PaymentProcessor
          ? _value.PaymentProcessor
          : PaymentProcessor // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Product with DiagnosticableTreeMixin implements _Product {
  _$_Product(
      {this.PlanID = '',
      this.PlanPrice = '',
      this.PlanName = '',
      this.PlanStartDate = '',
      this.PlanEndDate = '',
      this.PaymentProcessor = ''});

  factory _$_Product.fromJson(Map<String, dynamic> json) =>
      _$$_ProductFromJson(json);

  @override
  @JsonKey()
  final dynamic PlanID;
  @override
  @JsonKey()
  final dynamic PlanPrice;
  @override
  @JsonKey()
  final dynamic PlanName;
  @override
  @JsonKey()
  final dynamic PlanStartDate;
  @override
  @JsonKey()
  final dynamic PlanEndDate;
  @override
  @JsonKey()
  final dynamic PaymentProcessor;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Product(PlanID: $PlanID, PlanPrice: $PlanPrice, PlanName: $PlanName, PlanStartDate: $PlanStartDate, PlanEndDate: $PlanEndDate, PaymentProcessor: $PaymentProcessor)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Product'))
      ..add(DiagnosticsProperty('PlanID', PlanID))
      ..add(DiagnosticsProperty('PlanPrice', PlanPrice))
      ..add(DiagnosticsProperty('PlanName', PlanName))
      ..add(DiagnosticsProperty('PlanStartDate', PlanStartDate))
      ..add(DiagnosticsProperty('PlanEndDate', PlanEndDate))
      ..add(DiagnosticsProperty('PaymentProcessor', PaymentProcessor));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Product &&
            const DeepCollectionEquality().equals(other.PlanID, PlanID) &&
            const DeepCollectionEquality().equals(other.PlanPrice, PlanPrice) &&
            const DeepCollectionEquality().equals(other.PlanName, PlanName) &&
            const DeepCollectionEquality()
                .equals(other.PlanStartDate, PlanStartDate) &&
            const DeepCollectionEquality()
                .equals(other.PlanEndDate, PlanEndDate) &&
            const DeepCollectionEquality()
                .equals(other.PaymentProcessor, PaymentProcessor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(PlanID),
      const DeepCollectionEquality().hash(PlanPrice),
      const DeepCollectionEquality().hash(PlanName),
      const DeepCollectionEquality().hash(PlanStartDate),
      const DeepCollectionEquality().hash(PlanEndDate),
      const DeepCollectionEquality().hash(PaymentProcessor));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
      {final dynamic PlanID,
      final dynamic PlanPrice,
      final dynamic PlanName,
      final dynamic PlanStartDate,
      final dynamic PlanEndDate,
      final dynamic PaymentProcessor}) = _$_Product;

  factory _Product.fromJson(Map<String, dynamic> json) = _$_Product.fromJson;

  @override
  dynamic get PlanID;
  @override
  dynamic get PlanPrice;
  @override
  dynamic get PlanName;
  @override
  dynamic get PlanStartDate;
  @override
  dynamic get PlanEndDate;
  @override
  dynamic get PaymentProcessor;
  @override
  @JsonKey(ignore: true)
  _$$_ProductCopyWith<_$_Product> get copyWith =>
      throw _privateConstructorUsedError;
}
