// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Invoices _$$_InvoicesFromJson(Map<String, dynamic> json) => _$_Invoices(
      InvoiceID: json['InvoiceID'] ?? '',
      UserID: json['UserID'] ?? '',
      CustomerID: json['CustomerID'] ?? '',
      InvoiceShipName: json['InvoiceShipName'] ?? '',
      InvoiceStatus: json['InvoiceStatus'] ?? '',
      InvoiceIssueDate: json['InvoiceIssueDate'] ?? '',
      InvoiceDueDate: json['InvoiceDueDate'] ?? '',
      InvoiceShippingStatus: json['InvoiceShippingStatus'] ?? '',
      InvoiceMethod: json['InvoiceMethod'] ?? '',
      InvoicePaid: json['InvoicePaid'] ?? '',
      InvoiceDue: json['InvoiceDue'] ?? '',
      InvoiceShipEmail: json['InvoiceShipEmail'] ?? '',
    );

Map<String, dynamic> _$$_InvoicesToJson(_$_Invoices instance) =>
    <String, dynamic>{
      'InvoiceID': instance.InvoiceID,
      'UserID': instance.UserID,
      'CustomerID': instance.CustomerID,
      'InvoiceShipName': instance.InvoiceShipName,
      'InvoiceStatus': instance.InvoiceStatus,
      'InvoiceIssueDate': instance.InvoiceIssueDate,
      'InvoiceDueDate': instance.InvoiceDueDate,
      'InvoiceShippingStatus': instance.InvoiceShippingStatus,
      'InvoiceMethod': instance.InvoiceMethod,
      'InvoicePaid': instance.InvoicePaid,
      'InvoiceDue': instance.InvoiceDue,
      'InvoiceShipEmail': instance.InvoiceShipEmail,
    };
