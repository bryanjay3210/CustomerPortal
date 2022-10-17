// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'customer_message_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CustomerMessageGroup _$CustomerMessageGroupFromJson(Map<String, dynamic> json) {
  return _CustomerMessageGroup.fromJson(json);
}

/// @nodoc
mixin _$CustomerMessageGroup {
  dynamic get CustomerID => throw _privateConstructorUsedError;
  dynamic get Name => throw _privateConstructorUsedError;
  dynamic get FirstName => throw _privateConstructorUsedError;
  dynamic get LastName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerMessageGroupCopyWith<CustomerMessageGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerMessageGroupCopyWith<$Res> {
  factory $CustomerMessageGroupCopyWith(CustomerMessageGroup value,
          $Res Function(CustomerMessageGroup) then) =
      _$CustomerMessageGroupCopyWithImpl<$Res>;
  $Res call(
      {dynamic CustomerID, dynamic Name, dynamic FirstName, dynamic LastName});
}

/// @nodoc
class _$CustomerMessageGroupCopyWithImpl<$Res>
    implements $CustomerMessageGroupCopyWith<$Res> {
  _$CustomerMessageGroupCopyWithImpl(this._value, this._then);

  final CustomerMessageGroup _value;
  // ignore: unused_field
  final $Res Function(CustomerMessageGroup) _then;

  @override
  $Res call({
    Object? CustomerID = freezed,
    Object? Name = freezed,
    Object? FirstName = freezed,
    Object? LastName = freezed,
  }) {
    return _then(_value.copyWith(
      CustomerID: CustomerID == freezed
          ? _value.CustomerID
          : CustomerID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Name: Name == freezed
          ? _value.Name
          : Name // ignore: cast_nullable_to_non_nullable
              as dynamic,
      FirstName: FirstName == freezed
          ? _value.FirstName
          : FirstName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      LastName: LastName == freezed
          ? _value.LastName
          : LastName // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_CustomerMessageGroupCopyWith<$Res>
    implements $CustomerMessageGroupCopyWith<$Res> {
  factory _$$_CustomerMessageGroupCopyWith(_$_CustomerMessageGroup value,
          $Res Function(_$_CustomerMessageGroup) then) =
      __$$_CustomerMessageGroupCopyWithImpl<$Res>;
  @override
  $Res call(
      {dynamic CustomerID, dynamic Name, dynamic FirstName, dynamic LastName});
}

/// @nodoc
class __$$_CustomerMessageGroupCopyWithImpl<$Res>
    extends _$CustomerMessageGroupCopyWithImpl<$Res>
    implements _$$_CustomerMessageGroupCopyWith<$Res> {
  __$$_CustomerMessageGroupCopyWithImpl(_$_CustomerMessageGroup _value,
      $Res Function(_$_CustomerMessageGroup) _then)
      : super(_value, (v) => _then(v as _$_CustomerMessageGroup));

  @override
  _$_CustomerMessageGroup get _value => super._value as _$_CustomerMessageGroup;

  @override
  $Res call({
    Object? CustomerID = freezed,
    Object? Name = freezed,
    Object? FirstName = freezed,
    Object? LastName = freezed,
  }) {
    return _then(_$_CustomerMessageGroup(
      CustomerID: CustomerID == freezed
          ? _value.CustomerID
          : CustomerID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Name: Name == freezed
          ? _value.Name
          : Name // ignore: cast_nullable_to_non_nullable
              as dynamic,
      FirstName: FirstName == freezed
          ? _value.FirstName
          : FirstName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      LastName: LastName == freezed
          ? _value.LastName
          : LastName // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CustomerMessageGroup implements _CustomerMessageGroup {
  _$_CustomerMessageGroup(
      {this.CustomerID = '',
      this.Name = '',
      this.FirstName = '',
      this.LastName = ''});

  factory _$_CustomerMessageGroup.fromJson(Map<String, dynamic> json) =>
      _$$_CustomerMessageGroupFromJson(json);

  @override
  @JsonKey()
  final dynamic CustomerID;
  @override
  @JsonKey()
  final dynamic Name;
  @override
  @JsonKey()
  final dynamic FirstName;
  @override
  @JsonKey()
  final dynamic LastName;

  @override
  String toString() {
    return 'CustomerMessageGroup(CustomerID: $CustomerID, Name: $Name, FirstName: $FirstName, LastName: $LastName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CustomerMessageGroup &&
            const DeepCollectionEquality()
                .equals(other.CustomerID, CustomerID) &&
            const DeepCollectionEquality().equals(other.Name, Name) &&
            const DeepCollectionEquality().equals(other.FirstName, FirstName) &&
            const DeepCollectionEquality().equals(other.LastName, LastName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(CustomerID),
      const DeepCollectionEquality().hash(Name),
      const DeepCollectionEquality().hash(FirstName),
      const DeepCollectionEquality().hash(LastName));

  @JsonKey(ignore: true)
  @override
  _$$_CustomerMessageGroupCopyWith<_$_CustomerMessageGroup> get copyWith =>
      __$$_CustomerMessageGroupCopyWithImpl<_$_CustomerMessageGroup>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CustomerMessageGroupToJson(
      this,
    );
  }
}

abstract class _CustomerMessageGroup implements CustomerMessageGroup {
  factory _CustomerMessageGroup(
      {final dynamic CustomerID,
      final dynamic Name,
      final dynamic FirstName,
      final dynamic LastName}) = _$_CustomerMessageGroup;

  factory _CustomerMessageGroup.fromJson(Map<String, dynamic> json) =
      _$_CustomerMessageGroup.fromJson;

  @override
  dynamic get CustomerID;
  @override
  dynamic get Name;
  @override
  dynamic get FirstName;
  @override
  dynamic get LastName;
  @override
  @JsonKey(ignore: true)
  _$$_CustomerMessageGroupCopyWith<_$_CustomerMessageGroup> get copyWith =>
      throw _privateConstructorUsedError;
}
