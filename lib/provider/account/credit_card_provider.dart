import 'package:cp/enum.dart';
import 'package:cp/model/credit_card/credit_card.dart';
import 'package:cp/shared_widgets/toasts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../../repository/account/credit_card_repository.dart';

class CreditCardProvider {
  final creditCardListState =
      BehaviorSubject<DataState>.seeded(DataState.initial);
  var creditCard = <CreditCard>[];
  final isAutoBill =
  BehaviorSubject<bool>.seeded(false);
  bool isCardValid = false;

  Future<List<CreditCard>> getCreditCardInfo(
      Map<String, dynamic> map, BuildContext context) async {
    creditCard = [];
    final creditCardList = <CreditCard>[];
    creditCardListState.add(DataState.loading);
    Map<String, dynamic> data =
        await CreditCardRepository(map['server']).getCard(map);
    if (data['Status'] != 'Success') {
      creditCardListState.add(DataState.initial);
      return creditCardList;
    }
    var creditCardData = CreditCard(
      CardNum: data['CardNum'],
      CardholderName: data['CardholderName'],
      CardType: data['CardType'],
      CardExpMonth: data['CardExpMonth'],
      CardExpYear: data['CardExpYear'],
      CardCVV: data['CardCVV'],
      CardAutobill: data['CardAutobill'],
    );
    creditCardList.add(creditCardData);
    isAutoBill.add(creditCardData.CardAutobill == 'Y' ? true : false);
    creditCard = creditCardList;
    creditCardListState.add(DataState.success);
    return creditCardList;
  }

  deleteCard(Map<String, dynamic> map, BuildContext context) async {
    creditCardListState.add(DataState.loading);
    Map<String, dynamic> data =
        await CreditCardRepository(map['server']).deleteCard(map);
    var res = data['Status'];
    if (data['Status'] == 'Success') {
      const snackBar = SnackBar(
        content: Text('Delete credit card successfully!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    var snackBar = SnackBar(
      content: Text('Error updating credit card! [$res]'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    creditCardListState.add(DataState.success);
  }

  updateCreditCard(Map<String, dynamic> map, BuildContext context) async {
    creditCardListState.add(DataState.loading);
    Map<String, dynamic> data =
        await CreditCardRepository(map['server']).updateCCInfo(map);
    var res = data['Status'];
    if (data['Status'] == 'Success') {
      const snackBar = SnackBar(
        content: Text('Update credit card successfully!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    if (res.toString().contains('Fail')) {
      var snackBar = SnackBar(
        content: Text('Error updating credit card! [$res]'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    creditCardListState.add(DataState.success);
  }

  futureChargeUpdate(Map<String, dynamic> map, BuildContext context) async{
    Map<String, dynamic> data =
        await CreditCardRepository(map['server']).futureChargeUpdate(map);
    if(data['Status'] == 'Success'){
      showToast('Credit card auto billing updated successfully!');
    } else {
      showToast(data['Status']);
    }
  }

  validateCard(Map<String, dynamic> map, BuildContext context) async {
    Map<String, dynamic> data =
        await CreditCardRepository(map['server']).validateCard(map);
    isCardValid = data["Status"] == 'Valid' ? true : false;
  }
}
