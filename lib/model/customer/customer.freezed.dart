// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return _Customer.fromJson(json);
}

/// @nodoc
mixin _$Customer {
  dynamic get CustomerName => throw _privateConstructorUsedError;
  dynamic get CustomerID => throw _privateConstructorUsedError;
  dynamic get CustomerTargetID => throw _privateConstructorUsedError;
  dynamic get CustomerTargetEmail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerCopyWith<Customer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerCopyWith<$Res> {
  factory $CustomerCopyWith(Customer value, $Res Function(Customer) then) =
      _$CustomerCopyWithImpl<$Res>;
  $Res call(
      {dynamic CustomerName,
      dynamic CustomerID,
      dynamic CustomerTargetID,
      dynamic CustomerTargetEmail});
}

/// @nodoc
class _$CustomerCopyWithImpl<$Res> implements $CustomerCopyWith<$Res> {
  _$CustomerCopyWithImpl(this._value, this._then);

  final Customer _value;
  // ignore: unused_field
  final $Res Function(Customer) _then;

  @override
  $Res call({
    Object? CustomerName = freezed,
    Object? CustomerID = freezed,
    Object? CustomerTargetID = freezed,
    Object? CustomerTargetEmail = freezed,
  }) {
    return _then(_value.copyWith(
      CustomerName: CustomerName == freezed
          ? _value.CustomerName
          : CustomerName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CustomerID: CustomerID == freezed
          ? _value.CustomerID
          : CustomerID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CustomerTargetID: CustomerTargetID == freezed
          ? _value.CustomerTargetID
          : CustomerTargetID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CustomerTargetEmail: CustomerTargetEmail == freezed
          ? _value.CustomerTargetEmail
          : CustomerTargetEmail // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_CustomerCopyWith<$Res> implements $CustomerCopyWith<$Res> {
  factory _$$_CustomerCopyWith(
          _$_Customer value, $Res Function(_$_Customer) then) =
      __$$_CustomerCopyWithImpl<$Res>;
  @override
  $Res call(
      {dynamic CustomerName,
      dynamic CustomerID,
      dynamic CustomerTargetID,
      dynamic CustomerTargetEmail});
}

/// @nodoc
class __$$_CustomerCopyWithImpl<$Res> extends _$CustomerCopyWithImpl<$Res>
    implements _$$_CustomerCopyWith<$Res> {
  __$$_CustomerCopyWithImpl(
      _$_Customer _value, $Res Function(_$_Customer) _then)
      : super(_value, (v) => _then(v as _$_Customer));

  @override
  _$_Customer get _value => super._value as _$_Customer;

  @override
  $Res call({
    Object? CustomerName = freezed,
    Object? CustomerID = freezed,
    Object? CustomerTargetID = freezed,
    Object? CustomerTargetEmail = freezed,
  }) {
    return _then(_$_Customer(
      CustomerName: CustomerName == freezed
          ? _value.CustomerName
          : CustomerName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CustomerID: CustomerID == freezed
          ? _value.CustomerID
          : CustomerID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CustomerTargetID: CustomerTargetID == freezed
          ? _value.CustomerTargetID
          : CustomerTargetID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CustomerTargetEmail: CustomerTargetEmail == freezed
          ? _value.CustomerTargetEmail
          : CustomerTargetEmail // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Customer implements _Customer {
  _$_Customer(
      {this.CustomerName = '',
      this.CustomerID = '',
      this.CustomerTargetID = '',
      this.CustomerTargetEmail = ''});

  factory _$_Customer.fromJson(Map<String, dynamic> json) =>
      _$$_CustomerFromJson(json);

  @override
  @JsonKey()
  final dynamic CustomerName;
  @override
  @JsonKey()
  final dynamic CustomerID;
  @override
  @JsonKey()
  final dynamic CustomerTargetID;
  @override
  @JsonKey()
  final dynamic CustomerTargetEmail;

  @override
  String toString() {
    return 'Customer(CustomerName: $CustomerName, CustomerID: $CustomerID, CustomerTargetID: $CustomerTargetID, CustomerTargetEmail: $CustomerTargetEmail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Customer &&
            const DeepCollectionEquality()
                .equals(other.CustomerName, CustomerName) &&
            const DeepCollectionEquality()
                .equals(other.CustomerID, CustomerID) &&
            const DeepCollectionEquality()
                .equals(other.CustomerTargetID, CustomerTargetID) &&
            const DeepCollectionEquality()
                .equals(other.CustomerTargetEmail, CustomerTargetEmail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(CustomerName),
      const DeepCollectionEquality().hash(CustomerID),
      const DeepCollectionEquality().hash(CustomerTargetID),
      const DeepCollectionEquality().hash(CustomerTargetEmail));

  @JsonKey(ignore: true)
  @override
  _$$_CustomerCopyWith<_$_Customer> get copyWith =>
      __$$_CustomerCopyWithImpl<_$_Customer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CustomerToJson(
      this,
    );
  }
}

abstract class _Customer implements Customer {
  factory _Customer(
      {final dynamic CustomerName,
      final dynamic CustomerID,
      final dynamic CustomerTargetID,
      final dynamic CustomerTargetEmail}) = _$_Customer;

  factory _Customer.fromJson(Map<String, dynamic> json) = _$_Customer.fromJson;

  @override
  dynamic get CustomerName;
  @override
  dynamic get CustomerID;
  @override
  dynamic get CustomerTargetID;
  @override
  dynamic get CustomerTargetEmail;
  @override
  @JsonKey(ignore: true)
  _$$_CustomerCopyWith<_$_Customer> get copyWith =>
      throw _privateConstructorUsedError;
}
