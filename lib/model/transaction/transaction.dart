import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
class Transaction with _$Transaction {
  factory Transaction({
    @Default('') dynamic TXNID,
    @Default('') dynamic CustomerID,
    @Default('') dynamic CustomerName,
    @Default('') dynamic TXNDate,
    @Default('') dynamic TXNStatus,
    @Default('') dynamic TXNCategory,
    @Default('') dynamic TXNDescription,
    @Default('') dynamic TXNAmount,
    @Default('') dynamic TXNAcctBalance,
    @Default('') dynamic TXNAcctPrepaid,
    @Default('') dynamic TXNInvoice,
    @Default('') dynamic TXNReference,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
}


