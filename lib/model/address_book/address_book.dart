import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'address_book.freezed.dart';
part 'address_book.g.dart';

@freezed
class AddressBook with _$AddressBook {
  factory AddressBook({
    @Default('') dynamic Recipient,
    @Default('') dynamic TargetID,
  }) = _AddressBook;

  factory AddressBook.fromJson(Map<String, dynamic> json) => _$AddressBookFromJson(json);
}


