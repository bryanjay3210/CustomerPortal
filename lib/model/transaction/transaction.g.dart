// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Transaction _$$_TransactionFromJson(Map<String, dynamic> json) =>
    _$_Transaction(
      TXNID: json['TXNID'] ?? '',
      CustomerID: json['CustomerID'] ?? '',
      CustomerName: json['CustomerName'] ?? '',
      TXNDate: json['TXNDate'] ?? '',
      TXNStatus: json['TXNStatus'] ?? '',
      TXNCategory: json['TXNCategory'] ?? '',
      TXNDescription: json['TXNDescription'] ?? '',
      TXNAmount: json['TXNAmount'] ?? '',
      TXNAcctBalance: json['TXNAcctBalance'] ?? '',
      TXNAcctPrepaid: json['TXNAcctPrepaid'] ?? '',
      TXNInvoice: json['TXNInvoice'] ?? '',
      TXNReference: json['TXNReference'] ?? '',
    );

Map<String, dynamic> _$$_TransactionToJson(_$_Transaction instance) =>
    <String, dynamic>{
      'TXNID': instance.TXNID,
      'CustomerID': instance.CustomerID,
      'CustomerName': instance.CustomerName,
      'TXNDate': instance.TXNDate,
      'TXNStatus': instance.TXNStatus,
      'TXNCategory': instance.TXNCategory,
      'TXNDescription': instance.TXNDescription,
      'TXNAmount': instance.TXNAmount,
      'TXNAcctBalance': instance.TXNAcctBalance,
      'TXNAcctPrepaid': instance.TXNAcctPrepaid,
      'TXNInvoice': instance.TXNInvoice,
      'TXNReference': instance.TXNReference,
    };
