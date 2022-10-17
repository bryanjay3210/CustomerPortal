import 'package:cp/enum.dart';
import 'package:cp/provider/main_provider.dart';
import 'package:cp/utils/utils/datetime/datetimeUtils.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:cp/view/account/components/invoices/component/paynow.dart';
import 'package:cp/view/account/components/payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/account/credit_card_provider.dart';
import '../../../../../provider/account/invoice_provider.dart';

class InvoiceInformation extends StatefulWidget {
  const InvoiceInformation({Key? key, required this.invoiceIndex})
      : super(key: key);

  final int invoiceIndex;
  @override
  State<InvoiceInformation> createState() => _InvoiceInformationState();
}

class _InvoiceInformationState extends State<InvoiceInformation> {
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
      'userId': mainProvider.user.UserID
    }, context);
    invoiceProvider.getBalance({
      'customerId': mainProvider.user.CustomerID,
      'server': mainProvider.server,
      'userId': mainProvider.user.UserID
    }, context);
    invoiceProvider.getInvoiceDetail({
      'invoiceId': invoiceProvider.invoices[widget.invoiceIndex].InvoiceID,
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
    final data = invoiceProvider.invoices[widget.invoiceIndex];
    return Scaffold(
      body: StreamBuilder<Object>(
          stream: invoiceProvider.invoiceListState,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: const Color(0xff30313A),
                  padding: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  height: 130,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
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
                          'Invoice Information',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: cpWhiteColor),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 250, child: informationText('Customer', invoiceProvider.customer)),
                          Expanded(child: informationText('Invoice Number', data.InvoiceID)),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: informationText('Issue Date',
                                jsTimeToDateTime(data.InvoiceIssueDate)),
                          ),
                          informationText('Due Date',
                              jsTimeToDateTime(data.InvoiceDueDate)),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: informationText('Total Due',
                                '\$${double.parse(data.InvoiceDue).toStringAsFixed(2)}'),
                          ),
                          SizedBox(
                            width: 130,
                            child: informationText('Total Paid',
                                '\$${double.parse(data.InvoicePaid).toStringAsFixed(2)}'),
                          ),
                          Expanded(
                            child: informationText('Outstanding Balance',
                                '\$${(double.parse(data.InvoiceDue) - double.parse(data.InvoicePaid)).toStringAsFixed(2)}'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                    thickness: 2,
                    color: Colors.grey,
                    indent: 20,
                    endIndent: 20),
                headingText('Invoice Detail'),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: StreamBuilder<DataState>(
                        stream: invoiceProvider.invoiceDetailListState,
                        builder: (context, snapshot) {
                          if (snapshot.data == DataState.success &&
                              invoiceProvider.invoiceDetail.isEmpty) {
                            return const Center(
                                child: Text('No invoice detail record'));
                          }
                          if (snapshot.data == DataState.success &&
                              invoiceProvider.invoiceDetail.isNotEmpty) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: invoiceProvider.invoiceDetail.length,
                              itemBuilder: (context, index) {
                                var invoiceDetail =
                                    invoiceProvider.invoiceDetail[index];
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      color: mainProvider.darkTheme
                                          ? cpDarkContainerColor
                                          : const Color(0xffF5F5F5),
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              informationText('Detail No.',
                                                  invoiceDetail.DetailID),
                                              informationText('Item',
                                                  invoiceDetail.DetailItem),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          informationText(
                                              'Description',
                                              invoiceDetail
                                                  .DetailItemDescription),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              informationText('Price',
                                                  '\$${double.parse(invoiceDetail.DetailItemPrice).toStringAsFixed(2)}'),
                                              const Spacer(),
                                              informationText(
                                                  'Quantity',
                                                  invoiceDetail
                                                      .DetailItemQuantity),
                                              const Spacer(),
                                              informationText(
                                                  'Invoice Date',
                                                  jsTimeToDateTime(invoiceDetail
                                                      .DetailItemDate)),
                                            ],
                                          ),
                                        ],
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
                        }),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: buttonContainer(
                      text: 'Send Invoice to Email',
                      onPress: () {
                        invoiceProvider.sendInvoiceToEmail({
                          'invoiceId': data.InvoiceID,
                          'usedId': mainProvider.user.UserID,
                          'server': mainProvider.server
                        }, context);
                      },
                      isGradient: true),
                ),
                Visibility(
                  visible: data.InvoiceStatus == 'Unpaid' ||
                      data.InvoiceStatus == 'Partial',
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: buttonContainer(
                        text: 'Pay Now',
                        onPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PaynowScreen(
                                invoiceIndex: widget.invoiceIndex,
                                currentDue: 0,
                                pastDue: 0,
                                paymentOption: 'PastDue',
                                isFromPayment: false),
                          ));
                        },
                        isGradient: true),
                  ),
                ),
              ],
            );
          }),
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
          style: const TextStyle(fontSize: 18),
        )
      ],
    );
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
