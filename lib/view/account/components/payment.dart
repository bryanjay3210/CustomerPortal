import 'package:cp/enum.dart';
import 'package:cp/main.dart';
import 'package:cp/model/invoice/invoice.dart';
import 'package:cp/provider/main_provider.dart';
import 'package:cp/utils/utils/datetime/datetimeUtils.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../provider/account/credit_card_provider.dart';
import '../../../provider/account/invoice_provider.dart';
import 'invoices/component/paynow.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<Invoices> invoice = [];
  late int invoiceIndex;
  final oCcy = NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    final invoiceProvider =
        Provider.of<InvoiceProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final ccProvider = Provider.of<CreditCardProvider>(context, listen: false);
    invoiceProvider.getCustomer({
      'customerId': mainProvider.user.CustomerID,
      'userId': mainProvider.user.UserID,
      'server': mainProvider.server,
    }, context);
    invoiceProvider.invoices = [];
    invoiceProvider.getInvoiceInfo({
      'customerId': mainProvider.user.CustomerID,
      'page': 1,
      'server': mainProvider.server,
      'userId': mainProvider.user.UserID,
    }, context);
    invoiceProvider.getBalance({
      'customerId': mainProvider.user.CustomerID,
      'server': mainProvider.server,
      'userId': mainProvider.user.UserID
    }, context);
    ccProvider.getCreditCardInfo(
        {'userId': mainProvider.user.UserID, 'server': mainProvider.server},
        context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceProvider =
        Provider.of<InvoiceProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: const Color(0xff30313A),
        body: SingleChildScrollView(
          child: Column(
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
                        'Payment',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: cpWhiteColor),
                      )
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
                child: Container(
                  color: mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child: Container(
                            color: mainProvider.darkTheme
                                ? cpDarkContainerColor
                                : const Color(0xffF5F5F5),
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: StreamBuilder<DataState>(
                                  stream: invoiceProvider.customerState,
                                  builder: (context, snapshot) {
                                    // if(snapshot.data == DataState.loading){
                                    //   return const Center(child: CircularProgressIndicator.adaptive(),);
                                    // }
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Account',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22)),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        headingText('Billing Address'),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: informationText(
                                                  'Address No.',
                                                  invoiceProvider.addressNo,
                                                  false),
                                            )),
                                            Expanded(
                                                child: Container(
                                              child: informationText(
                                                  'Street Name',
                                                  invoiceProvider.streetName,
                                                  false),
                                            )),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: informationText(
                                                  'Street Direction',
                                                  invoiceProvider
                                                      .streetDirection,
                                                  false),
                                            )),
                                            Expanded(
                                                child: Container(
                                              child: informationText(
                                                  'Street Suffix',
                                                  invoiceProvider.streetSuffix,
                                                  false),
                                            )),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: informationText(
                                                  'Address Suffix',
                                                  invoiceProvider.addressSuffix,
                                                  false),
                                            )),
                                            Expanded(
                                                child: Container(
                                              child: informationText('City',
                                                  invoiceProvider.city, false),
                                            )),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: informationText('State',
                                                  invoiceProvider.state, false),
                                            )),
                                            Expanded(
                                                child: Container(
                                              child: informationText('ZIP',
                                                  invoiceProvider.zip, false),
                                            )),
                                          ],
                                        ),
                                        headingText('Service Address'),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: informationText(
                                                  'Address No.',
                                                  invoiceProvider
                                                      .addressNoService,
                                                  false),
                                            )),
                                            Expanded(
                                                child: Container(
                                              child: informationText(
                                                  'Street Name',
                                                  invoiceProvider
                                                      .streetNameService,
                                                  false),
                                            )),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: informationText(
                                                  'Street Direction',
                                                  invoiceProvider
                                                      .streetDirectionService,
                                                  false),
                                            )),
                                            Expanded(
                                                child: Container(
                                              child: informationText(
                                                  'Street Suffix',
                                                  invoiceProvider
                                                      .streetSuffixService,
                                                  false),
                                            )),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: informationText(
                                                  'Address Suffix',
                                                  invoiceProvider
                                                      .addressSuffixService,
                                                  false),
                                            )),
                                            Expanded(
                                                child: Container(
                                              child: informationText(
                                                  'City',
                                                  invoiceProvider.cityService,
                                                  false),
                                            )),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: informationText(
                                                  'State',
                                                  invoiceProvider.stateService,
                                                  false),
                                            )),
                                            Expanded(
                                                child: Container(
                                              child: informationText(
                                                  'ZIP',
                                                  invoiceProvider.zipService,
                                                  false),
                                            )),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        buttonContainer(
                                            text: 'Update Billing',
                                            onPress: () {
                                              Navigator.pushNamed(
                                                  context, 'billing_address');
                                            },
                                            isGradient: true)
                                      ],
                                    );
                                  }),
                            ),
                          ),
                        ),
                      ),
                      StreamBuilder<DataState>(
                          stream: invoiceProvider.invoiceListState,
                          builder: (context, snapshot) {
                            try {
                              var _invoice = invoiceProvider.invoices;
                              _invoice.sort((a, b) =>
                                  b.InvoiceDueDate.compareTo(a.InvoiceDueDate));
                              _invoice
                                  .where((element) =>
                                      element.InvoiceStatus != 'Paid' &&
                                      element.InvoiceStatus != 'Void')
                                  .forEach((element) {
                                invoice.add(element);
                              });
                              invoice.sort(
                                (a, b) => b.InvoiceDueDate.compareTo(
                                    a.InvoiceDueDate),
                              );
                              invoiceIndex = invoiceProvider.invoices
                                  .indexWhere((element) =>
                                      element.InvoiceID ==
                                      invoice.last.InvoiceID);
                              invoiceProvider.getInvoiceDetail({
                                'invoiceId': invoiceProvider
                                    .invoices[invoiceIndex].InvoiceID,
                                'server': mainProvider.server,
                                'userId': mainProvider.user.UserID
                              }, context);
                            } catch (e) {}
                            if (snapshot.data == DataState.success &&
                                invoice.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      child: Container(
                                        color: mainProvider.darkTheme
                                            ? cpDarkContainerColor
                                            : const Color(0xffF5F5F5),
                                        width: double.infinity,
                                        height: 80,
                                        child: const Center(
                                            child: Text(
                                                'No pending payment due.')),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            if (snapshot.data == DataState.success &&
                                invoice.isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      child: Container(
                                        width: double.infinity,
                                        color: mainProvider.darkTheme
                                            ? cpDarkContainerColor
                                            : const Color(0xffF5F5F5),
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    informationText(
                                                        'Current Due:',
                                                        "\$${oCcy.format(invoiceProvider.currentBalanceDue)}",
                                                        false),
                                                    const SizedBox(
                                                      width: 75,
                                                    ),
                                                    informationText(
                                                        'Balance',
                                                        '\$${oCcy.format(invoiceProvider.pastDueBalance)}',
                                                        true),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    informationText(
                                                        'Due on:',
                                                        jsTimeToDateTime(
                                                            invoice[0]
                                                                .InvoiceDueDate),
                                                        false),
                                                    const SizedBox(
                                                      width: 90,
                                                    ),
                                                    informationText(
                                                        'Total Due',
                                                        "\$${oCcy.format((invoiceProvider.currentBalanceDue + invoiceProvider.pastDueBalance))}",
                                                        false),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            buttonContainer(
                                                text: 'Pay Now',
                                                onPress: () {
                                                  _showNewPaymentDialog();
                                                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaynowScreen(invoiceIndex: invoiceIndex,),));
                                                },
                                                isGradient: true),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      child: Container(
                                        width: double.infinity,
                                        color: mainProvider.darkTheme
                                            ? cpDarkContainerColor
                                            : const Color(0xffF5F5F5),
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                informationText(
                                                    'Monthly Amount Due',
                                                    '\$${invoiceProvider.invoiceSubTot.toStringAsFixed(2)}',
                                                    false),
                                              ],
                                            ),
                                            headingText('Products'),
                                            StreamBuilder<DataState>(
                                                stream: invoiceProvider
                                                    .invoiceDetailListState,
                                                builder: (context, snapshot) {
                                                  if (snapshot.data ==
                                                          DataState.success &&
                                                      invoiceProvider
                                                          .invoiceDetail
                                                          .isNotEmpty) {
                                                    var invoiceDetail =
                                                        invoiceProvider
                                                            .invoiceDetail
                                                            .toSet()
                                                            .toList();
                                                    return SizedBox(
                                                      width: double.infinity,
                                                      height: 150,
                                                      child: ListView.builder(
                                                        itemCount: invoiceDetail
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return ListTile(
                                                            leading: Text(
                                                                '${index + 1}. ',
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15)),
                                                            title: Text(
                                                                invoiceDetail[
                                                                        index]
                                                                    .DetailItem,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15)),
                                                            trailing: Text(
                                                                '\$${double.parse(invoiceDetail[index].DetailItemPrice).toStringAsFixed(2)}',
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15)),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  }
                                                  return const SizedBox();
                                                })
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Future<void> _showNewPaymentDialog() async {
    final invoiceProvider =
        Provider.of<InvoiceProvider>(context, listen: false);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        String paymentOption = '';
        return AlertDialog(
          title: const Text('New Payment'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const Text('Select payment option:',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Visibility(
                      visible: invoiceProvider.currentBalanceDue != 0,
                      child: ListTile(
                        trailing: Text(
                            "\$${oCcy.format(invoiceProvider.currentBalanceDue)}"),
                        title: const Text('Pay current due only'),
                        leading: Radio(
                          value: 'CurrentDue',
                          groupValue: paymentOption,
                          onChanged: (value) {
                            setState(() {
                              paymentOption = value.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: invoiceProvider.pastDueBalance != 0,
                      child: Column(
                        children: [
                          ListTile(
                            trailing: Text(
                                "\$${oCcy.format(invoiceProvider.pastDueBalance.abs())}",
                                style: TextStyle(
                                    color: getColor(
                                        true,
                                        invoiceProvider.pastDueBalance
                                            .toString()))),
                            title: const Text('Balance'),
                            leading: Radio(
                              value: 'PastDue',
                              groupValue: paymentOption,
                              onChanged: (value) {
                                setState(() {
                                  paymentOption = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: invoiceProvider.currentBalanceDue != 0 &&
                          invoiceProvider.pastDueBalance != 0,
                      child: ListTile(
                        trailing: Text(
                            "\$${oCcy.format(invoiceProvider.currentBalanceDue + invoiceProvider.pastDueBalance)}"),
                        title: const Text('Pay full amount due'),
                        leading: Radio(
                          value: 'FullAmount',
                          groupValue: paymentOption,
                          onChanged: (value) {
                            setState(() {
                              paymentOption = value.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    const Text('Payment option is required',
                        style: TextStyle(color: Colors.red)),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Proceed to payment'),
              style: TextButton.styleFrom(backgroundColor: cpPrimaryColor),
              onPressed: () {
                if (paymentOption != '') {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PaynowScreen(
                        invoiceIndex: invoiceIndex,
                        isFromPayment: true,
                        paymentOption: paymentOption,
                        currentDue: invoiceProvider.currentBalanceDue,
                        pastDue: invoiceProvider.pastDueBalance),
                  ));
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget headingText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget informationText(String title, String value, bool isPastDue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          isPastDue
              ? '\$${oCcy.format(double.parse(value.replaceAll('\$', '').replaceAll(',', '')).abs())}'
              : value,
          style: TextStyle(fontSize: 15, color: getColor(isPastDue, value)),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Color getColor(bool isPastDue, String value) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    if (isPastDue) {
      var val = double.parse(value.replaceAll('\$', '').replaceAll(',', ''));
      if (val > 0) {
        return Colors.red;
      }
      if (val < 0) {
        return Colors.green;
      }
    }
    return mainProvider.darkTheme ? Colors.white : Colors.black;
  }

  Widget buttonContainer(
      {required String text,
      required Function() onPress,
      required bool isGradient}) {
    if (!isGradient) {
      return GestureDetector(
        onTap: onPress,
        child: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xffE1E1E1),
          child: Center(
            child: Text(text, style: const TextStyle(color: Colors.black)),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFFFFC72E), Color(0xFFF87D1F)])),
        child: Center(
          child: Text(text, style: const TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}
