import 'package:cp/provider/main_provider.dart';
import 'package:cp/utils/utils/datetime/datetimeUtils.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/account/transaction_provider.dart';

class TransactionDetail extends StatefulWidget {
  final int transactionIndex;
  const TransactionDetail({Key? key, required this.transactionIndex})
      : super(key: key);

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    final transactionDetail =
        transactionProvider.transactions.elementAt(widget.transactionIndex);
    return Scaffold(
      backgroundColor: const Color(0xff30313A),
      body: Column(
        children: [
          Container(
            color: const Color(0xff30313A),
            width: double.infinity,
            height: 130,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back_ios,
                          color: cpWhiteColor)),
                  const SizedBox(height: 30),
                  const Text(
                    'Transaction Detail',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: cpWhiteColor),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: mainProvider.darkTheme
                        ? cpDarkContainerColor
                        : const Color(0xffF5F5F5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Transaction Information',
                          style: TextStyle(
                              color: mainProvider.darkTheme
                                  ? cpWhiteColor
                                  : Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      informationText('Transaction ID',
                          transactionDetail.TXNID.toString(), mainProvider),
                      informationText(
                          'Description',
                          transactionDetail.TXNDescription.isEmpty ? '-' : transactionDetail.TXNDescription,
                          mainProvider),
                      informationText(
                          'Amount',
                          '\$${double.parse(transactionDetail.TXNAmount).toStringAsFixed(2)}',
                          mainProvider),
                      informationText(
                          'Transaction Invoice',
                          transactionDetail.TXNInvoice.toString(),
                          mainProvider),
                      informationText(
                          'Category',
                          transactionDetail.TXNCategory.isEmpty ? '-' : transactionDetail.TXNCategory,
                          mainProvider),
                      informationText(
                          'Balance',
                          '\$${double.parse(transactionDetail.TXNAcctBalance).toStringAsFixed(2)}',
                          mainProvider),
                      informationText(
                          'Transaction Reference',
                          transactionDetail.TXNReference.isEmpty ||
                                  transactionDetail.TXNReference.toString() ==
                                      '0'
                              ? '-'
                              : transactionDetail.TXNReference.toString(),
                          mainProvider),
                      informationText(
                          'Transaction Date',
                          jsTimeToDateTime(transactionDetail.TXNDate),
                          mainProvider),
                      informationText('Status',
                          transactionDetail.TXNStatus.toString(), mainProvider),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget informationText(
      String title, String value, MainProvider mainProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: 18,
              color: mainProvider.darkTheme ? cpWhiteColor : Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
