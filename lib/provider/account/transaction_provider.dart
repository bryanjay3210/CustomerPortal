import 'package:cp/enum.dart';
import 'package:cp/model/transaction/transaction.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../../repository/account/transaction_repository.dart';

class TransactionProvider {
  final transactionListState =
      BehaviorSubject<DataState>.seeded(DataState.initial);
  var transactions = <Transaction>[];

  Future<List<Transaction>> getTransactionInfo(
      Map<String, dynamic> map, BuildContext context) async {
    transactions = [];
    final transactionList = <Transaction>[];
    transactionListState.add(DataState.loading);
    Map<String, dynamic> data =
        await TransactionRepository(map['server']).getTransaction(map);
    if (data['Status'] != 'Success') {
      transactionListState.add(DataState.initial);
      return transactionList;
    }
    try {
      if(data['Transaction'] is Map){
        transactionList.add(Transaction.fromJson(data['Transaction']));
      } else if(data['Transaction'] is List<dynamic>){
        data['Transaction'].forEach((element) {
          transactionList.add(Transaction.fromJson(element));
        });
      } else {
        transactionListState.add(DataState.success);
      }
    } catch (e) {
      transactionListState.add(DataState.success);
    }
    transactions.addAll(transactionList);
    transactionListState.add(DataState.success);
    transactionList.toSet().toList();
    return transactionList;
  }
}
