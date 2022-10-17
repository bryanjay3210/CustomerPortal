import 'package:cp/enum.dart';
import 'package:cp/provider/main_provider.dart';
import 'package:cp/utils/utils/datetime/datetimeUtils.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:cp/view/account/components/transaction_detail.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/account/transaction_provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    transactionProvider.getTransactionInfo({
      'customerId': mainProvider.user.CustomerID,
      'server': mainProvider.server,
      'userId': mainProvider.user.UserID,
    }, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final searchCtrler = TextEditingController();
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
                      'Transaction',
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
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
                child: Container(
                  color: mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: textBoxField('Search', searchCtrler),
                      ),
                      Expanded(
                        child: StreamBuilder<DataState>(
                          stream: transactionProvider.transactionListState,
                          builder: (context, snapshot) {
                            final data = transactionProvider.transactions;

                            if (snapshot.data == DataState.success &&
                                data.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/account/no-data.png',
                                      height: 100,
                                      width: 100,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text('No record found'),
                                  ],
                                ),
                              );
                            }
                            if (snapshot.data == DataState.success) {
                              return ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final transaction = data[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: GestureDetector(
                                        onTap: () => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              TransactionDetail(
                                                  transactionIndex: index),
                                        )),
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          color: mainProvider.darkTheme
                                              ? cpDarkContainerColor
                                              : const Color(0xffF5F5F5),
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    transaction.TXNCategory.isEmpty
                                                        ? '-'
                                                        : transaction
                                                                .TXNCategory
                                                            .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    transaction.TXNStatus,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            cpYellowDarkColor),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                transaction.TXNDescription.isEmpty
                                                    ? '-'
                                                    : transaction.TXNDescription
                                                        .toString(),
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                              informationText(
                                                  'Transaction No.:',
                                                  transaction.TXNID),
                                              informationText(
                                                  'Date:',
                                                  jsTimeToDateTime(
                                                      transaction.TXNDate)),
                                              informationText('Amount:',
                                                  '\$${double.parse(transaction.TXNAmount).toStringAsFixed(2)}'),
                                              informationText('Balance:',
                                                  '\$${double.parse(transaction.TXNAcctBalance).toStringAsFixed(2)}'),
                                              informationText(
                                                  'Reference No.:',
                                                  transaction.TXNReference.isEmpty ||
                                                          transaction.TXNReference
                                                                  .toString() ==
                                                              '0'
                                                      ? '-'
                                                      : transaction.TXNReference
                                                          .toString()),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget textBoxField(String label, TextEditingController ctrl) {
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        labelText: label,
        suffixIcon: IconButton(onPressed: () {
          EasyDebounce.debounce(
              'search-debouncer',                 // <-- An ID for this particular debouncer
              const Duration(seconds: 2),
                  () {
                transactionProvider.getTransactionInfo({
                  'customerId': mainProvider.user.CustomerID,
                  'server': mainProvider.server,
                  'userId': mainProvider.user.UserID,
                  'search': ctrl.text,
                }, context);
              });
        }, icon: const Icon(Icons.search)),
      ),
    );
  }

  Widget headingText(String text) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget informationText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
