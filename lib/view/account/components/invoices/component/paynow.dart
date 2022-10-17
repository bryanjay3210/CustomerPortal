import 'package:cp/enum.dart';
import 'package:cp/provider/main_provider.dart';
import 'package:cp/shared_widgets/toasts.dart';
import 'package:cp/utils/utils/datetime/datetimeUtils.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/account/credit_card_provider.dart';
import '../../../../../provider/account/invoice_provider.dart';
import '../../../../../provider/account/payment_provider.dart';

class PaynowScreen extends StatefulWidget {
  const PaynowScreen({
    Key? key,
    required this.invoiceIndex,
    required this.paymentOption,
    required this.currentDue,
    required this.pastDue,
    required this.isFromPayment,
  }) : super(key: key);
  final int invoiceIndex;
  final String paymentOption;
  final double currentDue;
  final double pastDue;
  final bool isFromPayment;

  @override
  State<PaynowScreen> createState() => _PaynowScreenState();
}

class _PaynowScreenState extends State<PaynowScreen> {
  final cardHolderNameCtrler = TextEditingController();
  final cardNumberCtrler = TextEditingController();
  final expireMonthPhoneCtrler = TextEditingController();
  final expireYearCtrler = TextEditingController();
  final cVVCtrler = TextEditingController();
  final paymentAmountCtrler = TextEditingController();
  String expireMonthAndYear = '';
  bool useCCOnFile = false;
  bool isStoredCard = false;
  bool isCardAutoBilling = false;
  List<String> cardTypeItem = [
    'VISA',
    'Mastercard',
    'American Express',
    'Discover'
  ];
  List<String> expireMonthItem = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
  ];
  final oCcy = NumberFormat("#,##0.00", "en_US");
  List<String> expireYearItem = [];
  String cardType = 'VISA';
  String expireMonth = DateTime.now().month.toString().length == 1
      ? '0${DateTime.now().month}'
      : DateTime.now().month.toString();
  String expireYear = DateTime.now().year.toString();
  @override
  void initState() {
    final invoiceProvider =
        Provider.of<InvoiceProvider>(context, listen: false);
    var currentYear = DateTime.now().year;
    expireYearItem.add(currentYear.toString());
    for (int i = 1; i <= 10; i++) {
      var newYear = DateTime.now().add(Duration(days: 365 * i)).year;
      expireYearItem.add(newYear.toString());
    }
    double toBePay = double.parse(
            invoiceProvider.invoices[widget.invoiceIndex].InvoiceDue) -
        double.parse(invoiceProvider.invoices[widget.invoiceIndex].InvoicePaid);
    if (widget.isFromPayment) {
      switch (widget.paymentOption) {
        case 'CurrentDue':
          paymentAmountCtrler.text =
              '\$${widget.currentDue.toStringAsFixed(2)}';
          break;
        case 'PastDue':
          paymentAmountCtrler.text = '\$${widget.pastDue.toStringAsFixed(2)}';
          break;
        case 'FullAmount':
          paymentAmountCtrler.text =
              '\$${(widget.currentDue + widget.pastDue).toStringAsFixed(2)}';
          break;
      }
    } else {
      paymentAmountCtrler.text = '\$${toBePay.toStringAsFixed(2)}';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceProvider =
        Provider.of<InvoiceProvider>(context, listen: false);
    final ccProvider = Provider.of<CreditCardProvider>(context, listen: false);
    final paymentProvider =
        Provider.of<PaymentProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    invoiceProvider.invoices
        .sort((a, b) => b.InvoiceIssueDate.compareTo(a.InvoiceIssueDate));
    final data = widget.isFromPayment
        ? widget.paymentOption == 'CurrentDue'
            ? invoiceProvider.invoices[0]
            : invoiceProvider.invoices[1]
        : invoiceProvider.invoices[widget.invoiceIndex];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      'New Payment',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: cpWhiteColor),
                    )
                  ],
                ),
              ),
            ),
            StatefulBuilder(
              builder: (context, setState) {
                if (widget.isFromPayment) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 250,
                              child: informationText(
                                  'Customer', invoiceProvider.customer),
                            ),
                            Expanded(child: informationText('Invoice Number', data.InvoiceID)),
                          ],
                        ),
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
                        Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child: informationText('Current Due',
                                  '\$${oCcy.format(widget.currentDue)}'),
                            ),
                            SizedBox(
                              width: 130,
                              child: informationText(
                                  double.parse(widget.pastDue.toString()) < 0
                                      ? 'Credit Balance'
                                      : 'Past Due',
                                  '\$${oCcy.format(widget.pastDue)}'),
                            ),
                            Expanded(
                              child: informationText('Total Due',
                                  '\$${(oCcy.format(widget.currentDue + widget.pastDue))}'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 250, child: informationText('Customer', invoiceProvider.customer)),
                          Expanded(child: informationText('Invoice Number', data.InvoiceID)),
                        ],
                      ),
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
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: textBoxField(
                  'Payment Amount (${widget.isFromPayment ? widget.paymentOption : 'Current Due'})',
                  paymentAmountCtrler,
                  true,
                  false,
                  false),
            ),
            headingText('Payment Details'),
            Visibility(
              visible: ccProvider.creditCard.isNotEmpty &&
                  ccProvider.creditCard[0].CardNum != 'XXXXXXXXXX',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: informationText(
                        'Stored Card', ccProvider.creditCard[0].CardNum),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: useCCOnFile,
                        onChanged: (bool? newValue) {
                          setState(() {
                            useCCOnFile = newValue!;
                            isUsedCCOnFile(useCCOnFile);
                          });
                        },
                      ),
                      const Text('Use credit card on file?'),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !useCCOnFile,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headingText('Credit Card Form'),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textBoxField('* Card Holder Name', cardHolderNameCtrler,
                            false, false, false),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text('* Card Type',
                            style: TextStyle(color: Colors.grey, fontSize: 13)),
                        SizedBox(
                          width: double.infinity,
                          child: DropdownButton<String>(
                            iconSize: 0.0,
                            value: cardType,
                            elevation: 18,
                            style: TextStyle(
                                color: mainProvider.darkTheme
                                    ? cpWhiteColor
                                    : Colors.black),
                            underline: Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                cardType = newValue!;
                              });
                            },
                            items: cardTypeItem
                                .toSet()
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        textBoxField('* Card Number', cardNumberCtrler, true,
                            false, true),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          '* Expiration Date',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                const Text('Month'),
                                const SizedBox(
                                  height: 5,
                                ),
                                DropdownButton<String>(
                                  value: expireMonth,
                                  elevation: 16,
                                  style: TextStyle(
                                      color: mainProvider.darkTheme
                                          ? cpWhiteColor
                                          : Colors.black),
                                  underline: Container(
                                    width: double.infinity,
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      expireMonth = newValue!;
                                    });
                                  },
                                  items: expireMonthItem
                                      .toSet()
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                const Text('Year'),
                                const SizedBox(
                                  height: 5,
                                ),
                                DropdownButton<String>(
                                  value: expireYear,
                                  elevation: 16,
                                  style: TextStyle(
                                      color: mainProvider.darkTheme
                                          ? cpWhiteColor
                                          : Colors.black),
                                  underline: Container(
                                    width: double.infinity,
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      expireYear = newValue!;
                                    });
                                  },
                                  items: expireYearItem
                                      .toSet()
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        textBoxField('* CVV', cVVCtrler, true, true, false),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isStoredCard,
                        onChanged: (bool? newValue) {
                          setState(() {
                            isStoredCard = newValue!;
                          });
                        },
                      ),
                      Text(ccProvider.creditCard[0].CardNum == 'XXXXXXXXXX'
                          ? 'Store credit card?'
                          : 'Update stored credit card?'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isCardAutoBilling,
                        onChanged: (bool? newValue) {
                          setState(() {
                            isCardAutoBilling = newValue!;
                          });
                        },
                      ),
                      const Text('Use card for monthly auto billing?'),
                    ],
                  ),
                ],
              ),
            ),
            StreamBuilder<DataState>(
              stream: paymentProvider.paymentListState,
              builder: (context, snapshot) {
                if (snapshot.data == DataState.loading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                return buttonContainer(
                    text: 'Pay',
                    onPress: () {
                      if (useCCOnFile) {
                        if (cardHolderNameCtrler.text.isEmpty ||
                            cardNumberCtrler.text.isEmpty ||
                            cVVCtrler.text.isEmpty) {
                          showToast('Please provide the (*) required fields.');
                        } else {
                          expireMonthAndYear =
                              expireMonth + expireYear.substring(2);
                          var paymentInfo = {
                            "paymentOption": widget.isFromPayment
                                ? widget.paymentOption
                                : 'CurrentDue',
                            "customerID": mainProvider.user.CustomerID,
                            "userId": mainProvider.user.UserID,
                            "auth": mainProvider.user.GUID,
                            "invoiceID": data.InvoiceID,
                            "paymentAmount": paymentAmountCtrler.text
                                .replaceAll('\$', '')
                                .toString()
                                .trim(),
                            "useStoredCard": useCCOnFile ? 'Y' : 'N',
                            "cardholderName": cardHolderNameCtrler.text,
                            "cardNumber":
                                useCCOnFile ? '' : cardNumberCtrler.text,
                            "cardType": cardType,
                            "cardExpDate": expireMonthAndYear,
                            "cVV": cVVCtrler.text,
                            "storeCard": isStoredCard ? 'Y' : 'N',
                            "cardAutobill": isCardAutoBilling ? 'Y' : 'N',
                            'server': mainProvider.server,
                            'userId': mainProvider.user.UserID,
                          };
                          paymentProvider.makePayment(paymentInfo, context);
                        }
                      } else {
                        if (ccProvider.isCardValid) {
                          if (cardHolderNameCtrler.text.isEmpty ||
                              cardNumberCtrler.text.isEmpty ||
                              cVVCtrler.text.isEmpty) {
                            showToast(
                                'Please provide the (*) required fields.');
                          } else {
                            expireMonthAndYear =
                                expireMonth + expireYear.substring(2);
                            var paymentInfo = {
                              "paymentOption": widget.isFromPayment
                                  ? widget.paymentOption
                                  : 'CurrentDue',
                              "customerID": mainProvider.user.CustomerID,
                              "userId": mainProvider.user.UserID,
                              "auth": mainProvider.user.GUID,
                              "invoiceID": data.InvoiceID,
                              "paymentAmount": paymentAmountCtrler.text
                                  .replaceAll('\$', '')
                                  .toString()
                                  .trim(),
                              "useStoredCard": useCCOnFile ? 'Y' : 'N',
                              "cardholderName": cardHolderNameCtrler.text,
                              "cardNumber":
                                  useCCOnFile ? '' : cardNumberCtrler.text,
                              "cardType": cardType,
                              "cardExpDate": expireMonthAndYear,
                              "cVV": cVVCtrler.text,
                              "storeCard": isStoredCard ? 'Y' : 'N',
                              "cardAutobill": isCardAutoBilling ? 'Y' : 'N',
                              'server': mainProvider.server,
                              'userId': mainProvider.user.UserID,
                            };
                            paymentProvider.makePayment(paymentInfo, context);
                          }
                        } else {
                          showToast('Invalid Card Number!');
                        }
                      }
                    },
                    isGradient: true);
              },
            )
          ],
        ),
      ),
    );
  }

  void isUsedCCOnFile(bool isUsed) {
    final ccProvider = Provider.of<CreditCardProvider>(context, listen: false);
    var data = ccProvider.creditCard[0];
    if (data.CardNum == 'XXXXXXXXXX' && isUsed) {
      cardHolderNameCtrler.clear();
      cardNumberCtrler.clear();
      cardType = 'VISA';
      expireMonth = '01';
      expireYear = '2022';
      expireMonthAndYear =
          expireMonth + DateTime.now().year.toString().substring(2);
      cVVCtrler.clear();
    } else if (data.CardNum != 'XXXXXXXXXX' && isUsed) {
      cardHolderNameCtrler.text = data.CardholderName;
      cardNumberCtrler.text = data.CardNum;
      cardType = data.CardType;
      expireMonth = data.CardExpMonth;
      expireYear = '20' + data.CardExpYear;
      expireMonthAndYear = expireMonth + expireYear.substring(2);
      cVVCtrler.text = data.CardCVV;
    } else {
      cardHolderNameCtrler.clear();
      cardNumberCtrler.clear();
      cardType = 'VISA';
      expireMonth = '01';
      expireYear = '2022';
      expireMonthAndYear =
          expireMonth + DateTime.now().year.toString().substring(2);
      cVVCtrler.clear();
    }
  }

  Widget buttonContainer(
      {required String text,
      required Function() onPress,
      required bool isGradient}) {
    if (!isGradient) {
      return GestureDetector(
        onTap: onPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Container(
            height: 50,
            width: double.infinity,
            color: const Color(0xffE1E1E1),
            child: Center(
              child: Text(text, style: const TextStyle(color: Colors.black)),
            ),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
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
      ),
    );
  }

  Widget textBoxField(String label, TextEditingController ctrler,
      bool isNumberOnly, bool isCVV, bool isCardNumber) {
    return TextField(
      controller: ctrler,
      onChanged: (value) {
        if (isCardNumber) {
          final ccProvider =
              Provider.of<CreditCardProvider>(context, listen: false);
          final mainProvider =
              Provider.of<MainProvider>(context, listen: false);
          ccProvider.validateCard({
            'cardNumber': value.toString(),
            'userId': mainProvider.user.UserID,
            'server': mainProvider.server
          }, context);
        }
        setState(() {});
      },
      keyboardType: isNumberOnly ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        labelText: label,
        labelStyle: TextStyle(
            color: label.contains('Payment Amount') ||
                    label.contains('Current Due') ||
                    ctrler.text.isNotEmpty
                ? Colors.grey
                : Colors.red),
      ),
      maxLength: isCVV ? (cardType == 'American Express' ? 4 : 3) : null,
      inputFormatters: [
        if (isCardNumber) FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
    );
  }
}
