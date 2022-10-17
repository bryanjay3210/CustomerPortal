import 'package:cp/enum.dart';
import 'package:cp/provider/main_provider.dart';
import 'package:cp/shared_widgets/shared_dialog.dart';
import 'package:cp/shared_widgets/toasts.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../provider/account/credit_card_provider.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({Key? key}) : super(key: key);

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  final cardHolderNameCtrler = TextEditingController();
  final cardNumberCtrler = TextEditingController();
  final expireMonthPhoneCtrler = TextEditingController();
  final expireYearCtrler = TextEditingController();
  final cVVCtrler = TextEditingController();
  bool isChecked = false;
  bool isAutoBill = false;
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
  List<String> expireYearItem = [];
  String cardType = 'VISA';
  String expireMonth = DateTime.now().month.toString().length == 1
      ? '0${DateTime.now().month}'
      : DateTime.now().month.toString();
  String expireYear = DateTime.now().year.toString();
  @override
  void initState() {
    final ccProvider = Provider.of<CreditCardProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    var currentYear = DateTime.now().year;
    expireYearItem.add(currentYear.toString());
    for (int i = 1; i <= 10; i++) {
      var newYear = DateTime.now().add(Duration(days: 365 * i)).year;
      expireYearItem.add(newYear.toString());
    }
    ccProvider.getCreditCardInfo(
        {'userId': mainProvider.user.UserID, 'server': mainProvider.server},
        context);
    // Future.delayed(const Duration(seconds: 2), () {
    //   setState(() {
    //     isChecked = ccProvider.creditCard[0].CardAutobill == 'Y' ? true : false;
    //   });
    // },);
    super.initState();
  }

  @override
  void dispose() {
    cardHolderNameCtrler.dispose();
    cardNumberCtrler.dispose();
    expireMonthPhoneCtrler.dispose();
    expireYearCtrler.dispose();
    cVVCtrler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ccProvider = Provider.of<CreditCardProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
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
                      'Credit Card',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: cpWhiteColor),
                    )
                  ],
                ),
              ),
            ),
            StreamBuilder<DataState>(
                stream: ccProvider.creditCardListState,
                builder: (context, snapshot) {
                  if (snapshot.data == DataState.success &&
                      ccProvider.creditCard[0].CardNum.toString() !=
                          'XXXXXXXXXX') {
                    var data = ccProvider.creditCard[0];
                    isChecked = data.CardAutobill == 'Y' ? true : false;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          color: mainProvider.darkTheme
                              ? cpDarkContainerColor
                              : const Color(0xffF5F5F5),
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Saved Credit Card',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              informationText(
                                  'Card Holder Name', data.CardholderName),
                              informationText('Card Type', data.CardType),
                              informationText('Card Number', data.CardNum),
                              const Text(
                                'Expiration Date',
                                style:
                                    TextStyle(fontSize: 13, color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  informationText('Month', data.CardExpMonth),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  informationText('Year', data.CardExpYear),
                                ],
                              ),
                              informationText(
                                  'CVV',
                                  cardType == 'American Express'
                                      ? 'XXXX'
                                      : 'XXX'),
                              StreamBuilder<bool>(
                                initialData: isChecked,
                                stream: ccProvider.isAutoBill,
                                builder: (context, snapshot) {
                                  return CheckboxListTile(
                                    title: const Text('Use card for future changes?'),
                                    value: snapshot.data,
                                    onChanged: (value){
                                      isChecked = value!;
                                      ccProvider.isAutoBill.add(isChecked);
                                      ccProvider.futureChargeUpdate({
                                        'customerId': mainProvider.user.CustomerID,
                                        'cardAutobill': isChecked,
                                        'loggedIn': mainProvider.user.CustomerID,
                                        'userId': mainProvider.user.UserID,
                                        'server': mainProvider.server,
                                      }, context);
                                    },
                                    controlAffinity: ListTileControlAffinity.leading,
                                  );
                              },),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () async{
                                  if(await showConfirmDialog(context, 'Are you sure you want to delete this Credit Card?')){
                                    ccProvider.deleteCard({
                                      'customerId': mainProvider.user.CustomerID,
                                      'cardNumber': data.CardNum,
                                      'server': mainProvider.server,
                                      'userId': mainProvider.user.UserID,
                                    }, context).then((_) {
                                      ccProvider.getCreditCardInfo({
                                        'userId': mainProvider.user.UserID,
                                        'server': mainProvider.server
                                      }, context);
                                    });
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  color: Colors.red,
                                  child: const Center(
                                    child: Text('Delete Saved Credit Card',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: StreamBuilder<DataState>(
                  stream: ccProvider.creditCardListState,
                  builder: (context, snapshot) {
                    if (snapshot.data == DataState.success) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          color: mainProvider.darkTheme
                              ? cpDarkContainerColor
                              : const Color(0xffF5F5F5),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Credit Card Form',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              textBoxField('* Card Holder Name',
                                  cardHolderNameCtrler, false, false, false),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text('* Card Type',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13)),
                              SizedBox(
                                width: double.infinity,
                                child: DropdownButton<String>(
                                  iconSize: 0,
                                  value: cardType,
                                  elevation: 18,
                                  style: TextStyle(
                                      color: mainProvider.darkTheme
                                          ? Colors.white
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
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
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
                              textBoxField('* Card Number', cardNumberCtrler,
                                  true, false, true),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                '* Expiration Date',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13),
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
                                                ? Colors.white
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
                                                ? Colors.white
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
                              textBoxField(
                                  '* CVV', cVVCtrler, true, true, false),
                              const SizedBox(
                                height: 10,
                              ),
                              // Row(
                              //   children: [
                              //     Checkbox(
                              //       value: isChecked,
                              //       onChanged: (bool? newValue) {
                              //         setState(() {
                              //           isChecked = newValue!;
                              //         });},
                              //     ),
                              //     const SizedBox(width: 5,),
                              //     const Text('Use card for future changes?'),
                              //   ],
                              // ),
                              // const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Checkbox(
                                    value: isAutoBill,
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        isAutoBill = newValue!;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                      'Use card for monthly auto billing?'),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (ccProvider.isCardValid) {
                                    var newExpireYear =
                                        expireYear.toString().substring(2, 4);
                                    if (cardHolderNameCtrler.text.isEmpty ||
                                        cardNumberCtrler.text.isEmpty ||
                                        expireMonth.isEmpty ||
                                        newExpireYear.isEmpty ||
                                        cVVCtrler.text.isEmpty) {
                                      showToast(
                                          'Please provide the (*) required fields.');
                                    } else {
                                      var cardInfo = {
                                        "cardholderName":
                                            cardHolderNameCtrler.text,
                                        "cardType": cardType,
                                        "cardNumber": cardNumberCtrler.text,
                                        "cardCVV": cVVCtrler.text,
                                        "cardExpMonth": expireMonth,
                                        "cardExpYear": newExpireYear,
                                        "userId": mainProvider.user.UserID,
                                        "cardAutobill": isAutoBill ? 'Y' : 'N',
                                      };
                                      updateCard(cardInfo);
                                      clearField();
                                    }
                                  } else {
                                    showToast('Invalid Card Number!');
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                        Color(0xFFFFC72E),
                                        Color(0xFFF87D1F)
                                      ])),
                                  child: const Center(
                                    child: Text('Update Credit Card',
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void updateCard(Map<String, dynamic> map) {
    final ccProvider = Provider.of<CreditCardProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    ccProvider.updateCreditCard({
      "cardholderName": map['cardholderName'],
      "cardType": map['cardType'],
      "cardNumber": map['cardNumber'],
      "cardCVV": map['cardCVV'],
      "cardExpMonth": map['cardExpMonth'],
      "cardExpYear": map['cardExpYear'],
      "userId": mainProvider.user.UserID,
      "cardAutobill": map['cardAutobill'],
      'server': mainProvider.server,
    }, context).then((_) {
      ccProvider.getCreditCardInfo(
          {'userId': mainProvider.user.UserID, 'server': mainProvider.server},
          context);
    });
  }

  void clearField() {
    cardType = 'VISA';
    expireMonth = '01';
    expireYear = DateTime.now().year.toString();
    cardHolderNameCtrler.clear();
    cardNumberCtrler.clear();
    cVVCtrler.clear();
    isChecked = false;
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
        ),
        const SizedBox(
          height: 10,
        ),
      ],
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
        labelStyle:
            TextStyle(color: ctrler.text.isEmpty ? Colors.red : Colors.grey),
      ),
      maxLength: isCVV ? (cardType == 'American Express' ? 4 : 3) : null,
      inputFormatters: [
        if (isCardNumber) FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
    );
  }
}
