import 'package:cp/enum.dart';
import 'package:cp/model/message/message.dart';
import 'package:cp/shared_widgets/toasts.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../repository/account/message_repository.dart';
import 'address_book_provider.dart';

class MessageProvider {
  final messageListState = BehaviorSubject<DataState>.seeded(DataState.initial);
  var messageList = <MessageModel>[];
  List<String> messageStatus = [];

  getMessage(Map<String, dynamic> map, BuildContext context) async {
    messageListState.add(DataState.loading);
    messageList.clear();
    Map<String, dynamic> data =
        await MessageRepository(map['server']).getMessages(map);
    if (data['Status'] == 'Success') {
      if(data['Message'] is List<dynamic>){
        data['Message'].forEach((element) => messageList.add(MessageModel.fromJson(element)));
      } else if(data['Message'] is Map){
        messageList.add(MessageModel.fromJson(data['Message']));
      }
      messageListState.add(DataState.success);
    }
    else {
      messageListState.add(DataState.success);
    }
    messageList.sort((a, b) => b.MessageDate.compareTo(a.MessageDate),);
  }

  sendMessage(Map<String, dynamic> map, BuildContext context) async {
    messageListState.add(DataState.loading);
    messageStatus.clear();
    final addressBookProvider =
        Provider.of<AddressBookProvider>(context, listen: false);
    List<String> recipient = map['recipient'] as List<String>;
    messageList.clear();
    for (var ds in recipient) {
      var addressBook = addressBookProvider.addressBookList
          .firstWhere((element) => element.Recipient == ds);
      map.update('targetID', (value) => addressBook.TargetID);
      Map<String, dynamic> data =
          await MessageRepository(map['server']).sendMessages(map);
      if (data['Status'] == 'Success') {
        showToast('Message sent!');
        // messageStatus.add('$ds message send successfully! \n');
      } else {
        showToast('Message fail!');
        // messageStatus.add('$ds message failed to send! \n');
      }
    }
    messageListState.add(DataState.success);
  }

  changeMessageStatus(Map<String, dynamic> map, BuildContext context) async {
    messageListState.add(DataState.loading);
    Map<String, dynamic> data =
        await MessageRepository(map['server']).changeMessageStatus(map);
    // if(data['Status'] == 'Success'){
    //
    // }
    messageListState.add(DataState.success);
  }
}
