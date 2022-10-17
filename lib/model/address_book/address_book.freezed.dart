// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'address_book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AddressBook _$AddressBookFromJson(Map<String, dynamic> json) {
  return _AddressBook.fromJson(json);
}

/// @nodoc
mixin _$AddressBook {
  dynamic get Recipient => throw _privateConstructorUsedError;
  dynamic get TargetID => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressBookCopyWith<AddressBook> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressBookCopyWith<$Res> {
  factory $AddressBookCopyWith(
          AddressBook value, $Res Function(AddressBook) then) =
      _$AddressBookCopyWithImpl<$Res>;
  $Res call({dynamic Recipient, dynamic TargetID});
}

/// @nodoc
class _$AddressBookCopyWithImpl<$Res> implements $AddressBookCopyWith<$Res> {
  _$AddressBookCopyWithImpl(this._value, this._then);

  final AddressBook _value;
  // ignore: unused_field
  final $Res Function(AddressBook) _then;

  @override
  $Res call({
    Object? Recipient = freezed,
    Object? TargetID = freezed,
  }) {
    return _then(_value.copyWith(
      Recipient: Recipient == freezed
          ? _value.Recipient
          : Recipient // ignore: cast_nullable_to_non_nullable
              as dynamic,
      TargetID: TargetID == freezed
          ? _value.TargetID
          : TargetID // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_AddressBookCopyWith<$Res>
    implements $AddressBookCopyWith<$Res> {
  factory _$$_AddressBookCopyWith(
          _$_AddressBook value, $Res Function(_$_AddressBook) then) =
      __$$_AddressBookCopyWithImpl<$Res>;
  @override
  $Res call({dynamic Recipient, dynamic TargetID});
}

/// @nodoc
class __$$_AddressBookCopyWithImpl<$Res> extends _$AddressBookCopyWithImpl<$Res>
    implements _$$_AddressBookCopyWith<$Res> {
  __$$_AddressBookCopyWithImpl(
      _$_AddressBook _value, $Res Function(_$_AddressBook) _then)
      : super(_value, (v) => _then(v as _$_AddressBook));

  @override
  _$_AddressBook get _value => super._value as _$_AddressBook;

  @override
  $Res call({
    Object? Recipient = freezed,
    Object? TargetID = freezed,
  }) {
    return _then(_$_AddressBook(
      Recipient: Recipient == freezed
          ? _value.Recipient
          : Recipient // ignore: cast_nullable_to_non_nullable
              as dynamic,
      TargetID: TargetID == freezed
          ? _value.TargetID
          : TargetID // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AddressBook implements _AddressBook {
  _$_AddressBook({this.Recipient = '', this.TargetID = ''});

  factory _$_AddressBook.fromJson(Map<String, dynamic> json) =>
      _$$_AddressBookFromJson(json);

  @override
  @JsonKey()
  final dynamic Recipient;
  @override
  @JsonKey()
  final dynamic TargetID;

  @override
  String toString() {
    return 'AddressBook(Recipient: $Recipient, TargetID: $TargetID)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddressBook &&
            const DeepCollectionEquality().equals(other.Recipient, Recipient) &&
            const DeepCollectionEquality().equals(other.TargetID, TargetID));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(Recipient),
      const DeepCollectionEquality().hash(TargetID));

  @JsonKey(ignore: true)
  @override
  _$$_AddressBookCopyWith<_$_AddressBook> get copyWith =>
      __$$_AddressBookCopyWithImpl<_$_AddressBook>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AddressBookToJson(
      this,
    );
  }
}

abstract class _AddressBook implements AddressBook {
  factory _AddressBook({final dynamic Recipient, final dynamic TargetID}) =
      _$_AddressBook;

  factory _AddressBook.fromJson(Map<String, dynamic> json) =
      _$_AddressBook.fromJson;

  @override
  dynamic get Recipient;
  @override
  dynamic get TargetID;
  @override
  @JsonKey(ignore: true)
  _$$_AddressBookCopyWith<_$_AddressBook> get copyWith =>
      throw _privateConstructorUsedError;
}
