import 'package:cp/enum.dart';
import 'package:cp/provider/main_provider.dart';
import 'package:cp/utils/utils/datetime/datetimeUtils.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:cp/view/account/components/invoices/component/invoice_information.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/account/invoice_provider.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  int page = 1;
  final searchCtrler = TextEditingController();

  @override
  void initState() {
    final invoiceProvider =
        Provider.of<InvoiceProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    invoiceProvider.invoices = [];
    invoiceProvider.getInvoiceInfo({
      'customerId': mainProvider.user.CustomerID,
      'page': page,
      'server': mainProvider.server,
      'userId': mainProvider.user.UserID,
    }, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceProvider =
        Provider.of<InvoiceProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (page == invoiceProvider.totalPage) {
          return;
        }
        page++;
        setState(() {
          invoiceProvider.getInvoiceInfoByPage({
            'customerId': mainProvider.user.CustomerID,
            'page': page,
            'server': mainProvider.server,
            'userId': mainProvider.user.UserID,
          }, context);
        });
      }
    });
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
                    'Invoices',
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
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                color: mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
                child: Column(
                  children: [
                    textBoxField('Search', searchCtrler, false),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: StreamBuilder<DataState>(
                          stream: invoiceProvider.invoiceListState,
                          builder: (context, snapshot) {
                            final data = invoiceProvider.invoices;
                            if (snapshot.data == null ||
                                snapshot.data == DataState.initial) {
                              return const CircularProgressIndicator.adaptive();
                            }
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
                              return Stack(
                                children: [
                                  ListView.builder(
                                    controller: _scrollController,
                                    itemCount: data.length,
                                    itemBuilder: ((context, index) {
                                      final invoice = data[index];
                                      return GestureDetector(
                                        onTap: () => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              InvoiceInformation(
                                                  invoiceIndex: index),
                                        )),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              width: double.infinity,
                                              color: mainProvider.darkTheme
                                                  ? cpDarkContainerColor
                                                  : const Color(0xffF5F5F5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Invoice No.',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: mainProvider
                                                                        .darkTheme
                                                                    ? cpWhiteColor
                                                                    : Colors
                                                                        .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Text(
                                                            invoice.InvoiceID,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: mainProvider
                                                                        .darkTheme
                                                                    ? cpWhiteColor
                                                                    : Colors
                                                                        .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        invoice.InvoiceStatus,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                cpYellowDarkColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  ),
                                                  informationText(
                                                      'Issue Date:',
                                                      jsTimeToDateTime(invoice
                                                          .InvoiceIssueDate)),
                                                  informationText(
                                                      'Due Date:',
                                                      jsTimeToDateTime(invoice
                                                          .InvoiceDueDate)),
                                                  informationText('Total Due:',
                                                      '\$${double.parse(invoice.InvoiceDue).toStringAsFixed(2)}'),
                                                  informationText('Total Paid:',
                                                      "\$${double.parse(invoice.InvoicePaid).toStringAsFixed(2)}"),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Outstanding Balance:',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.red),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        '\$${(double.parse(invoice.InvoiceDue) - double.parse(invoice.InvoicePaid)).toStringAsFixed(2)}',
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.red),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                  StreamBuilder<bool>(
                                      stream: invoiceProvider.isLoading,
                                      builder: (context, snapshot) {
                                        if (snapshot.data == false) {
                                          return const SizedBox();
                                        }
                                        return Center(
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: cpGreyLightColor400),
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              children: const [
                                                CircularProgressIndicator
                                                    .adaptive(),
                                                SizedBox(height: 10),
                                                Text(
                                                  'Loading...',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: cpWhiteColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textBoxField(
      String label, TextEditingController ctrler, bool isNumberOnly) {
    final invoiceProvider =
        Provider.of<InvoiceProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return TextField(
      controller: ctrler,
      keyboardType: isNumberOnly ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        labelText: label,
        suffixIcon: IconButton(onPressed: () {
          EasyDebounce.debounce(
              'search-debouncer',                 // <-- An ID for this particular debouncer
              const Duration(seconds: 2),    // <-- The debounce duration
                  () {
                if (searchCtrler.text.isEmpty) {
                  invoiceProvider.getInvoiceInfo({
                    'customerId': mainProvider.user.CustomerID,
                    'page': page,
                    'server': mainProvider.server,
                    'userId': mainProvider.user.UserID,
                  }, context);
                }
                invoiceProvider.searchInvoice({
                  'customerId': mainProvider.user.CustomerID,
                  'page': page,
                  'search': searchCtrler.text,
                  'server': mainProvider.server,
                  'userId': mainProvider.user.UserID
                }, context);
              }                // <-- The target method
          );
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
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: mainProvider.darkTheme ? cpWhiteColor : Colors.black,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 18,
                color: mainProvider.darkTheme ? cpWhiteColor : Colors.black),
          ),
        ],
      ),
    );
  }

  Widget placeholderAndValue(String placeHolder, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Row(
        children: [
          Text('$placeHolder :'),
          const SizedBox(
            width: 10,
          ),
          Text(value)
        ],
      ),
    );
  }
}
