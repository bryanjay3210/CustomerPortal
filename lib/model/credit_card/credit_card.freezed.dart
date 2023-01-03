// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CreditCard _$CreditCardFromJson(Map<String, dynamic> json) {
  return _CreditCard.fromJson(json);
}

/// @nodoc
mixin _$CreditCard {
  dynamic get CardNum => throw _privateConstructorUsedError;
  dynamic get CardholderName => throw _privateConstructorUsedError;
  dynamic get CardType => throw _privateConstructorUsedError;
  dynamic get CardExpMonth => throw _privateConstructorUsedError;
  dynamic get CardExpYear => throw _privateConstructorUsedError;
  dynamic get CardCVV => throw _privateConstructorUsedError;
  dynamic get CardAutobill => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreditCardCopyWith<CreditCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditCardCopyWith<$Res> {
  factory $CreditCardCopyWith(
          CreditCard value, $Res Function(CreditCard) then) =
      _$CreditCardCopyWithImpl<$Res, CreditCard>;
  @useResult
  $Res call(
      {dynamic CardNum,
      dynamic CardholderName,
      dynamic CardType,
      dynamic CardExpMonth,
      dynamic CardExpYear,
      dynamic CardCVV,
      dynamic CardAutobill});
}

/// @nodoc
class _$CreditCardCopyWithImpl<$Res, $Val extends CreditCard>
    implements $CreditCardCopyWith<$Res> {
  _$CreditCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? CardNum = freezed,
    Object? CardholderName = freezed,
    Object? CardType = freezed,
    Object? CardExpMonth = freezed,
    Object? CardExpYear = freezed,
    Object? CardCVV = freezed,
    Object? CardAutobill = freezed,
  }) {
    return _then(_value.copyWith(
      CardNum: freezed == CardNum
          ? _value.CardNum
          : CardNum // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CardholderName: freezed == CardholderName
          ? _value.CardholderName
          : CardholderName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CardType: freezed == CardType
          ? _value.CardType
          : CardType // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CardExpMonth: freezed == CardExpMonth
          ? _value.CardExpMonth
          : CardExpMonth // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CardExpYear: freezed == CardExpYear
          ? _value.CardExpYear
          : CardExpYear // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CardCVV: freezed == CardCVV
          ? _value.CardCVV
          : CardCVV // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CardAutobill: freezed == CardAutobill
          ? _value.CardAutobill
          : CardAutobill // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CreditCardCopyWith<$Res>
    implements $CreditCardCopyWith<$Res> {
  factory _$$_CreditCardCopyWith(
          _$_CreditCard value, $Res Function(_$_CreditCard) then) =
      __$$_CreditCardCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic CardNum,
      dynamic CardholderName,
      dynamic CardType,
      dynamic CardExpMonth,
      dynamic CardExpYear,
      dynamic CardCVV,
      dynamic CardAutobill});
}

/// @nodoc
class __$$_CreditCardCopyWithImpl<$Res>
    extends _$CreditCardCopyWithImpl<$Res, _$_CreditCard>
    implements _$$_CreditCardCopyWith<$Res> {
  __$$_CreditCardCopyWithImpl(
      _$_CreditCard _value, $Res Function(_$_CreditCard) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? CardNum = freezed,
    Object? CardholderName = freezed,
    Object? CardType = freezed,
    Object? CardExpMonth = freezed,
    Object? CardExpYear = freezed,
    Object? CardCVV = freezed,
    Object? CardAutobill = freezed,
  }) {
    return _then(_$_CreditCard(
      CardNum: freezed == CardNum
          ? _value.CardNum
          : CardNum // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CardholderName: freezed == CardholderName
          ? _value.CardholderName
          : CardholderName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CardType: freezed == CardType
          ? _value.CardType
          : CardType // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CardExpMonth: freezed == CardExpMonth
          ? _value.CardExpMonth
          : CardExpMonth // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CardExpYear: freezed == CardExpYear
          ? _value.CardExpYear
          : CardExpYear // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CardCVV: freezed == CardCVV
          ? _value.CardCVV
          : CardCVV // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CardAutobill: freezed == CardAutobill
          ? _value.CardAutobill
          : CardAutobill // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CreditCard with DiagnosticableTreeMixin implements _CreditCard {
  _$_CreditCard(
      {this.CardNum = '',
      this.CardholderName = '',
      this.CardType = '',
      this.CardExpMonth = '',
      this.CardExpYear = '',
      this.CardCVV = '',
      this.CardAutobill = ''});

  factory _$_CreditCard.fromJson(Map<String, dynamic> json) =>
      _$$_CreditCardFromJson(json);

  @override
  @JsonKey()
  final dynamic CardNum;
  @override
  @JsonKey()
  final dynamic CardholderName;
  @override
  @JsonKey()
  final dynamic CardType;
  @override
  @JsonKey()
  final dynamic CardExpMonth;
  @override
  @JsonKey()
  final dynamic CardExpYear;
  @override
  @JsonKey()
  final dynamic CardCVV;
  @override
  @JsonKey()
  final dynamic CardAutobill;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CreditCard(CardNum: $CardNum, CardholderName: $CardholderName, CardType: $CardType, CardExpMonth: $CardExpMonth, CardExpYear: $CardExpYear, CardCVV: $CardCVV, CardAutobill: $CardAutobill)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CreditCard'))
      ..add(DiagnosticsProperty('CardNum', CardNum))
      ..add(DiagnosticsProperty('CardholderName', CardholderName))
      ..add(DiagnosticsProperty('CardType', CardType))
      ..add(DiagnosticsProperty('CardExpMonth', CardExpMonth))
      ..add(DiagnosticsProperty('CardExpYear', CardExpYear))
      ..add(DiagnosticsProperty('CardCVV', CardCVV))
      ..add(DiagnosticsProperty('CardAutobill', CardAutobill));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreditCard &&
            const DeepCollectionEquality().equals(other.CardNum, CardNum) &&
            const DeepCollectionEquality()
                .equals(other.CardholderName, CardholderName) &&
            const DeepCollectionEquality().equals(other.CardType, CardType) &&
            const DeepCollectionEquality()
                .equals(other.CardExpMonth, CardExpMonth) &&
            const DeepCollectionEquality()
                .equals(other.CardExpYear, CardExpYear) &&
            const DeepCollectionEquality().equals(other.CardCVV, CardCVV) &&
            const DeepCollectionEquality()
                .equals(other.CardAutobill, CardAutobill));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(CardNum),
      const DeepCollectionEquality().hash(CardholderName),
      const DeepCollectionEquality().hash(CardType),
      const DeepCollectionEquality().hash(CardExpMonth),
      const DeepCollectionEquality().hash(CardExpYear),
      const DeepCollectionEquality().hash(CardCVV),
      const DeepCollectionEquality().hash(CardAutobill));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreditCardCopyWith<_$_CreditCard> get copyWith =>
      __$$_CreditCardCopyWithImpl<_$_CreditCard>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreditCardToJson(
      this,
    );
  }
}

abstract class _CreditCard implements CreditCard {
  factory _CreditCard(
      {final dynamic CardNum,
      final dynamic CardholderName,
      final dynamic CardType,
      final dynamic CardExpMonth,
      final dynamic CardExpYear,
      final dynamic CardCVV,
      final dynamic CardAutobill}) = _$_CreditCard;

  factory _CreditCard.fromJson(Map<String, dynamic> json) =
      _$_CreditCard.fromJson;

  @override
  dynamic get CardNum;
  @override
  dynamic get CardholderName;
  @override
  dynamic get CardType;
  @override
  dynamic get CardExpMonth;
  @override
  dynamic get CardExpYear;
  @override
  dynamic get CardCVV;
  @override
  dynamic get CardAutobill;
  @override
  @JsonKey(ignore: true)
  _$$_CreditCardCopyWith<_$_CreditCard> get copyWith =>
      throw _privateConstructorUsedError;
}
