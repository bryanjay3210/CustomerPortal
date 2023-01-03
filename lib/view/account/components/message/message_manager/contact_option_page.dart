import 'package:cp/model/contact_provider/contact_provider.dart';
import 'package:cp/provider/manager/contact_option_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../enum.dart';
import '../../../../../model/customer_message_group/customer_message_group.dart';
import '../../../../../provider/account/message_manager/message_group.dart';
import '../../../../../provider/main_provider.dart';
import '../../../../../shared_widgets/toasts.dart';
import '../../../../../utils/utils/theme/global_colors.dart';

class ContactOptionPage extends StatefulWidget {
  const ContactOptionPage({Key? key}) : super(key: key);

  @override
  _ContactOptionPageState createState() => _ContactOptionPageState();
}

class _ContactOptionPageState extends State<ContactOptionPage> {
  var isLoading = true;
  var isInAppDelivery = false;
  var isEmailDelivery = false;
  var isSmsDelivery = false;
  final messageCtrler = TextEditingController();
  var isManager = false;

  @override
  void initState() {
    super.initState();
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    isManager = mainProvider.isManager();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final messageGroupProvider =
          Provider.of<MessageGroupProvider>(context, listen: false);
      final contactOptionProvider =
          Provider.of<ContactOptionProvider>(context, listen: false);

      await contactOptionProvider.getProviders({}, context);
      if (isManager) {
        contactOptionProvider.currentCustomer = CustomerMessageGroup();
        contactOptionProvider.currentProvider = ContactProvider();
        await messageGroupProvider.getCustomers({}, context);
      } else {
        await contactOptionProvider.getContactOption(
            {'customerId': mainProvider.user.CustomerID}, context, () {
          final provider = contactOptionProvider.currentProvider;
          isEmailDelivery = provider.MessageEmail == "Y";
          isInAppDelivery = provider.MessageApp == "Y";
          isSmsDelivery = provider.MessageSMS == "Y";
        });
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final isDarkMode = mainProvider.isDarkMode;
    final messageGroupProvider =
        Provider.of<MessageGroupProvider>(context, listen: false);
    final contactOptionProvider =
        Provider.of<ContactOptionProvider>(context, listen: false);
    return isLoading
        ? Scaffold(
            backgroundColor:
                mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
            body: const SizedBox(
                child: Center(child: CircularProgressIndicator.adaptive())),
          )
        : Scaffold(
            backgroundColor:
                mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // // Container(
                    // //   color: const Color(0xff30313A),
                    // //   width: double.infinity,
                    // //   height: 130,
                    // //   child: Padding(
                    // //     padding: const EdgeInsets.only(left: 20, top: 20),
                    // //     child: Column(
                    // //       crossAxisAlignment: CrossAxisAlignment.start,
                    // //       children: [
                    // //         const SizedBox(
                    // //           height: 20,
                    // //         ),
                    // //         GestureDetector(
                    // //             onTap: () => Navigator.of(context).pop(),
                    // //             child: const Icon(Icons.arrow_back_ios,
                    // //                 color: cpWhiteColor)),
                    // //         const SizedBox(height: 30),
                    // //         const Text(
                    // //           'Contact Option',
                    // //           style: TextStyle(
                    // //               fontWeight: FontWeight.bold,
                    // //               fontSize: 25,
                    // //               color: cpWhiteColor),
                    // //         ),
                    // //       ],
                    // //     ),
                    // //   ),
                    // // ),
                    // if (isManager) const SizedBox(height: 15),
                    if (isManager)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Building Name',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Text(
                              messageGroupProvider.currentBuilding.BuildingName,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    if (isManager) const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isManager) const Text('Select Customer'),
                          if (isManager) const SizedBox(height: 5),
                          if (isManager)
                            DropdownSearch<CustomerMessageGroup>(
                                popupProps: const PopupPropsMultiSelection.menu(
                                  showSearchBox: true,
                                ),
                                itemAsString: (CustomerMessageGroup b) =>
                                    b.Name,
                                items: messageGroupProvider.customerPopupSearch,
                                onChanged: ((value) async {
                                  if (value == null) {
                                    return;
                                  }
                                  contactOptionProvider.currentCustomer = value;
                                  await contactOptionProvider.getContactOption({
                                    'customerId': contactOptionProvider
                                        .currentCustomer.CustomerID
                                  }, context, () {
                                    final provider =
                                        contactOptionProvider.currentProvider;
                                    // if(provider.ProviderID is Map) {

                                    // }
                                    isEmailDelivery =
                                        provider.MessageEmail == "Y";
                                    isInAppDelivery =
                                        provider.MessageApp == "Y";
                                    isSmsDelivery = provider.MessageSMS == "Y";
                                  });
                                }),
                                selectedItem:
                                    contactOptionProvider.currentCustomer),
                          const SizedBox(height: 25),

                          //start
                          StreamBuilder<ButtonState>(
                              stream: contactOptionProvider.getCustomerInfo$,
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return const SizedBox();
                                }

                                if (snapshot.data == ButtonState.loading) {
                                  return Center(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text('Fetching Customer Data'),
                                          SizedBox(height: 10),
                                          CircularProgressIndicator.adaptive()
                                        ]),
                                  );
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxHeight: 40),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            onChanged: (bool? newValue) {
                                              setState(() {
                                                isInAppDelivery =
                                                    !isInAppDelivery;
                                              });
                                            },
                                            value: isInAppDelivery,
                                          ),
                                          const Text('In-app Delivery'),
                                        ],
                                      ),
                                    ),
                                    ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxHeight: 40),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            onChanged: (bool? newValue) {
                                              setState(() {
                                                isEmailDelivery =
                                                    !isEmailDelivery;
                                              });
                                            },
                                            value: isEmailDelivery,
                                          ),
                                          const Text('Email Delivery'),
                                        ],
                                      ),
                                    ),
                                    ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxHeight: 40),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            onChanged: (bool? newValue) {
                                              setState(() {
                                                isSmsDelivery = !isSmsDelivery;
                                              });
                                            },
                                            value: isSmsDelivery,
                                          ),
                                          const Text('SMS Delivery'),
                                        ],
                                      ),
                                    ),
                                    if (isSmsDelivery)
                                      const SizedBox(height: 10),
                                    if (isSmsDelivery)
                                      const Text('Select Cell Provider'),
                                    const SizedBox(height: 5),
                                    if (isSmsDelivery)
                                      DropdownSearch<ContactProvider>(
                                          popupProps: PopupPropsMultiSelection.menu(
                                              showSearchBox: true,
                                              constraints: BoxConstraints(
                                                  maxHeight: contactOptionProvider
                                                              .providers
                                                              .length <
                                                          5
                                                      ? ((contactOptionProvider
                                                                  .providers
                                                                  .length *
                                                              55) +
                                                          80)
                                                      : 350)),
                                          itemAsString: (ContactProvider b) =>
                                              b.ProviderName is Map
                                                  ? ''
                                                  : b.ProviderName,
                                          items:
                                              contactOptionProvider.providers,
                                          onChanged: ((value) {
                                            if (value == null) {
                                              return;
                                            }
                                            contactOptionProvider
                                                .currentProvider = value;
                                          }),
                                          selectedItem: contactOptionProvider
                                              .currentProvider),
                                    const SizedBox(height: 35),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              if (contactOptionProvider
                                                          .currentCustomer
                                                          .CustomerID ==
                                                      '' &&
                                                  isManager) {
                                                showToast('Customer is empty');
                                                return;
                                              }
                                              if (isSmsDelivery) {
                                                if (contactOptionProvider
                                                            .currentProvider
                                                            .ProviderID ==
                                                        '' ||
                                                    contactOptionProvider
                                                        .currentProvider
                                                        .ProviderName is Map) {
                                                  showToast(
                                                      'Cell provider is empty');
                                                  return;
                                                }
                                              }

                                              setState(() {
                                                isLoading = true;
                                              });

                                              contactOptionProvider
                                                  .createContactOption(
                                                      {
                                                    'inAppDelivery':
                                                        isInAppDelivery
                                                            ? 'Y'
                                                            : 'N',
                                                    'emailDelivery':
                                                        isEmailDelivery
                                                            ? 'Y'
                                                            : 'N',
                                                    'smsDelivery': isSmsDelivery
                                                        ? 'Y'
                                                        : 'N',
                                                    'residentId': isManager
                                                        ? contactOptionProvider
                                                            .currentCustomer
                                                            .CustomerID
                                                        : mainProvider
                                                            .user.CustomerID
                                                  },
                                                      context,
                                                      () => setState(() {
                                                            isLoading = false;
                                                          }));
                                            },
                                            child: const Text(
                                                'Store Contact Option'),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(cpPrimaryColor),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                )))),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                                '       Cancel       '),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.grey.shade500),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                )))),
                                      ],
                                    ),
                                    //end
                                  ],
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
