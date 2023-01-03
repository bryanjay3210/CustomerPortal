import 'package:cp/provider/account/message_manager/message_group.dart';
import 'package:cp/provider/account/message_provider.dart';
import 'package:cp/provider/main_provider.dart';
import 'package:cp/shared_widgets/shared_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../enum.dart';
import '../../../model/unit/unit.dart';
import '../../../provider/manager/customer_provider.dart';
import '../../../shared_widgets/shared_dialog.dart';
import '../../../shared_widgets/toasts.dart';
import '../../shared_widgets/common_widgets.dart';
import 'dart:developer' as dev;

class CustomerDetailsPage extends StatefulWidget {
  const CustomerDetailsPage({Key? key}) : super(key: key);

  @override
  State<CustomerDetailsPage> createState() => _CustomerDetailsPageState();
}

class _CustomerDetailsPageState extends State<CustomerDetailsPage> {
  final firstNameCtrler = TextEditingController();
  final lastNameCtrler = TextEditingController();
  final emailCtrler = TextEditingController();
  final contactPhoneCtrler = TextEditingController();
  final pinCtrler = TextEditingController();
  final passwordCtrler = TextEditingController();
  final confirmPasswordCtrler = TextEditingController();
  var isCreate = false;
  var willPop = true;
  var isAvailableInCustomers = true;
  final bedList = ['A', 'B', 'C', 'D', 'E'];

  @override
  void initState() {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final customer = customerProvider.selectedCustomer;
    if (customer.UnitID == '' || customer.UserID == '') {
      isCreate = true;
      customerProvider.getCustomerInfo({
        'server': mainProvider.server,
        'customerId': customerProvider.allCustomers[0].CustomerID,
        'userId': customerProvider.allCustomers[0].UserID,
        'buildingId': mainProvider.user.BuildingID
      }, context, true);
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isCreate = false;

      customerProvider.canWifiUser(
          {'userId': mainProvider.user.UserID, 'server': mainProvider.server},
          context);
      customerProvider.getCustomerInfo({
        'server': mainProvider.server,
        'customerId': customer.CustomerID,
        'userId': customer.UserID,
        'buildingId': mainProvider.user.BuildingID
      }, context, false);

// customerProvider.selectedBed = customer.
      firstNameCtrler.text = customer.UserFname;
      lastNameCtrler.text = customer.UserLname;
    });

    super.initState();
  }

  isValidPassword() {
    final _ = passwordCtrler.text;
    return _.contains(RegExp(r'[A-Z]')) ||
        _.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ||
        _.length > 8;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messageGroupProvider =
        Provider.of<MessageGroupProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final isDarkMode = mainProvider.isDarkMode;
    final initialCustomerData = customerProvider.selectedCustomer;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return willPop;
        },
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: popUpPageAppBar(
                isCreate ? 'Create Customer' : 'Update Customer',
                widget: [
                  StreamBuilder<bool>(
                      stream: customerProvider.canWifiUser$,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const SizedBox();
                        } else if (snapshot.data == false) {
                          return const SizedBox();
                        }
                        return IconButton(
                          icon: const Icon(Icons.perm_scan_wifi),
                          onPressed: () {
                            Navigator.pushNamed(context, 'wifi_user_list');
                          },
                        );
                      })
                ]),
            body: StreamBuilder<DataState>(
                stream: customerProvider.customerInfo$,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox();
                  }
                  if (snapshot.data == DataState.loading) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }
                  final newCustomer = customerProvider.selectedCustomer;
                  if (newCustomer.UserID != '') {
                    contactPhoneCtrler.text = newCustomer.UserPhoneMobile;
                    pinCtrler.text = newCustomer.CustomerPin;
                    emailCtrler.text = newCustomer.UserEmail;
                  }

                  var count = 0;
                  var total = 0.0;
                  return Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              margin: const EdgeInsets.all(10),
                              child: Container(
                                width: mqWidth(context),
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Building Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      newCustomer.BuildingName,
                                    ),
                                    if (!isCreate)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10),
                                          const Text('Unit No.',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            newCustomer.UnitName,
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Account Number',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            newCustomer.CustomerID,
                                          ),
                                        ],
                                      ),
                                    if (isCreate)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Unit No.:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          dropDownUnit(customerProvider)
                                        ],
                                      ),
                                    if (messageGroupProvider.isResidentHall() &&
                                        isCreate)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Bed:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          dropDownBed(customerProvider)
                                        ],
                                      ),
                                    if (messageGroupProvider.isResidentHall() &&
                                        !isCreate)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Bed',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            customerProvider.selectedBed,
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            if (isCreate)
                              Container(
                                  width: mqWidth(context),
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Available Product Bundles:',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      const SizedBox(height: 15),
                                      dropDownAvailableProducts(
                                          customerProvider, true),
                                      // Row(
                                      //   children: [
                                      //     Checkbox(
                                      //       onChanged: (bool? newValue) {
                                      //         isAvailableInCustomers =
                                      //             !isAvailableInCustomers;
                                      //         setState(
                                      //           () {
                                      //             customerProvider
                                      //                     .selectedProductBundles =
                                      //                 customerProvider
                                      //                     .productBundles[0];
                                      //           },
                                      //         );
                                      //         // setState(() {
                                      //         //   canReply = !canReply;
                                      //         // });
                                      //       },
                                      //       value: isAvailableInCustomers,
                                      //     ),
                                      //     const Text('Available in customers'),
                                      //   ],
                                      // ),
                                    ],
                                  )),
                            if (isCreate)
                              Divider(
                                  color: isDarkMode
                                      ? Colors.black45
                                      : Colors.grey.shade100,
                                  height: 20,
                                  thickness: 10),
                            customerProvider.selectedProductBundles.Products ==
                                    null
                                ? const SizedBox()
                                : ((customerProvider.selectedProductBundles
                                            .Products!.isNotEmpty &&
                                        isCreate)
                                    ? Container(
                                        width: mqWidth(context),
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Products Included in the bundle',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 10),
                                            ...customerProvider
                                                .selectedProductBundles
                                                .Products!
                                                .map((x) {
                                              count = count + 1;
                                              total = total +
                                                  double.parse(x.ProductPrice);
                                              return Row(
                                                children: [
                                                  const SizedBox(width: 15),
                                                  const Icon(Icons.circle,
                                                      size: 5),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                      child: Text(
                                                          x.ProductName is Map
                                                              ? ''
                                                              : x.ProductName)),
                                                ],
                                              );
                                            }).toList(),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                                'Product bundle monthly price: \$${total.toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ))
                                    : const SizedBox()),
                            if (customerProvider.selectedProductBundles
                                    .Products!.isNotEmpty &&
                                isCreate)
                              Divider(
                                  color: isDarkMode
                                      ? Colors.black45
                                      : Colors.grey.shade100,
                                  height: 20,
                                  thickness: 10),
                            const SizedBox(
                              height: 10,
                            ),
                            Card(
                              margin: const EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    textFieldShared2(context,
                                        labelText: 'First Name',
                                        ctrler: firstNameCtrler,
                                        onChanged: (_) {},
                                        textColor: isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                                    textFieldShared2(context,
                                        labelText: 'Last Name',
                                        ctrler: lastNameCtrler,
                                        textColor: isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                                    textFieldShared2(context,
                                        labelText: 'Email',
                                        ctrler: emailCtrler,
                                        textColor: isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                                    textFieldShared2(context,
                                        labelText: 'Contact Phone',
                                        ctrler: contactPhoneCtrler,
                                        textColor: isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                                    textFieldShared2(context,
                                        labelText: 'PIN',
                                        ctrler: pinCtrler,
                                        textColor: isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                                    textFieldShared2(context,
                                        labelText: 'Password',
                                        ctrler: passwordCtrler,
                                        textColor: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        isObscureText: true),
                                    textFieldShared2(context,
                                        labelText: 'Confirm Password',
                                        ctrler: confirmPasswordCtrler,
                                        textColor: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        isObscureText: true),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.all(20),
                              width: mqWidth(context),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: isCreate
                                    ? WrapAlignment.center
                                    : WrapAlignment.spaceBetween,
                                runAlignment: isCreate
                                    ? WrapAlignment.center
                                    : WrapAlignment.spaceAround,
                                spacing: 10.0,
                                runSpacing: 20.0,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (isCreate) {
                                        final bedCount = customerProvider
                                                .selectedUnits.Beds
                                                .toString()
                                                .length >=
                                            26;
                                        if (messageGroupProvider
                                                .isResidentHall() &&
                                            bedCount) {
                                          showToast(
                                              'All beds are already occupied');
                                          return;
                                        }
                                        if (customerProvider
                                                .selectedUnits.UnitName ==
                                            '') {
                                          showToast('Please select a unit no.');
                                          return;
                                        }

                                        if (messageGroupProvider
                                                .isResidentHall() &&
                                            customerProvider.selectedBed ==
                                                '') {
                                          showToast('Please select a bed');
                                          return;
                                        }

                                        if (customerProvider
                                                .selectedProductBundles
                                                .GroupID ==
                                            '') {
                                          showToast(
                                              'Please select a product bundle.');
                                          return;
                                        }
                                      }
                                      if (!emailCtrler.text.contains('@') ||
                                          !emailCtrler.text.contains('.com')) {
                                        showToast('Invalid email');
                                        return;
                                      }
                                      if (passwordCtrler.text.trim() !=
                                          confirmPasswordCtrler.text.trim()) {
                                        showToast('Password did not match');
                                        return;
                                      }

                                      if (passwordCtrler.text
                                              .trim()
                                              .isNotEmpty ||
                                          confirmPasswordCtrler.text
                                              .trim()
                                              .isNotEmpty ||
                                          isCreate) {
                                        if (!isValidPassword()) {
                                          showToast(
                                              'Password must have atleast 1 big letter, atleast 8 letters and has alteast 1 special character');
                                          return;
                                        }
                                      }

                                      final json = {
                                        'buildingId':
                                            mainProvider.user.CustomerID,
                                        'server': mainProvider.server,
                                        'firstName': firstNameCtrler.text,
                                        'lastName': lastNameCtrler.text,
                                        'contactPhone': contactPhoneCtrler.text,
                                        'ctPassword': passwordCtrler.text,
                                        'email': emailCtrler.text,
                                        'pin': pinCtrler.text,
                                        'bedName': isCreate
                                            ? messageGroupProvider
                                                    .isResidentHall()
                                                ? customerProvider.selectedBed
                                                : ''
                                            : initialCustomerData.BedName,
                                        'unitName':
                                            initialCustomerData.UnitName,
                                        'productGroupId': customerProvider
                                            .selectedProductBundles.GroupID,
                                        'unitIdentifier': customerProvider
                                            .selectedUnits.UnitID
                                      };
                                      willPop = false;
                                      if (isCreate) {
                                        customerProvider
                                            .createCustomer(json, context, () {
                                          willPop = true;
                                        });

                                        return;
                                      }
                                      customerProvider
                                          .updateCustomer(json, context, () {
                                        willPop = true;
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          child: isCreate
                                              ? const Icon(Icons.add)
                                              : const Icon(Icons.update),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(isCreate ? 'Create' : 'Update')
                                      ],
                                    ),
                                  ),
                                  if (!isCreate)
                                    GestureDetector(
                                      onTap: () async {
                                        await customerProvider
                                            .setEnableOrSuspendCustomer(
                                                {'server': mainProvider.server},
                                                context);
                                      },
                                      child: StreamBuilder<bool>(
                                          stream: customerProvider.suspend$,
                                          builder: (context, snapshot) {
                                            if (snapshot.data == null) {
                                              return const SizedBox();
                                            }
                                            final suspend = snapshot.data;
                                            return Column(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor: suspend!
                                                        ? Colors.green
                                                        : Colors.red,
                                                    child: suspend
                                                        ? const Icon(
                                                            Icons.check)
                                                        : const Icon(Icons
                                                            .do_disturb_alt_outlined)),
                                                const SizedBox(height: 5),
                                                Text(suspend
                                                    ? 'Enable'
                                                    : 'Suspend')
                                              ],
                                            );
                                          }),
                                    ),
                                  if (!isCreate)
                                    GestureDetector(
                                      onTap: () async {
                                        final res = await showConfirmDialog(
                                            context,
                                            'Are you sure you want to delete this customer?');
                                        if (res) {
                                          customerProvider.removeCustomer(
                                              {'server': mainProvider.server},
                                              context);
                                        }
                                      },
                                      child: Column(
                                        children: const [
                                          CircleAvatar(
                                            backgroundColor: Colors.red,
                                            child: Icon(Icons.cancel_outlined),
                                          ),
                                          SizedBox(height: 5),
                                          Text('Delete')
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                })),
      ),
    );
  }

  Widget dropDownAvailableProducts(
      CustomerProvider provider, bool isAvailableInCustomers) {
    final selected = provider.selectedProductBundles;
    final list = provider.getFilteredProductGroup(isAvailableInCustomers);
    return PopupMenuButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              selected.GroupName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              overflow: TextOverflow.fade,
            ),
          ),
          const Icon(
            Icons.arrow_drop_down,
            color: Colors.grey,
          ),
        ],
      ),
      itemBuilder: (context) {
        return [
          ...list
              .map((e) => PopupMenuItem(
                    onTap: () => setState(() {
                      provider.selectedProductBundles = e;
                    }),
                    value: e.GroupName,
                    child: Text(e.GroupName),
                  ))
              .toList()
        ];
      },
    );
  }

  Widget dropDownBed(CustomerProvider provider) {
    final selectedUnit = provider.selectedUnits;
    if (selectedUnit.Beds == '') {
      return const SizedBox();
    }
    final list = selectedUnit.Beds;
    final selectedBed = provider.selectedBed;
    return PopupMenuButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                selectedBed,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                overflow: TextOverflow.fade,
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),
          ],
        ),
        itemBuilder: (context) {
          if (list.isEmpty) {
            showToast('No bed/s available');
            return [];
          }
          // if (!(list['BedName'] is List)) {
          //   return [
          //     PopupMenuItem(
          //         onTap: () => setState(() {}),
          //         value: list['BedName'],
          //         child: Text(list['BedName']))
          //   ];
          // }
          final currentBedList = list['BedName'] as List;
          final copyBedList = ['A', 'B', 'C', 'D', 'E'];
          copyBedList
              .removeWhere((element) => currentBedList.contains(element));
          return [
            ...copyBedList
                .map((e) => PopupMenuItem(
                    onTap: () => setState(() {
                          provider.selectedBed = e;
                          // if (e.Occupied == '1') {
                          //   provider.selectedUnits = Unit();
                          //   showToast('The unit cannot be selected');
                          //   return;
                          // }
                          // provider.selectedUnits = e;
                        }),
                    value: e,
                    child: Text(e)
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(e.UnitName),
                    //     e.Occupied == '0'
                    //         ? const Icon(Icons.circle, color: Colors.green)
                    //         : const Icon(Icons.lock, color: Colors.red)
                    //   ],
                    // ),
                    ))
                .toList()
          ];
        });
  }

  Widget dropDownUnit(CustomerProvider provider) {
    final selected = provider.selectedUnits;
    final list = provider.units;
    return PopupMenuButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              selected.UnitName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              overflow: TextOverflow.fade,
            ),
          ),
          const Icon(
            Icons.arrow_drop_down,
            color: Colors.grey,
          ),
        ],
      ),
      itemBuilder: (context) {
        return [
          ...list.map((e) {
            final isAvaialble =
                Provider.of<MessageGroupProvider>(context, listen: false)
                        .isResidentHall()
                    ? e.Beds.toString().length < 26
                    : e.Occupied == '1';
            return PopupMenuItem(
              onTap: () => setState(() {
                if (!isAvaialble) {
                  provider.selectedUnits = Unit();
                  showToast('The unit cannot be selected');
                  return;
                }
                provider.selectedUnits = e;
                provider.selectedBed = '';
              }),
              value: e.UnitName,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e.UnitName),
                  isAvaialble
                      ? const Icon(Icons.circle, color: Colors.green)
                      : const Icon(Icons.lock, color: Colors.red)
                ],
              ),
            );
          }).toList()
        ];
      },
    );
  }
}
