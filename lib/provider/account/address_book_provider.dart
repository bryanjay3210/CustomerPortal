import 'package:cp/enum.dart';
import 'package:cp/model/address_book/address_book.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import '../../repository/account/address_book_repository.dart';

class AddressBookProvider {
  final addressBookListState =
      BehaviorSubject<DataState>.seeded(DataState.initial);
  var addressBookList = <AddressBook>[];

  getAddressBook(Map<String, dynamic> map, BuildContext context) async {
    addressBookListState.add(DataState.loading);
    addressBookList.clear();
    Map<String, dynamic> data =
        await AddressBookRepository(map['server']).getAddressBook(map);
    if(data['Status'] == 'Success'){
      if(data['Book'] is Map){
        addressBookList.add(AddressBook.fromJson(data['Book']));
      }
      else if(data['Book'] is List<dynamic>) {
        data['Book'].forEach((element) => addressBookList.add(AddressBook.fromJson(element)));
      }
      addressBookListState.add(DataState.success);
    }
    else {
      addressBookListState.add(DataState.success);
    }
  }
}
