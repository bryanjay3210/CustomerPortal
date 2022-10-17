import 'package:cp/enum.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../../repository/account/payment_repository.dart';

class PaymentProvider {
  final paymentListState = BehaviorSubject<DataState>.seeded(DataState.initial);

  makePayment(Map<String, dynamic> map, BuildContext context) async {
    paymentListState.add(DataState.loading);
    Map<String, dynamic> data =
        await PaymentRepository(map['server']).makePayment(map);
    if (data['Status'] == 'Success') {
      const snackBar = SnackBar(
        content: Text('Payment successfully!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed('invoice');
    } else {
      var snackBar = SnackBar(
        content: Text('${data['Status']}'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed('invoice');
    }
    paymentListState.add(DataState.success);
  }
}
