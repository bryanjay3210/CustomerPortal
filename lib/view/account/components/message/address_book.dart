import 'package:cp/enum.dart';
import 'package:cp/model/address_book/address_book.dart';
import 'package:cp/provider/main_provider.dart';
import 'package:cp/utils/utils/theme/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../provider/account/address_book_provider.dart';

class AddressBook extends StatefulWidget {
  const AddressBook({Key? key}) : super(key: key);

  @override
  State<AddressBook> createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBook> {
  @override
  void initState() {
    final addressBookProvider =
        Provider.of<AddressBookProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    addressBookProvider.getAddressBook({
      'buildingId': mainProvider.user.BuildingID,
      'server': mainProvider.server,
      'userId': mainProvider.user.UserID,
    }, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addressBookProvider =
        Provider.of<AddressBookProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
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
                    'Address Book',
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
              color: mainProvider.darkTheme ? cpDarkBgColor : cpWhiteColor,
              padding: const EdgeInsets.all(10),
              child: StreamBuilder(
                stream: addressBookProvider.addressBookListState,
                builder: (context, snapshot) {
                  if (snapshot.data == DataState.success &&
                      addressBookProvider.addressBookList.isEmpty) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/account/no_contact_logo.png',
                          height: 150,
                          width: 150,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('No contact in your address book.',
                            style: TextStyle(fontSize: 13)),
                      ],
                    ));
                  }
                  if (snapshot.data == DataState.success &&
                      addressBookProvider.addressBookList.isNotEmpty) {
                    var addressBook = addressBookProvider.addressBookList;
                    return Scrollbar(
                      child: ListView.builder(
                        itemCount: addressBook.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/account/contact_logo.svg'),
                                    const SizedBox(width: 10),
                                    Text(
                                      addressBook[index].Recipient,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                  thickness: 1, indent: 10, endIndent: 10),
                            ],
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
