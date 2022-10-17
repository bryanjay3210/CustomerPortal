import 'package:cp/provider/main_provider.dart';
import 'package:cp/shared_widgets/toasts.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/account/invoice_provider.dart';

class BillingAddress extends StatefulWidget {
  const BillingAddress({Key? key}) : super(key: key);

  @override
  State<BillingAddress> createState() => _BillingAddressState();
}

class _BillingAddressState extends State<BillingAddress> {
  final addressNoCtrler = TextEditingController();
  final addressSuffixCtrler = TextEditingController();
  final streetSuffixCtrler = TextEditingController();
  final streetNameCtrler = TextEditingController();
  final cityCtrler = TextEditingController();
  final stateCtrler = TextEditingController();
  final zipCtrler = TextEditingController();
  List<String> streetDirectionItem = [
    "North",
    "North-east",
    "East",
    "South-east",
    "South",
    "South-west",
    "West",
    "North-west",
    ''
  ];
  String streetDirection = '';
  @override
  void initState() {
    final invoiceProvider =
        Provider.of<InvoiceProvider>(context, listen: false);
    addressNoCtrler.text = invoiceProvider.addressNo;
    addressSuffixCtrler.text = invoiceProvider.addressSuffix;
    streetSuffixCtrler.text = invoiceProvider.streetSuffix;
    streetNameCtrler.text = invoiceProvider.streetName;
    cityCtrler.text = invoiceProvider.city;
    stateCtrler.text = invoiceProvider.state;
    zipCtrler.text = invoiceProvider.zip;
    streetDirection = invoiceProvider.streetDirection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceProvider =
        Provider.of<InvoiceProvider>(context, listen: false);
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
                      'Billing Address',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: cpWhiteColor),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textBoxField('* Address No.', addressNoCtrler, true),
                  const SizedBox(
                    height: 10,
                  ),
                  textBoxField('Address Suffix', addressSuffixCtrler, false),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Street Direction',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton<String>(
                      iconSize: 0.0,
                      value: streetDirection,
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
                          streetDirection = newValue!;
                        });
                      },
                      items: streetDirectionItem
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
                  textBoxField('Street Suffix', streetSuffixCtrler, false),
                  const SizedBox(
                    height: 10,
                  ),
                  textBoxField('* Street Name', streetNameCtrler, false),
                  const SizedBox(
                    height: 10,
                  ),
                  textBoxField('* City', cityCtrler, false),
                  const SizedBox(
                    height: 10,
                  ),
                  textBoxField('* State', stateCtrler, false),
                  const SizedBox(
                    height: 10,
                  ),
                  textBoxField('* ZIP', zipCtrler, true),
                  const SizedBox(
                    height: 10,
                  ),
                  buttonContainer(
                      text: 'Update',
                      onPress: () {
                        if (addressNoCtrler.text.isEmpty ||
                            streetNameCtrler.text.isEmpty ||
                            cityCtrler.text.isEmpty ||
                            stateCtrler.text.isEmpty ||
                            zipCtrler.text.isEmpty) {
                          showToast('Please fill out the (*) required fields.');
                        } else {
                          invoiceProvider.updateCustomerInfo({
                            "userId": mainProvider.user.UserID,
                            "gUID": mainProvider.user.GUID,
                            "customerID": mainProvider.user.CustomerID,
                            "locationID": invoiceProvider.locationID,
                            "addressNumber": addressNoCtrler.text,
                            "streetDirection": streetDirection,
                            "streetName": streetNameCtrler.text,
                            "streetSuffix": streetSuffixCtrler.text,
                            "addressSuffix": addressSuffixCtrler.text,
                            "city": cityCtrler.text,
                            "state": stateCtrler.text,
                            "zip": zipCtrler.text,
                            'server': mainProvider.server,
                          }, context);
                          invoiceProvider.getCustomer({
                            'customerId': mainProvider.user.CustomerID,
                            'userId': mainProvider.user.UserID,
                            'server': mainProvider.server,
                          }, context);
                        }
                      },
                      isGradient: true),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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

  Widget textBoxField(
      String label, TextEditingController ctrler, bool isNumberOnly) {
    return TextField(
      controller: ctrler,
      keyboardType: isNumberOnly ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          labelText: label),
    );
  }
}
