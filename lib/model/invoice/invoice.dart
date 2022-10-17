import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'invoice.freezed.dart';
part 'invoice.g.dart';

@freezed
class Invoices with _$Invoices {
  factory Invoices({
    @Default('') dynamic InvoiceID,
    @Default('') dynamic UserID,
    @Default('') dynamic CustomerID,
    @Default('') dynamic InvoiceShipName,
    @Default('') dynamic InvoiceStatus,
    @Default('') dynamic InvoiceIssueDate,
    @Default('') dynamic InvoiceDueDate,
    @Default('') dynamic InvoiceShippingStatus,
    @Default('') dynamic InvoiceMethod,
    @Default('') dynamic InvoicePaid,
    @Default('') dynamic InvoiceDue,
    @Default('') dynamic InvoiceShipEmail,
  }) = _Invoices;

  factory Invoices.fromJson(Map<String, dynamic> json) =>
      _$InvoicesFromJson(json);
}
